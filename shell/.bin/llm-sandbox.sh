#!/usr/bin/env bash

# --- Configuration ---
PROJECT_ROOT="$(pwd)"
SANDBOX_DIR="$PROJECT_ROOT/.sandbox_data"
TARGET_MODEL="openai/gpt-5.2-codex"
PRIMARY_REPO_DIR="$PROJECT_ROOT/primary-repo"

# --- Function: Init ---
init_sandbox() {
    local repo_url=$1
    if [ -z "$repo_url" ]; then
        echo "Usage: ./llm-sandbox.sh init <git-repo-url>"
        exit 1
    fi

    echo "🏗️  Initializing LLM Sandbox..."
    mkdir -p "$PRIMARY_REPO_DIR" "$SANDBOX_DIR"/{branches,nuget_cache} "$PROJECT_ROOT/sessions"

    if [ ! -d "$PRIMARY_REPO_DIR/.git" ]; then
        git clone "$repo_url" "$PRIMARY_REPO_DIR"
    fi

    cat <<EOF > .gitignore
.sandbox_data/
sessions/
sandbox.Dockerfile
EOF

    cat <<EOF > sandbox.Dockerfile
FROM mcr.microsoft.com/dotnet/sdk:9.0-alpine
RUN apk add --no-cache git bash curl icu-libs krb5-libs libgcc libintl libssl3 libstdc++ zlib unzip ripgrep fd jq nodejs npm
RUN addgroup -g $(id -g) devgroup && adduser -u $(id -u) -G devgroup -D devuser
RUN mkdir -p /home/devuser/.local/share/opencode /home/devuser/.config/opencode /home/devuser/.nuget/packages /work && \\
    chown -R devuser:devgroup /home/devuser /work
RUN curl -fsSL https://opencode.ai/install | bash && \\
    mv /root/.opencode/bin/opencode /usr/local/bin/opencode
WORKDIR /work
USER devuser
EOF
    echo "✅ Setup complete."
}

# --- Function: List ---
list_sessions() {
    echo -e "ID\t\t\tSTATUS\t\tBRANCH"
    echo "----------------------------------------------------------------"
    docker ps -a --filter "label=llm-sandbox-project=$PROJECT_ROOT" --format "{{.ID}}\t{{.Status}}\t{{.Names}}" | sed 's/opencode-//'
}

# --- Function: Cleanup ---
cleanup_branch() {
    local branch=$1
    if [ -z "$branch" ]; then
        echo "Usage: ./llm-sandbox.sh cleanup <branch-name>"
        exit 1
    fi

    # FIX: Logic matches main execution block
    local safe=$(echo "$branch" | sed 's/\//-/g')
    local container="opencode-$safe"
    local session_path="$PROJECT_ROOT/sessions/$safe"
    local storage_path="$SANDBOX_DIR/branches/$safe"

    echo "🧹 Cleanup Menu for branch: $branch"
    echo "---------------------------------------"
    echo "1) 🛑 Stop & Remove Container (Safe: keeps code & memory)"
    echo "2) 🔥 Delete Worktree/Code (Removes sessions/$safe)"
    echo "3) 🧠 Wipe AI Memory (Resets branch state)"
    echo "4) 🧨 Full Purge (Does all of the above)"
    echo "q) Cancel"
    echo "---------------------------------------"
    read -p "Select an option [1-4, q]: " choice

    case $choice in
        1) 
            docker rm -f "$container" >/dev/null 2>&1
            echo "✅ Container stopped."
            ;;
        2) 
            git -C "$PRIMARY_REPO_DIR" worktree remove --force "$session_path" 2>/dev/null
            rm -rf "$session_path"
            echo "✅ Worktree deleted."
            ;;
        3) 
            rm -rf "$storage_path"
            echo "✅ AI memory wiped."
            ;;
        4) 
            docker rm -f "$container" >/dev/null 2>&1
            git -C "$PRIMARY_REPO_DIR" worktree remove --force "$session_path" 2>/dev/null
            rm -rf "$session_path"
            rm -rf "$storage_path"
            echo "✅ Full purge complete."
            ;;
        *) 
            echo "Cancelled."
            return
            ;;
    esac
    git -C "$PRIMARY_REPO_DIR" worktree prune
}

# --- Command Routing ---
case "$1" in
    init) init_sandbox "$2"; exit 0 ;;
    list) list_sessions; exit 0 ;;
    cleanup)
        if [[ "$2" == "--all" ]]; then
            read -p "⚠️  Are you sure you want to stop all containers and remove all worktrees? (y/N): " confirm
            [[ "$confirm" != [yY] ]] && exit 1
            
            for c in $(docker ps -a --filter "label=llm-sandbox-project=$PROJECT_ROOT" --format "{{.Names}}"); do
                bname=${c#opencode-}
                cleanup_branch "$bname"
            done
            git -C "$PRIMARY_REPO_DIR" worktree prune
            echo "✨ All sessions cleared."
        else
            cleanup_branch "$2"
        fi
        exit 0 ;;
esac

# --- Execution Logic ---
BRANCH_INPUT=$1
[ -z "$BRANCH_INPUT" ] && { echo "Usage: ./llm-sandbox.sh <branch> [--shell] | list | cleanup <branch|--all> | init <repo>"; exit 1; }

SAFE_NAME=$(echo "$BRANCH_INPUT" | sed 's/\//-/g')
CONTAINER_NAME="opencode-$SAFE_NAME"
SESSION_HOST_PATH="$PROJECT_ROOT/sessions/$SAFE_NAME"
SESSION_CONTAINER_PATH="/work/sessions/$SAFE_NAME"

# 1. Reconnect Logic
if docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "🟢 Session '$CONTAINER_NAME' is active. Reconnecting..."
    docker exec -it "$CONTAINER_NAME" /bin/bash
    exit 0
fi

# 2. Cleanup "Ghost" Containers
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    docker rm -f "$CONTAINER_NAME" >/dev/null
fi

# 3. Build & Worktree 
docker build -t opencode-sandbox -f sandbox.Dockerfile .
git -C "$PRIMARY_REPO_DIR" worktree prune

# FIX: Force host ownership of the sessions directory
mkdir -p "$PROJECT_ROOT/sessions"
# Only chown if we aren't the owner (prevents unnecessary sudo prompts)
if [ ! -w "$PROJECT_ROOT/sessions" ]; then
    echo "🔐 Fixing directory permissions..."
    sudo chown -R $(id -u):$(id -g) "$PROJECT_ROOT/sessions"
fi

if [ ! -d "$SESSION_HOST_PATH" ] || [ -z "$(ls -A "$SESSION_HOST_PATH")" ]; then
    echo "🌿 Setting up worktree for $BRANCH_INPUT..."
    
    [ -d "$SESSION_HOST_PATH" ] && rm -rf "$SESSION_HOST_PATH"
    git -C "$PRIMARY_REPO_DIR" fetch origin --quiet

    if git -C "$PRIMARY_REPO_DIR" show-ref --verify --quiet "refs/heads/$BRANCH_INPUT"; then
        echo "🏠 Using existing local branch..."
        git -C "$PRIMARY_REPO_DIR" worktree add "$SESSION_HOST_PATH" "$BRANCH_INPUT"
    elif git -C "$PRIMARY_REPO_DIR" show-ref --verify --quiet "refs/remotes/origin/$BRANCH_INPUT"; then
        echo "🌐 Tracking remote branch..."
        git -C "$PRIMARY_REPO_DIR" worktree add "$SESSION_HOST_PATH" --track -b "$BRANCH_INPUT" "origin/$BRANCH_INPUT"
    else
        echo "✨ Creating new branch..."
        git -C "$PRIMARY_REPO_DIR" worktree add "$SESSION_HOST_PATH" -b "$BRANCH_INPUT"
    fi
fi

# 4. Persistence Setup
BRANCH_STORAGE="$SANDBOX_DIR/branches/$SAFE_NAME"
mkdir -p "$BRANCH_STORAGE/project" "$BRANCH_STORAGE/log"

# Create a temporary .git file that uses container-internal paths
# This stays in the sandbox_data so it doesn't clutter your repo
GIT_OVERLAY_FILE="$BRANCH_STORAGE/.git_container_overlay"
echo "gitdir: /work/primary-repo/$(git -C "$PRIMARY_REPO_DIR" rev-parse --git-common-dir)/worktrees/$SAFE_NAME" > "$GIT_OVERLAY_FILE"

# 5. Docker Run
opts=(
    -it --rm
    --name "$CONTAINER_NAME"
    --label "llm-sandbox-project=$PROJECT_ROOT"
    -e LOG_LEVEL=WARN
    # Security: Tell git to trust the mount
    -e GIT_CONFIG_COUNT=1
    -e GIT_CONFIG_KEY_0="safe.directory"
    -e GIT_CONFIG_VALUE_0="*"
    -v "$PROJECT_ROOT:/work"
    -w "$SESSION_CONTAINER_PATH"
    # THE MAGIC: Mount the overlay file over the real .git file
    -v "$GIT_OVERLAY_FILE:$SESSION_CONTAINER_PATH/.git"
    -v "$BRANCH_STORAGE:/home/devuser/.local/share/opencode"
    -v "$SANDBOX_DIR/nuget_cache:/home/devuser/.nuget/packages"
    -v "$HOME/.local/share/opencode/auth.json:/home/devuser/.local/share/opencode/auth.json:ro"
)

if [[ "$2" == "--shell" ]]; then
    docker run "${opts[@]}" --entrypoint /bin/bash opencode-sandbox
else
    echo "🚀 Launching $TARGET_MODEL..."
    docker run "${opts[@]}" opencode-sandbox opencode . --model "$TARGET_MODEL"
fi
