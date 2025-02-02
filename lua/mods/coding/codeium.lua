-- return {
--     "monkoose/neocodeium",
--     event = "VeryLazy",
--     config = function()
--         local neocodeium = require("neocodeium")
--         neocodeium.setup()
--         vim.keymap.set("i", "<leader>j", neocodeium.accept)
--     end,
-- }

return {
    "Exafunction/codeium.nvim",
    cmd = "Codeium",
    event = "InsertEnter",
    build = ":Codeium Auth",
    opts = {
        enable_cmp_source = false,
        virtual_text = {
            enabled = true,
            key_bindings = {
                accept = "<Tab>", -- handled by nvim-cmp / blink.cmp
                next = "<M-]>",
                prev = "<M-[>",
            },
        },
    },
}
