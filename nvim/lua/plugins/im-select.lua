-- im-select.lua
--
-- Forces Neovim to switch input source to English when entering Normal mode.
-- Prevents broken keybindings when the system keyboard is set to Korean.
-- Requires the `im-select` binary on macOS.

return {
  "keaising/im-select.nvim",
  event = "VeryLazy",
  opts = {
    -- Normal 모드 기본 입력기
    default_im_select = "com.apple.keylayout.ABC",

    -- im-select 실행 커맨드
    default_command = "im-select",

    --- ⭐ Normal 모드 들어갈 때만 전환
    set_default_events = { "InsertLeave", "FocusGained" },

    -- Insert 모드에서는 입력기 변경 안 함
    set_previous_events = {},

    -- im-select 없을 때 에러 방지
    keep_quiet_on_no_binary = true,
  },
}

-- im-select.lua
--
-- Purpose:
-- This plugin ensures that Neovim always switches the keyboard input
-- to English (ABC) when entering Normal mode.
--
-- Why this exists:
-- On macOS, if the system input source is set to Korean (or any non-English layout),
-- Normal mode keybindings (hjkl, :, /, etc.) may not work correctly because
-- Neovim receives different characters.
--
-- What it solves:
-- • Prevents broken keybindings when leaving Insert mode
-- • Automatically restores a predictable editing environment
-- • Reduces friction when switching between apps and returning to Neovim
--
-- Behavior:
-- • When leaving Insert mode or when Neovim regains focus → switch to English
-- • Insert mode does NOT change the input source (so you can type in Korean)
--
-- Dependencies:
-- Requires the `im-select` binary installed on the system (macOS input source switcher)
--
-- This file exists to guarantee a consistent and reliable modal editing experience.
