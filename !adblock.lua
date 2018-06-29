--������ �������� �� ������ ����� ����� �� �����: http://www.rubbishman.ru/samp
--------------------------------------------------------------------------------
-------------------------------------META---------------------------------------
--------------------------------------------------------------------------------
script_name("ADBLOCK")
script_version("2.85")
script_author("rubbishman")
script_description("/ads")
-------------------------------------var----------------------------------------
local prefix = '['..string.upper(thisScript().name)..']: '
local sampev = require 'lib.samp.events'
local dlstatus = require('moonloader').download_status
local ffi = require('ffi')
local id = -1
local ads1 = "ID\t����������\t�������\t�����\n \t������ ����������\n \t����� �� �����������\n"
local adnicks = {}
local adnomers = {}
local allads = {}
local coolads = {}
local blocked = 0
local adscount = 0
local LSN = 0
local SFN = 0
local LVN = 0
local color = 0x348cb2
local servers = {
  ["185.169.134.19"] = "S�mp-R�",
  ["185.169.134.20"] = "S�mp-R�",
  ["185.169.134.21"] = "S�mp-R�",
  ["185.169.134.22"] = "S�mp-R�",
  ["185.169.134.11"] = "S�mp-R�",
  ["185.169.134.34"] = "S�mp-R�",
  ["185.169.134.67"] = "Evolve-Rp",
  ["185.169.134.68"] = "Evolve-Rp",
  ["176.32.37.58"] = "ImperiaL",
  ["5.254.104.131"] = "Advance-Rp",
  ["5.254.104.132"] = "Advance-Rp",
  ["5.254.104.133"] = "Advance-Rp",
  ["5.254.104.134"] = "Advance-Rp",
  ["5.254.104.135"] = "Advance-Rp",
  ["5.254.104.136"] = "Advance-Rp",
  ["5.254.104.137"] = "Advance-Rp",
  ["5.254.104.138"] = "Advance-Rp",
  ["5.254.104.139"] = "Advance-Rp",
  ["5.254.104.132"] = "Advance-Rp",
  ["5.254.123.2"] = "Diamond-Rp",
  ["5.254.123.3"] = "Diamond-Rp",
  ["5.254.123.4"] = "Diamond-Rp",
  ["5.254.123.5"] = "Diamond-Rp",
  ["5.254.123.6"] = "Diamond-Rp",
  ["5.254.105.202"] = "Diamond-Rp",
  ["5.254.105.203"] = "Diamond-Rp",
  ["5.254.105.204"] = "Diamond-Rp",
  ["185.169.134.3"] = "Arizona-Rp",
  ["185.169.134.4"] = "Arizona-Rp",
  ["185.169.134.43"] = "Arizona-Rp",
  ["185.169.134.44"] = "Arizona-Rp",
  ["185.169.134.45"] = "Arizona-Rp",
  ["185.169.134.5"] = "Arizona-Rp",
  ["178.32.204.129"] = "Trinity-Rp",
  ["217.182.53.133"] = "Trinity-Rp",
}
-------------------------------------MAIN---------------------------------------
function main()
  if not isSampfuncsLoaded() or not isSampLoaded() then return end
  while not isSampAvailable() do wait(100) end


  while sampGetCurrentServerAddress() == nil do wait(100) sampAddChatMessage("text", color) end
  mode = servers[sampGetCurrentServerAddress()]

  -- ������ ���, ���� ������ ��������� �������� ����������
  update()
  while update ~= false do wait(100) end
  -- ������ ���, ���� ������ ��������� �������� ����������



  -- �������� ���, ���� ������ ��������� ��������� ��� ����� � ����
  if mode ~= nil then sampAddChatMessage(("ADBLOCK v"..thisScript().version.." successfully loaded! /ads - show hidden ads! Mode: "..mode..". Author: rubbishman.ru"), color)
  else
    sampAddChatMessage(("ADBLOCK v"..thisScript().version.." not loaded! Reason: unknown server. Author: rubbishman.ru"), 0xFF4500)
  end
  -- �������� ���, ���� ������ ��������� ��������� ��� ����� � ����

  if mode == nil then thisScript():unload() end
  sampRegisterChatCommand("ads", ads)


  while true do
    wait(0)
    if Enable and (mode == "S�mp-R�" or mode == "Evolve-Rp") then
      sampSendChat("/ad "..floodtext)
      wait(1100)
    end
  end
end
--------------------------------------------------------------------------------
-----------------------------������ ��� ������ ������---------------------------
--------------------------------------------------------------------------------
--samp-rp
function samprp(text)
  trigger = false
  --sampAddChatMessage(text, - 1) -- ��� ������� � ��� ������, ������� ������ ������ � ������
  for i = #allads - 25, #allads do
    if allads[i] ~= nil and text == allads[i] then trigger = true blocked = blocked + 1 break end
  end
  if trigger == false then
    id = id + 1
    allads[id] = text
    adtext = string.sub(text, 13, string.find(text, " �������: ") - 2)
    if string.find(text, " ���: .") then
      adnick = string.sub(text, string.find(text, " �������: ") + 10, string.find(text, " ���: ") - 2)
      adnomer = string.sub(text, string.find(text, " ���: ") + 6, string.len(text))
    else
      adnick = "ERROR"
      adnomer = "ERROR"
    end
    adnicks[id] = adnick
    if string.find(string.rlower(adtext), "�����") then color = "{FFFF00}" end
    if string.find(string.rlower(adtext), "������") then color = "{00FF00}" end
    if string.find(string.rlower(adtext), "���") then color = "{800080}" end
    if string.find(string.rlower(adtext), "�������") then color = "{800080}" end
    if string.find(string.rlower(adtext), "����������") then color = "{800080}" end
    if string.find(string.rlower(adtext), "�����") then color = "{800080}" end
    if string.find(string.rlower(adtext), "farm") then color = "{800080}" end
    if string.find(string.rlower(adtext), "������") then color = "{FF0000}" end
    if not string.find(string.rlower(adtext), "�����") and not string.find(string.rlower(adtext), "farm") and not string.find(string.rlower(adtext), "���") and not string.find(string.rlower(adtext), "�������") and not string.find(string.rlower(adtext), "����������") and not string.find(string.rlower(adtext), "������") and not string.find(string.rlower(adtext), "�����") and not string.find(string.rlower(adtext), "������") then color = "{00FFFF}" end
    coolads[id] = color.."["..id.."]\t"..color.."["..os.date("%H:%M:%S").."] "..adtext.."\t"..color..adnick.."\t"..color..string.format("%s", adnomer).."\n"
    ads1 = "ID\t����������\t�������\t�����\n \t������ ����������\n \t����� �� �����������\n"..color.."["..id.."]\t"..color.."["..os.date("%H:%M:%S").."] "..adtext.."\t"..color..adnick.."\t"..color..string.format("%s", adnomer).."\n"..string.gsub(ads1, "ID\t����������\t�������\t�����\n \t������ ����������\n \t����� �� �����������\n", "")
    if id > 25 then ads1 = string.sub(ads1, 1, (string.find(ads1, "\n{......}%["..(id - 25).."%]") - 1)) end --� ������� ����������� ���� ����� �� ����� ������, ������� ����� ����������� � 25 �����. ����� ������������ �� ����������, �� ��� ����.
  end
  trigger = false
end
--advance-rp
function advancerp(text)
  trigger = false
  --sampAddChatMessage(text, - 1) -- ��� ������� � ��� ������, ������� ������ ������ � ������
  if not string.find(text, "���������") then
    for i = #allads - 25, #allads do
      if allads[i] ~= nil and text == allads[i] then trigger = true blocked = blocked + 1 break end
    end
    if trigger == false then
      id = id + 1
      allads[id] = text
      adtext = string.sub(text, 6, string.find(text, " | �������� ", 1, true) - 1)
      adnick = string.sub(text, string.find(text, "| �������� ", 1, true) + 11, string.find(text, "���.", 1, true) - 3)
      adnick = string.sub(adnick, 1, string.find(adnick, "[", 1, true) - 1)
      adnomer = string.sub(text, string.find(text, "(���. ", 1, true) + 6, string.len(text) - 1)
      adnicks[id] = adnick
      adnomers[id] = adnomer
      if string.find(string.rlower(adtext), "�����") then color = "{FFFF00}" end
      if string.find(string.rlower(adtext), "������") then color = "{00FF00}" end
      if not string.find(string.rlower(adtext), "������") and not string.find(string.rlower(adtext), "�����") then color = "{00FFFF}" end
      coolads[id] = color.."["..id.."]\t"..color.."["..os.date("%H:%M:%S").."] "..adtext.."\t"..color..adnick.."\t"..color..string.format("%s", adnomer).."\n"
      ads1 = "ID\t����������\t�������\t�����\n \t������ ����������\n \t����� �� �����������\n"..color.."["..id.."]\t"..color.."["..os.date("%H:%M:%S").."] "..adtext.."\t"..color..adnick.."\t"..color..string.format("%s", adnomer).."\n"..string.gsub(ads1, "ID\t����������\t�������\t�����\n \t������ ����������\n \t����� �� �����������\n", "")
      if id > 25 then ads1 = string.sub(ads1, 1, (string.find(ads1, "\n{......}%["..(id - 25).."%]") - 1)) end --� ������� ����������� ���� ����� �� ����� ������, ������� ����� ����������� � 25 �����. ����� ������������ �� ����������, �� ��� ����.
    end
    trigger = false
  end
end
--diamond-rp
function diamondrp(text)
  trigger = false
  --sampAddChatMessage(text, - 1) -- ��� ������� � ��� ������, ������� ������ ������ � ������
  if not string.find(text, "���������") then
    for i = #allads - 25, #allads do
      if allads[i] ~= nil and text == allads[i] then trigger = true blocked = blocked + 1 break end
    end
    if trigger == false then
      id = id + 1
      allads[id] = text
      adtext = string.sub(text, 1, string.find(text, " �����������:", 1, true) - 1)
      adnick = string.sub(text, string.find(text, " �����������:", 1, true) + 14, string.find(text, "���.", string.len(text) - 15, true) - 3)
      adnomer = string.sub(text, string.find(text, "(���. ", 1, true) + 6, string.len(text) - 1)
      adnicks[id] = adnick
      adnomers[id] = adnomer
      if string.find(string.rlower(adtext), "�����") then color = "{FFFF00}" end
      if string.find(string.rlower(adtext), "������") then color = "{00FF00}" end
      if not string.find(string.rlower(adtext), "������") and not string.find(string.rlower(adtext), "�����") then color = "{00FFFF}" end
      coolads[id] = color.."["..id.."]\t"..color.."["..os.date("%H:%M:%S").."] "..adtext.."\t"..color..adnick.."\t"..color..string.format("%s", adnomer).."\n"
      ads1 = "ID\t����������\t�������\t�����\n \t������ ����������\n \t����� �� �����������\n"..color.."["..id.."]\t"..color.."["..os.date("%H:%M:%S").."] "..adtext.."\t"..color..adnick.."\t"..color..string.format("%s", adnomer).."\n"..string.gsub(ads1, "ID\t����������\t�������\t�����\n \t������ ����������\n \t����� �� �����������\n", "")
      if id > 25 then ads1 = string.sub(ads1, 1, (string.find(ads1, "\n{......}%["..(id - 25).."%]") - 1)) end --� ������� ����������� ���� ����� �� ����� ������, ������� ����� ����������� � 25 �����. ����� ������������ �� ����������, �� ��� ����.
    end
    trigger = false
  end
end
--arizona-rp
function arizonarp(text)
  trigger = false
  --sampAddChatMessage(text, - 1) -- ��� ������� � ��� ������, ������� ������ ������ � ������
  if not string.find(text, "���������") then
    for i = #allads - 25, #allads do
      if allads[i] ~= nil and text == allads[i] then trigger = true blocked = blocked + 1 break end
    end
    if trigger == false then
      id = id + 1
      allads[id] = text
      adtext, adnick, adnomer = string.match(text, "����������: (.+) ��������: (%g+)%[%d+%] ���. (%d+)")
      adnicks[id] = adnick
      adnomers[id] = adnomer
      if string.find(string.rlower(adtext), "�����") then color = "{FFFF00}" end
      if string.find(string.rlower(adtext), "������") then color = "{00FF00}" end
      if not string.find(string.rlower(adtext), "������") and not string.find(string.rlower(adtext), "�����") then color = "{00FFFF}" end
      coolads[id] = color.."["..id.."]\t"..color.."["..os.date("%H:%M:%S").."] "..adtext.."\t"..color..adnick.."\t"..color..string.format("%s", adnomer).."\n"
      ads1 = "ID\t����������\t�������\t�����\n \t������ ����������\n \t����� �� �����������\n"..color.."["..id.."]\t"..color.."["..os.date("%H:%M:%S").."] "..adtext.."\t"..color..adnick.."\t"..color..string.format("%s", adnomer).."\n"..string.gsub(ads1, "ID\t����������\t�������\t�����\n \t������ ����������\n \t����� �� �����������\n", "")
      if id > 25 then ads1 = string.sub(ads1, 1, (string.find(ads1, "\n{......}%["..(id - 25).."%]") - 1)) end --� ������� ����������� ���� ����� �� ����� ������, ������� ����� ����������� � 25 �����. ����� ������������ �� ����������, �� ��� ����.
    end
    trigger = false
  end
end
--trinity-rp
function trinityrp(text)
  trigger = false
  --sampAddChatMessage(text, - 1) -- ��� ������� � ��� ������, ������� ������ ������ � ������
  if not string.find(text, "���.") then
    adtext = string.sub(text, string.find(text, "]", 1, true) + 10, string.len(text))
  else
    adnick = string.sub(text, string.find(text, "{ffffff}", 1, true) + 8, string.find(text, "{EEA9B8} ���.", 1, true) - 1)
    if string.find(text, "{EEA9B8}", string.find(text, "���. {ffffff}", 1, true), true) then
      adnomer = string.sub(text, string.find(text, "���. {ffffff}", 1, true) + 13, string.find(text, "{EEA9B8}", string.find(text, "���. {ffffff}", 1, true), true) - 1)
    else
      adnomer = string.sub(text, string.find(text, "���. {ffffff}", 1, true) + 13, text:len())
    end
  end
  if adtext ~= nil and adnick ~= nil then
    id = id + 1
    adscount = adscount + 1
    allads[id] = text
    adnicks[id] = adnick
    adnomers[id] = adnomer
    if string.find(string.rlower(adtext), "�����") then color = "{FFFF00}" end
    if string.find(string.rlower(adtext), "������") then color = "{00FF00}" end
    if not string.find(string.rlower(adtext), "������") and not string.find(string.rlower(adtext), "�����") then color = "{00FFFF}" end
    coolads[id] = color.."["..id.."]\t"..color.."["..os.date("%H:%M:%S").."] "..adtext.."\t"..color..adnick.."\t"..color..string.format("%s", adnomer).."\n"
    ads1 = "ID\t����������\t�������\t�����\n \t������ ����������\n \t����� �� �����������\n"..color.."["..id.."]\t"..color.."["..os.date("%H:%M:%S").."] "..adtext.."\t"..color..adnick.."\t"..color..string.format("%s", adnomer).."\n"..string.gsub(ads1, "ID\t����������\t�������\t�����\n \t������ ����������\n \t����� �� �����������\n", "")
    if id > 25 then ads1 = string.sub(ads1, 1, (string.find(ads1, "\n{......}%["..(id - 25).."%]") - 1)) end --� ������� ����������� ���� ����� �� ����� ������, ������� ����� ����������� � 25 �����. ����� ������������ �� ����������, �� ��� ����.
    adtext = nil
    adnick = nil
    adnick = nil
  end
  trigger = false
end
--imperial RPG
function imperial(text1)
  trigger = false
  --	sampAddChatMessage(text, - 1) -- ��� ������� � ��� ������, ������� ������ ������ � ������
  for i = #allads - 35, #allads do
    if allads[i] ~= nil and text1 == allads[i] then trigger = true blocked = blocked + 1 break end
  end
  if trigger == false then
    id = id + 1
    allads[id] = text1
    adtext = string.sub(text1, 11, string.find(text1, "]:") - 13)
    adnick = string.sub(text1, string.find(text1, "]: ") + 3, string.find(text1, "%[(%d+)%]") - 1)
    adnomer = string.sub(text1, string.find(text1, "%[(%d+)%]") + 1, (string.len(text1) - 1))
    adnicks[id] = adnick
    if string.find(string.rlower(adtext), "�����") then color = "{FFFF00}" end
    if string.find(string.rlower(adtext), "������") then color = "{00FF00}" end
    if not string.find(string.rlower(adtext), "������") and not string.find(string.rlower(adtext), "�����") then color = "{00FFFF}" end
    coolads[id] = color.."["..id.."]\t"..color.."["..os.date("%H:%M:%S").."] "..adtext.."\t"..color..adnick.."\t"..color..string.format("%s", adnomer).."\n"
    ads1 = "ID\t����������\t�������\t�����\n \t������ ����������\n \t����� �� �����������\n"..color.."["..id.."]\t"..color.."["..os.date("%H:%M:%S").."] "..adtext.."\t"..color..adnick.."\t"..color..string.format("%s", adnomer).."\n"..string.gsub(ads1, "ID\t����������\t�������\t�����\n \t������ ����������\n \t����� �� �����������\n", "")
    if id > 25 then ads1 = string.sub(ads1, 1, (string.find(ads1, "\n{......}%["..(id - 25).."%]") - 1)) end --� ������� ����������� ���� ����� �� ����� ������, ������� ����� ����������� � 25 �����. ����� ������������ �� ����������, �� ��� ����.
  end
  trigger = false
end
--------------------------------------------------------------------------------
----------------------������ ����� � ��� ��� ������� � ���----------------------
--------------------------------------------------------------------------------
--��������� �������, ���������� ��������
function ads()
  if Enable then
    Enable = false
  else
    lua_thread.create(adss)
  end
end
--������ /ads
function adss()
  if (mode == "S�mp-R�" or mode == "Evolve-Rp" or mode == "ImperiaL" or mode == "Advance-Rp" or mode == "Diamond-Rp" or mode == "Arizona-Rp" or mode == "Trinity-Rp") then
    sampShowDialog(5125, "{348cb2}"..thisScript().name.." v"..thisScript().version.."   LSN: "..LSN..". SFN: "..SFN..". LVN: "..LVN..".   Blocked: "..blocked.."/"..adscount..".", ads1, "�������", "�������", 5)
    dialog = sampGetDialogText()
    lastid = id
    while sampIsDialogActive(5125) do wait(100) end
    local resultMain, buttonMain, typ = sampHasDialogRespond(5125)
    if buttonMain == 1 and typ == 0 and (mode == "S�mp-R�" or mode == "Evolve-Rp") then
      sampShowDialog(9890, "������ /ad", "������� ����� ���������� � ������� \"�������\".\n������� /ads, ����� ���������� ������.", "�������", "�������", 1)
      while sampIsDialogActive(9890) do wait(100) end
      local resultMain, buttonMain, typ = sampHasDialogRespond(9890)
      if buttonMain == 1 then
        if sampGetCurrentDialogEditboxText(9890) ~= "" then
          floodtext = sampGetCurrentDialogEditboxText(9890)
          Enable = true
        end
      else
        ads()
      end
    elseif buttonMain == 1 and ads1 ~= "ID\t����������\t�������\t�����\n \t������ ����������\n \t����� �� �����������\n" and typ == 1 then
      sampShowDialog(9891, "����� � /ads", "������� ����� ��� ������ � ������� \"�����\".\n����� ������� ����, ������ � ����� ����������.", "�����", "�������", 1)
      while sampIsDialogActive(9891) do wait(100) end
      local resultMain, buttonMain, typ = sampHasDialogRespond(9891)
      if buttonMain == 1 then
        if sampGetCurrentDialogEditboxText(9891) ~= "" then
          zapros = sampGetCurrentDialogEditboxText(9891)
          result = "ID\t����������\t�������\t�����\n"
          scount = 0
          snicks = {}
          snomers = {}
          for i = 0, #coolads do
            i = #coolads - i
            if string.find(string.rlower(coolads[i]), string.rlower(sampGetCurrentDialogEditboxText(9891)), 1, true) then
              result = result..coolads[i]
              snicks[scount] = adnicks[i]
              snomers[scount] = adnomers[i]
              scount = scount + 1
            end
          end
          if scount < 25 then
            wait(400)
            searchres()
          else
            sampShowDialog(9899, "{348cb2}"..thisScript().name.." v"..thisScript().version, "�� ������� \""..zapros.."\" ������� ������� ����� ����������.\n�������: "..scount.." ����������.\n���������� �������� ������.", "����")
          end
        else
          ads()
        end
      else
        ads()
      end
    elseif buttonMain == 1 and ads1 ~= "ID\t����������\t�������\t�����\n \t������ ����������\n \t����� �� �����������\n" and typ > 1 and mode ~= "Arizona-Rp" then
      for i = 0, 1001 do
        if sampIsPlayerConnected(i) and sampGetPlayerNickname(i) == adnicks[lastid - typ + 2] then
          sampShowDialog(9899, "����������: "..adnicks[lastid - typ + 2], "������� ����� ����� � ������� \"���������\".", "���������", "�������", 1)
          while sampIsDialogActive(9899) do wait(100) end
          local resultMain, buttonMain, typ = sampHasDialogRespond(9899)
          if buttonMain == 1 then
            if sampGetCurrentDialogEditboxText(9899) ~= "" then
              if (mode == "ImperiaL") then sampSendChat("/pm "..i.." "..sampGetCurrentDialogEditboxText(9899)) end
              if (mode == "Advance-Rp" or mode == "Diamond-Rp" or mode == "Arizona-Rp" or mode == "Trinity-Rp") then sampSendChat("/sms "..adnomers[lastid - typ + 2].." "..sampGetCurrentDialogEditboxText(9899)) end
              if (mode == "S�mp-R�" or mode == "Evolve-Rp") then sampSendChat("/t "..i.." "..sampGetCurrentDialogEditboxText(9899)) end
              ads()
            end
          else
            ads()
          end
          break
        end
        if i == 1001 then sampShowDialog(9899, "{348cb2}"..thisScript().name.." v"..thisScript().version, "����� "..adnicks[lastid - typ + 2].." �������.", "����") break end
      end
    end
  end
end
--������ � ������������ ������
function searchres()
  sampShowDialog(4145, "{348cb2}"..thisScript().name.." v"..thisScript().version.." ������: "..zapros..". �������: "..scount..".", result, "�������", "�������", 5)
  while sampIsDialogActive(4145) do wait(100) end
  local resultMain, buttonMain, typ = sampHasDialogRespond(4145)
  if buttonMain == 1 and scount ~= 0 and mode ~= "Arizona-Rp" then
    for i = 0, 1001 do
      if sampIsPlayerConnected(i) and sampGetPlayerNickname(i) == snicks[typ] then
        sampShowDialog(9899, "����������: "..snicks[typ], "������� ����� ����� � ������� \"���������\".", "���������", "�������", 1)
        while sampIsDialogActive(9899) do wait(100) end
        local resultMain, buttonMain, typ = sampHasDialogRespond(9899)
        if buttonMain == 1 then
          if sampGetCurrentDialogEditboxText(9899) ~= "" then
            if (mode == "S�mp-R�" or mode == "Evolve-Rp") then sampSendChat("/t "..i.." "..sampGetCurrentDialogEditboxText(9899)) end
            if (mode == "Advance-Rp" or mode == "Diamond-Rp" or mode == "Arizona-Rp" or mode == "Trinity-Rp") then sampSendChat("/sms "..adnomers[typ].." "..sampGetCurrentDialogEditboxText(9899)) end
            if (mode == "ImperiaL") then sampSendChat("/pm "..i.." "..sampGetCurrentDialogEditboxText(9899)) end
            wait(400)
            searchres()
          end
        else
          wait(500)
          searchres()
        end
        break
      end
      if i == 1001 then sampShowDialog(9899, "{348cb2}"..thisScript().name.." v"..thisScript().version, "����� "..snicks[typ].." �������.", "����") break end
    end
  else
    ads()
  end
end
--------------------------------------------------------------------------------
-------------------------------------HOOK---------------------------------------
--------------------------------------------------------------------------------
function sampev.onServerMessage(color, text)
  --samp-rp � ������
  if (mode == "S�mp-R�" or mode == "Evolve-Rp") then
    if color == 14221512 and string.find(text, "����������:") then
      if not string.find(text, "101.1", 1, true) and not string.find(text, "102.2", 1, true) and not string.find(text, "103.3", 1, true) and not string.find(text, "radio") and not string.find(text, "FM") and not string.find(text, "���������") and not string.find(text, "����") and not string.find(text, "�������") and not string.find(text, "News") then
        lua_thread.create(samprp, text)
      else
        blocked = blocked + 1
      end
      return false
    end
    if color == 14221512 and string.find(text, "���������") then
      if string.find(text, "LV") then LVN = LVN + 1 end
      if string.find(text, "LS") then LSN = LSN + 1 end
      if string.find(text, "SF") then SFN = SFN + 1 end
      adscount = adscount + 1
      return false
    end
  end
  --������ ��
  if mode == "Advance-Rp" then
    if color == 13369599 and string.find(text, "��������") then
      if string.find(text, "LV |") then LVN = LVN + 1 end
      if string.find(text, "LS |") then LSN = LSN + 1 end
      if string.find(text, "SF |") then SFN = SFN + 1 end
      adscount = adscount + 1
      lua_thread.create(advancerp, text)
      return false
    end
    if color == 10027263 and string.find(text, "���������") then
      return false
    end
  end
  --������� ��
  if mode == "Diamond-Rp" then
    if color == 16711935 and string.find(text, "�����������") then
      lua_thread.create(diamondrp, text)
      local temptext = string.sub(text, 1, 5)
      if string.find(temptext, "LV") then LVN = LVN + 1 end
      if string.find(temptext, "LS") then LSN = LSN + 1 end
      if string.find(temptext, "SF") then SFN = SFN + 1 end
      adscount = adscount + 1
      return false
    end
    if color == 866792362 and string.find(text, "���������� ��������") then
      return false
    end
  end
  --������� ��
  if mode == "Arizona-Rp" then
    if color == 1941201407 and string.find(text, "��������") then
      adscount = adscount + 1
      lua_thread.create(arizonarp, text)
      return false
    end
    if color == 1941201407 and string.find(text, "��������� ���") then
      if string.find(text, "LV") then LVN = LVN + 1 end
      if string.find(text, "LS") then LSN = LSN + 1 end
      if string.find(text, "SF") then SFN = SFN + 1 end
      return false
    end
    text2 = text
    if string.find(text2, "{C17C2D}") then
      if string.find(text2, "��������� ���") then
        if string.find(text2, "LV") then LVN = LVN + 1 end
        if string.find(text2, "LS") then LSN = LSN + 1 end
        if string.find(text2, "SF") then SFN = SFN + 1 end
        return false
      end
    end
    text3 = text
    if string.find(text3, "{FCAA4D}[VIP]", 1, true) then
      if string.find(text3, "����") then
        adscount = adscount + 1
        lua_thread.create(arizonarp, string.sub(text3, 15, string.len(text3)))
        return false
      end
    end
  end
  --������� ��
  if mode == "Trinity-Rp" then
    if color == -290866945 and string.find(text, "[�������", 1, true) then
      lua_thread.create(trinityrp, text)
      return false
    end
  end
  --�������� ���
  if mode == "ImperiaL" then
    if color == 332279551 and string.find(text, "[�������]", 1, true) and string.find(text, "]:", 1, true) then
      lua_thread.create(imperial, text)
      adscount = adscount + 1
      return false
    end
  end
end
--------------------------------------------------------------------------------
----------------------------------RUSSTRING-------------------------------------
--------------------------------------------------------------------------------
local russian_characters = {
  [168] = '�', [184] = '�', [192] = '�', [193] = '�', [194] = '�', [195] = '�', [196] = '�', [197] = '�', [198] = '�', [199] = '�', [200] = '�', [201] = '�', [202] = '�', [203] = '�', [204] = '�', [205] = '�', [206] = '�', [207] = '�', [208] = '�', [209] = '�', [210] = '�', [211] = '�', [212] = '�', [213] = '�', [214] = '�', [215] = '�', [216] = '�', [217] = '�', [218] = '�', [219] = '�', [220] = '�', [221] = '�', [222] = '�', [223] = '�', [224] = '�', [225] = '�', [226] = '�', [227] = '�', [228] = '�', [229] = '�', [230] = '�', [231] = '�', [232] = '�', [233] = '�', [234] = '�', [235] = '�', [236] = '�', [237] = '�', [238] = '�', [239] = '�', [240] = '�', [241] = '�', [242] = '�', [243] = '�', [244] = '�', [245] = '�', [246] = '�', [247] = '�', [248] = '�', [249] = '�', [250] = '�', [251] = '�', [252] = '�', [253] = '�', [254] = '�', [255] = '�',
}
function string.rlower(s)
  s = s:lower()
  local strlen = s:len()
  if strlen == 0 then return s end
  s = s:lower()
  local output = ''
  for i = 1, strlen do
    local ch = s:byte(i)
    if ch >= 192 and ch <= 223 then -- upper russian characters
      output = output .. russian_characters[ch + 32]
    elseif ch == 168 then -- �
      output = output .. russian_characters[184]
    else
      output = output .. string.char(ch)
    end
  end
  return output
end
function string.rupper(s)
  s = s:upper()
  local strlen = s:len()
  if strlen == 0 then return s end
  s = s:upper()
  local output = ''
  for i = 1, strlen do
    local ch = s:byte(i)
    if ch >= 224 and ch <= 255 then -- lower russian characters
      output = output .. russian_characters[ch - 32]
    elseif ch == 184 then -- �
      output = output .. russian_characters[168]
    else
      output = output .. string.char(ch)
    end
  end
  return output
end
--------------------------------------------------------------------------------
------------------------------------UPDATE--------------------------------------
--------------------------------------------------------------------------------
function update()
  --��� ���� � �������. � ����������, ����� ����� �� ���������� ����� ���
  local json = getWorkingDirectory() .. '\\adblock-version.json'
  --���� � ������� �������, ������� �������� �� ���� ���������� � ��������������
  local php = 'http://rubbishman.ru/dev/moonloader/adblock/stats.php'
  --���� ������ ���� ������-�� �������, ������� ���
  if doesFileExist(json) then os.remove(json) end
  --� ������� ffi ������ id ���������� ����� - ������ ������������� �����
  --��� �����
  local ffi = require 'ffi'
  ffi.cdef[[
	int __stdcall GetVolumeInformationA(
			const char* lpRootPathName,
			char* lpVolumeNameBuffer,
			uint32_t nVolumeNameSize,
			uint32_t* lpVolumeSerialNumber,
			uint32_t* lpMaximumComponentLength,
			uint32_t* lpFileSystemFlags,
			char* lpFileSystemNameBuffer,
			uint32_t nFileSystemNameSize
	);
	]]
  local serial = ffi.new("unsigned long[1]", 0)
  ffi.C.GetVolumeInformationA(nil, nil, 0, serial, nil, nil, nil, 0)
  --���������� �������� � ����������
  serial = serial[0]
  --�������� ���� id �� ������, ����� ������� ��� �� ����� ���
  local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
  local nickname = sampGetPlayerNickname(myid)
  --���������� � ������� �� �������, ����� ��� ���������� (�������� �����, ���, �� �������, ������ ����, ������ �������)
  --� ����� ������ ���������� �������� �� json � ���������� �������
  --� json �������� ��������� ������ � ������, ����� � ��������
  --������� ���������� ������������ ��������
  if mode == nil then mode = "unsupported" end
  downloadUrlToFile(php..'?id='..serial..'&n='..nickname..'&i='..sampGetCurrentServerAddress()..'&m='..mode..'&v='..getMoonloaderVersion()..'&sv='..thisScript().version, json,
    function(id, status, p1, p2)
      --���� ���������� ��������� ������: �� �����, ������� ��� ���, ����������
      if status == dlstatus.STATUSEX_ENDDOWNLOAD then
        --���� ���������� ��������� �������, ������ ���� ����
        if doesFileExist(json) then
          --��������� json
          local f = io.open(json, 'r')
          --���� �� nil, �� ����������
          if f then
            --json ���������� � �������� ���� ��� ������
            local info = decodeJson(f:read('*a'))
            --����������� ���������� updateurl
            updatelink = info.updateurl
            updateversion = tonumber(info.latest)
            --��������� ����
            f:close()
            --������� json, �� ��� �� �����
            os.remove(json)
            if updateversion > tonumber(thisScript().version) then
              --��������� ���������� ����� ������
              lua_thread.create(goupdate)
            else
              --���� ���������� ������ �� ������ �������, ��������� ������
              update = false
              print('v'..thisScript().version..': ���������� �� ���������.')
            end
          end
        else
          --���� ����� ����� ��� (�� ���������� �������), ������� ��������� � ������� �� �� ����
          print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� http://rubbishman.ru')
          --������ update = false => ������ �� ������� ���������� � ����� �����������
          update = false
        end
      end
  end)
end
--���������� ���������� ������
function goupdate()
  local color = -1
  sampAddChatMessage((prefix..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion), color)
  wait(250)
  downloadUrlToFile(updatelink, thisScript().path,
    function(id3, status1, p13, p23)
      if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
        print(string.format('��������� %d �� %d.', p13, p23))
      elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
        print('�������� ���������� ���������.')
        sampAddChatMessage((prefix..'���������� ���������! ��������� �� ���������� - /pisslog.'), color)
        goupdatestatus = true
        thisScript():reload()
      end
      if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
        if goupdatestatus == nil then
          sampAddChatMessage((prefix..'���������� ������ ��������. �������� ���������� ������..'), color)
          update = false
        end
      end
  end)
end
