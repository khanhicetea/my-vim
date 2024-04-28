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
