--[[
   Copyright (C) 2013 Seamus Tuohy 

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
]]--

module "luci.commotion.ccbi"

local ccbi = {}

--! @name flag_write
--! @brief Modifies the flag write function to set section.changed. Called with flagname.remove=ccbi.flag_remove
--! @param self the self object of the flag. You should not have to set this explicitly
--! @param section the section object of the flag. You should not have to set this explicitly
function ccbi.flag_write(self, section, fvalue)
   value = self.map:get(section, self.option)
   if value ~= fvalue then
	  self.section.changed = true
	  return self.map:set(section, self.option, fvalue)
   end
end

--! @name flag_remove
--! @brief Modifies the flag remove function to set section.changed called like flagname.remove=ccbi.flag_remove
--! @param self the self object of the flag. You should not have to set this explicitly
--! @param section the section object of the flag. You should not have to set this explicitly
function ccbi.flag_remove(self, section)
   value = self.map:get(section, self.option)
   if value ~= self.disabled then
	  self.section.changed = true
	  return self.map:del(section, self.option)
   end
end

--! @name flag_off
--! @brief Modifies the flag remove function to set section.changed and set the value to 0 instead of removal called like flagname.remove=ccbi.flag_off
--! @param self the self object of the flag. You should not have to set this explicitly
--! @param section the section object of the flag. You should not have to set this explicitly
function ccbi.flag_off(self, section)
   value = self.map:get(section, self.option)
   if value ~= self.disabled then
	  self.section.changed = true
	  return self.map:set(section, self.option, '0')
   end
end



return ccbi
