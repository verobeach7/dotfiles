-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Optimized diagnostic UI for TypeScript + Python workflow

vim.diagnostic.config({

  -- ❌ 긴 메시지 잘림 방지 → virtual text 최소화
  virtual_text = {
    prefix = "●",
    spacing = 2,
  },

  -- ✔ 커서 hover 시 전체 메시지 표시
  float = {
    border = "rounded",
    source = true,
    max_width = 120,
    focusable = false,
  },

  -- ✔ 라인 번호 옆 표시
  signs = true,

  -- ✔ underline 유지
  underline = true,

  -- ✔ 입력 중에는 너무 시끄럽지 않게
  update_in_insert = false,

  -- ✔ severity 정렬
  severity_sort = true,
})

-- 긴 문자열 줄 자동 바꾸기
vim.opt.wrap = true
vim.opt.linebreak = true
-- 줄 자동 바꿈 시 들여쓰기
vim.opt.breakindent = true
-- 위 아래 10번째 줄부터 화면 스크롤 시작
vim.opt.scrolloff = 10
