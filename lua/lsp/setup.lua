
local status, mason = pcall(require, "mason")
if not status then
  vim.notify("没有找到 mason")
  return
end

local status, mason_config = pcall(require, "mason-lspconfig")
if not status then
  vim.notify("没有找到 mason-lspconfig")
  return
end

local status, lspconfig = pcall(require, "lspconfig")
if not status then
  vim.notify("没有找到 lspconfig")
  return
end


mason.setup({
     ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})


mason_config.setup({
    -- A list of servers to automatically install if they're not already installed
    ensure_installed = { 'pylsp', 'gopls', 'lua_ls', 'rust_analyzer', 'bashls' },
})


-- 安装列表
-- { key: 服务器名， value: 配置文件 }
-- key 必须为下列网址列出的 server name，不可以随便写
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
--  sumneko_lua = require("lsp.config.lua"), -- lua/lsp/config/lua.lua
  -- bashls = require("lsp.config.bash"),
 -- pyright = require("lsp.config.pyright"),
 --  html = require("lsp.config.html"),
  -- cssls = require("lsp.config.css"),
  -- emmet_ls = require("lsp.config.emmet"),
  -- jsonls = require("lsp.config.json"),
  -- tsserver = require("lsp.config.typescript"),
  -- yamlls = require("lsp.config.yamlls"),
  -- dockerls = require("lsp.config.docker"),
  -- tailwindcss = require("lsp.config.tailwindcss"),
  rust_analyzer = require("lsp.config.rust"),
  -- taplo = require("lsp.config.taplo"), -- toml
  --gopls = require("lsp.config.gopls"),
  -- remark_ls = require("lsp.config.markdown"),
  -- clangd = require("lsp.config.clangd"),
  -- cmake = require("lsp.config.cmake"),
}

for name, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    -- 自定义初始化配置文件必须实现on_setup 方法
    config.on_setup(lspconfig[name])
  else
    -- 使用默认参数
    lspconfig[name].setup({})
  end
end


