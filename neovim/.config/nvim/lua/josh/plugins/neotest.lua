return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "Issafalcon/neotest-dotnet",
  },
  config = function()
    local neotest = require("neotest")
    ---@diagnostic disable-next-line: missing-fields
    neotest.setup({
      adapters = {
        require("neotest-dotnet")({
          dap = {
            -- Extra arguments for nvim-dap configuration
            -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
            args = { justMyCode = false },
            -- Enter the name of your dap adapter, the default value is netcoredbg
            adapter_name = "netcoredbg",
          },
          -- Let the test-discovery know about your custom attributes (otherwise tests will not be picked up)
          -- Note: Only custom attributes for non-parameterized tests should be added here. See the support note about parameterized tests
          -- Provide any additional "dotnet test" CLI commands here. These will be applied to ALL test runs performed via neotest. These need to be a table of strings, ideally with one key-value pair per item.
          dotnet_additional_args = {
            -- "--verbosity detailed",
          },
          -- Tell neotest-dotnet to use either solution (requires .sln file) or project (requires .csproj or .fsproj file) as project root
          -- Note: If neovim is opened from the solution root, using the 'project' setting may sometimes find all nested projects, however,
          --       to locate all test projects in the solution more reliably (if a .sln file is present) then 'solution' is better.
          discovery_root = "solution", -- Default
        }),
      },
    })

    vim.keymap.set("n", "<leader>to", neotest.summary.toggle, { silent = true, noremap = true, desc = "Toggle Test Panel" })
    vim.keymap.set("n", "<leader>th", function()
      neotest.output.open({ enter = true })
    end, { silent = true, noremap = true, desc = "Open Test Output Hover" })
    vim.keymap.set("n", "<leader>tt", neotest.run.run, { silent = true, noremap = true, desc = "Run Nearest Test" })
    vim.keymap.set("n", "<leader>tf", function()
      neotest.run.run(vim.fn.expand("%"))
    end, { silent = true, noremap = true, desc = "Run Tests in file" })
    vim.keymap.set("n", "<leader>tl", neotest.run.run_last, { silent = true, noremap = true, desc = "Run Last Test" })
    vim.keymap.set("n", "<leader>tw", neotest.watch.toggle, { silent = true, noremap = true, desc = "Toggle Test Watch" })
  end,
}
