-- define common options
vim.g.mapleader=","
vim.g.maplocalleader=","
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}

-----------------
-- Normal mode --
-----------------
--
--
vim.keymap.set('n' , '<leader>n' , ':NvimTreeToggle<CR>' , opts)
vim.keymap.set('n' , '<leader>q' , ':q!<CR>' , opts)
vim.keymap.set('n' , '<A-l>' , 'gg=G' , opts)
vim.keymap.set('n' , '<C-a>' , '<Home>' , opts)
vim.keymap.set('i' , '<C-a>' , '<Home>' , opts)
vim.keymap.set('n' , '<C-e>' , '<End>' , opts)
vim.keymap.set('i' , '<C-e>' , '<End>' , opts)

-- Hint: see `:h vim.map.set()`
-- Better window navigation

-- Resize with arrows
-- delta: 2 lines
-- vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
-- vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
-- vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
-- vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
-- vim.keymap.set('v', '<', '<gv', opts)
-- vim.keymap.set('v', '>', '>gv', opts)
 
vim.keymap.set("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
vim.keymap.set("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
-- 关闭
--"moll/vim-bbye"
vim.keymap.set("n", "<leader>wq", ":Bdelete!<CR>", opt)
-- vim.keymap.set("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
-- vim.keymap.set("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
-- vim.keymap.set("n", "<leader>bc", ":BufferLinePickClose<CR>", opt)

vim.keymap.set("n", "<leader>s" , ":Telescope find_files<CR>", opt)
vim.keymap.set("n", "<A-o>" , ":Telescope find_files<CR>", opt)
vim.keymap.set("n", "<leader>f" , ":Telescope live_grep<CR>", opt)
vim.keymap.set("n", "<A-S-f>" , ":Telescope live_grep<CR>", opt)


local pluginKeys ={}
pluginKeys.telescopeList = {
  i = {
    -- 上下移动
    ["<C-j>"] = "move_selection_next",
    ["<C-k>"] = "move_selection_previous",
    ["<Down>"] = "move_selection_next",
    ["<Up>"] = "move_selection_previous",
    -- 历史记录
    ["<C-n>"] = "cycle_history_next",
    ["<C-p>"] = "cycle_history_prev",
    -- 关闭窗口
    ["<C-c>"] = "close",
    -- 预览窗口上下滚动
    ["<C-u>"] = "preview_scrolling_up",
    ["<C-d>"] = "preview_scrolling_down",
  },
}


-- lsp 回调函数快捷键设置
pluginKeys.mapLSP = function(mapbuf)
  -- rename
  mapbuf("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
  -- code action
  mapbuf("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
  -- go xx
  mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
  mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
  mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
  mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
  mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
  -- diagnostic
  mapbuf("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
  mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
  mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
  -- mapbuf("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)
  -- 没用到
  -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
  -- mapbuf("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
  -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
  -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
end


-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
    return {
        -- 出现补全
        ["<A-p>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
        -- 取消
        --["<A-,>"] = cmp.mapping({
         --   i = cmp.mapping.abort(),
          --  c = cmp.mapping.close()
        -- }),
        -- 上一个
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        -- 下一个
        ["<C-j>"] = cmp.mapping.select_next_item(),
        -- 确认
        ["<CR>"] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace
        }),
        -- 如果窗口内容太多，可以滚动
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
    }
end

pluginKeys.mapToggleTerm = function(toggleterm)
  vim.keymap.set({ "n", "t" }, "<A-0>", toggleterm.toggleC)
  vim.keymap.set({ "n", "t" }, "<leader>t", toggleterm.toggleC)
end


return pluginKeys
