-- SPDX-FileCopyrightText: 2021 Michael Adler
-- SPDX-License-Identifier: Apache-2.0
--
-- Author: Michael Adler <therisen06@gmail.com>
if pcall(require, "cmp") then
   require("cmp").register_source("notmuch", require("cmp_notmuch").new())
end
