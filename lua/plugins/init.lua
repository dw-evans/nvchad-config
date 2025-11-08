return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-neotest/nvim-nio",
  },


  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      -- local dap_python = require("dap-python")
      -- dap.setup()
      local map = vim.keymap.set
      map("n", "<leader>db", dap.toggle_breakpoint)
      map("n", "<leader>dc", dap.continue)

      require("dapui").setup({})
      map("n", "<leader>du", dapui.toggle)

      -- require("core.utils").load_mappings("dap")
    end,
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      -- local dap = require("dap")
      local dap_python = require("dap-python")

      dap_python.setup(path)
      -- local map = vim.keymap.set

    end,
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
      ensure_installed = {},
      event = "VeryLazy",
    },
  },


  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      local dapui = require("dapui")
      local dap = require("dap")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.after.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.after.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
      local registry = require("mason-registry")

      for _, pkg_name in ipairs { 
        "stylua", 
        "prettier",
        "debugpy",
        "ruff",
        "black",
        "clangd",
        "pyright",
        "codelldb",
        "clang-format",
      } do
        local ok, pkg = pcall(registry.get_package, pkg_name)
        if ok then
          if not pkg:is_installed() then
             pkg:install()
          end
        end
      end
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",
          "clangd",
        },
      })
    end,
  },


  -- test new blink
  { import = "nvchad.blink.lazyspec" },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"python", "c", "markdown", "bash", "cpp", "json",
        "javascript", 
        "vim", "lua", "vimdoc",
  	    "html", "css"
  		},
  	},
  },
}
