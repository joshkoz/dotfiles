return {
  "simrat39/rust-tools.nvim",
  event = "BufRead",
  -- Is configured via the server_registration_override installed below!
  opts = {
    setup = {
      rust_analyzer = function(_, opts)
        require("rust-tools").setup {
          tools = {
            hover_actions = {
              auto_focus = false,
              border = "none",
            },
            inlay_hints = {
              auto = false,
              show_parameter_hints = true,
            },
          },
          server = vim.tbl_deep_extend("force", opts, {
            settings = {
              ["rust-analyzer"] = {
                cargo = {
                  features = "all",
                },
                -- Add clippy lints for Rust.
                checkOnSave = true,
                check = {
                  command = "clippy",
                  features = "all",
                },
                procMacro = {
                  enable = true,
                },
              },
            },
          }),
        }
        return true
      end,
    },
  },
}
