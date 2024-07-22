return {
    "mfussenegger/nvim-dap",

    dependencies = {
        {
            "rcarriga/nvim-dap-ui",
            dependencies = { "nvim-neotest/nvim-nio" },
            -- stylua: ignore
            keys = {
                { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
                { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
            },
            opts = {},
            config = function(_, opts)
                local dap = require("dap")
                local dapui = require("dapui")
                dapui.setup(opts)
                dap.listeners.after.event_initialized["dapui_config"] = function()
                    dapui.open({})
                    vim.cmd('NvimTreeClose')
                end
                dap.listeners.before.event_terminated["dapui_config"] = function()
                    dapui.close({})
                end
                dap.listeners.before.event_exited["dapui_config"] = function()
                    dapui.close({})
                end
            end,

        },
        -- virtual text for the debugger
        {
            "theHamsta/nvim-dap-virtual-text",
            opts = {},
        },
    },

    -- stylua: ignore
    keys = {
        { "<leader>d",  "",                                                desc = "+debug",           mode = { "n", "v" } },
        { "<leader>dc", function() require("dap").continue() end,          desc = "Continue" },
        { "<F5>",       function() require("dap").run_last() end,          desc = "Run Last" },
        { "<F8>",       function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
        { "<F9>",       function() require("dap").run_to_cursor() end,     desc = "Run to Cursor" },
        { "<F10>",      function() require("dap").step_over() end,         desc = "Step Over" },
        { "<F11>",      function() require("dap").step_into() end,         desc = "Step Into" },
        { "<F12>",      function() require("dap").step_out() end,          desc = "Step Out" },
        -- { "<leader>dp", function() require("dap").pause() end,             desc = "Pause" },
        -- { "<leader>dr", function() require("dap").repl.toggle() end,       desc = "Toggle REPL" },
        -- { "<leader>ds", function() require("dap").session() end,           desc = "Session" },
        { "<F4>",       function() require("dap").terminate() end,         desc = "Terminate" },
    },

    config = function()
        -- load mason-nvim-dap here, after all adapters have been setup
        -- vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

        -- setup dap config by VsCode launch.json file
        -- local vscode = require("dap.ext.vscode")
        -- local json = require("plenary.json")
        -- vscode.json_decode = function(str)
        --     return vim.json.decode(json.json_strip_comments(str))
        -- end

        local dap = require 'dap'
        dap.adapters.php = {
            type = 'executable',
            command = 'node',
            args = { '/Users/khanhicetea/tool/vscode-php-debug/out/phpDebug.js' }
        }
        dap.configurations.php = {
            {
                type = 'php',
                request = 'launch',
                name = 'Listen for xdebug',
                port = '9003',
                log = false,
            },
        }
    end,
}
