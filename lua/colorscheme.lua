-- define your colorscheme here
-- local colorscheme = 'monokai_pro'

-- local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- if not is_ok then
    --vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    -- return
-- end


local colorscheme = "tokyonight"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " 没有找到！")
  return
end

