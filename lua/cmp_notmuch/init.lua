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
        local search_term = string.sub(request.context.cursor_before_line, request.offset)
        if string.len(search_term) < 3 then
            callback()
            return
        end
        util.async_search(search_term, function(items)
            if items then
                callback({ items = items, isIncomplete = true })
            else
                callback()
            end
        end)
    end
    callback()
end

return source
