-- Caffee : Vietnamese Input Helper
local SendMsgToSocket = function()
    local file = io.open("/tmp/caffee_switch", "a")
    if file ~= nil then
        file:write("en\n")
        file:close()
    end
end

vim.api.nvim_create_autocmd("ModeChanged", {
    group = vim.api.nvim_create_augroup("SendMsgOnNormalMode", { clear = true }),
    pattern = "*:n",
    callback = function()
        pcall(SendMsgToSocket)
    end,
})

-- Terminal
-- Switch to insert mode when terminal is open
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
    -- TermOpen: for when terminal is opened for the first time
    -- BufEnter: when you navigate to an existing terminal buffer
    group = vim.api.nvim_create_augroup("Terminal", { clear = true }),
    pattern = "term://*", --> only applicable for "BufEnter", an ignored Lua table key when evaluating TermOpen
    callback = function()
        vim.cmd("startinsert")
    end
})
