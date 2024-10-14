-- SPDX-FileCopyrightText: 2021 Michael Adler
-- SPDX-License-Identifier: Apache-2.0
--
-- Author: Michael Adler <therisen06@gmail.com>
if pcall(require, "cmp") then
	local register_source = require("cmp").register_source
	if register_source then
		register_source("notmuch", require("cmp_notmuch").new())
	end
end
