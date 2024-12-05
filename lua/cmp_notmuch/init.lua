-- SPDX-FileCopyrightText: 2021 Michael Adler
-- SPDX-License-Identifier: Apache-2.0
--
-- Author: Michael Adler <therisen06@gmail.com>
local source = {}

local util = require("cmp_notmuch.util")

source.new = function()
    return setmetatable({}, { __index = source })
end

source.is_available = function()
    return vim.bo.filetype == "mail"
end

source.get_trigger_characters = function()
    return { "@", "." }
end

source.get_keyword_pattern = function()
    return "[^[:blank:]]*"
end

source.complete = function(self, request, callback)
    -- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/context.lua
    if request.context.cursor.line <= 3 then
        local input = string.sub(request.context.cursor_before_line, request.offset)
        callback({ items = util.candidates(input), isIncomplete = true })
        return
    end
    callback()
end

return source
