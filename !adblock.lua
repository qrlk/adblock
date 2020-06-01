--������ �������� �� ������ ����� ����� � ������ ��: http://vk.com/qrlk.mods
--------------------------------------------------------------------------------
-------------------------------------META---------------------------------------
--------------------------------------------------------------------------------
script_name("ADBLOCK")
script_version("01.06.2020")
script_author("qrlk")
script_description("/ads")
-------------------------------------var----------------------------------------
math.randomseed(os.time())
local prefix = '['..string.upper(thisScript().name)..']: '
local sampev = require 'lib.samp.events'
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
local data = inicfg.load({
  options =
  {
    showad = true,
    toggle = true,
  },
}, 'adblock')
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
  ["185.169.134.20"] = "S�mp-R�",
  ["185.169.134.11"] = "S�mp-R�",
  ["185.169.134.34"] = "S�mp-R�",
  ["185.169.134.22"] = "S�mp-R�",
  ["185.169.134.67"] = "Evolve-Rp",
  ["185.169.134.68"] = "Evolve-Rp",
  ["185.169.134.91"] = "Evolve-Rp",
  ["176.32.37.58"] = "ImperiaL",
  ["play.imperial-rpg.ru"] = "ImperiaL",
  ["54.37.142.72"] = "Advance-Rp",
  ["54.37.142.73"] = "Advance-Rp",
  ["54.37.142.74"] = "Advance-Rp",
  ["54.37.142.75"] = "Advance-Rp",
  ["51.83.207.240"] = "Diamond-Rp",
  ["51.75.33.152"] = "Diamond-Rp",
  ["51.83.207.241"] = "Diamond-Rp",
  ["51.75.33.153"] = "Diamond-Rp",
  ["51.83.207.242"] = "Diamond-Rp",
  ["51.83.207.243"] = "Diamond-Rp",
  ["51.75.33.154"] = "Diamond-Rp",
  ["185.169.134.3"] = "Arizona-Rp",
  ["185.169.134.4"] = "Arizona-Rp",
  ["185.169.134.43"] = "Arizona-Rp",
  ["185.169.134.44"] = "Arizona-Rp",
  ["185.169.134.45"] = "Arizona-Rp",
  ["185.169.134.5"] = "Arizona-Rp",
  ["185.169.134.59"] = "Arizona-Rp",
  ["185.169.134.61"] = "Arizona-Rp",
  ["185.169.134.107"] = "Arizona-Rp",
  ["185.169.134.109"] = "Arizona-Rp",
  ["185.169.134.166"] = "Arizona-Rp",
  ["185.169.134.171"] = "Arizona-Rp",
  ["185.169.134.172"] = "Arizona-Rp",
  ["185.169.134.83"] = "Trinity-Rp",
  ["185.169.134.84"] = "Trinity-Rp",
  ["185.169.134.85"] = "Trinity-Rp",
}
-------------------------------------MAIN---------------------------------------
function main()
  if not isSampfuncsLoaded() or not isSampLoaded() then return end
  while not isSampAvailable() do wait(100) end


  while sampGetCurrentServerAddress() == nil do wait(100) sampAddChatMessage("text", color) end
  mode = servers[sampGetCurrentServerAddress()]

  -- ������ ���, ���� ������ ��������� �������� ����������
  update("http://qrlk.me/dev/moonloader/adblock/stats.php", '['..string.upper(thisScript().name)..']: ', "http://vk.com/qrlk.mods", "adblockchangelog")
	openchangelog("adblockchangelog", "http://qrlk.me/changelog/adblock")
  -- ������ ���, ���� ������ ��������� �������� ����������


  mode = servers[sampGetCurrentServerAddress()]
  -- �������� ���, ���� ������ ��������� ��������� ��� ����� � ����
  if mode ~= nil then sampAddChatMessage(("ADBLOCK v"..thisScript().version.." successfully loaded! /ads - show hidden ads! /tads - toggle! Mode: "..mode..". <> by qrlk."), color)
  else
    sampAddChatMessage(("ADBLOCK v"..thisScript().version.." not loaded! Reason: unknown server. <> by qrlk."), 0xFF4500)
  end
  -- �������� ���, ���� ������ ��������� ��������� ��� ����� � ����

  if mode == nil then thisScript():unload() end

  if data.options.showad == true then
    sampAddChatMessage("[ADBLOCK]: ��������! � ��� ��������� ������ ���������: vk.com/qrlk.mods", - 1)
    sampAddChatMessage("[ADBLOCK]: ������������ �� ��, �� ������� �������� ������� �� �����������,", - 1)
    sampAddChatMessage("[ADBLOCK]: ����� ��������, � ��� �� ������������ � ���������� ������� ��������!", - 1)
    sampAddChatMessage("[ADBLOCK]: ��� ��������� ������������ ���� ��� ��� ������� �������. ������� �� ��������.", - 1)
    data.options.showad = false
    inicfg.save(data, "adblock")
  end

  sampRegisterChatCommand("ads", ads)
  sampRegisterChatCommand("tads",
    function()
      data.options.toggle = not data.options.toggle
      inicfg.save(data, "adblock")
      sampAddChatMessage("������� ����� � ����: "..tostring(data.options.toggle), 0x348cb2)
    end
  )

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
    adnomers[id] = adnomer
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
    adnomers[id] = adnomer
    if string.find(string.rlower(adtext), "�����") then color = "{FFFF00}" end
    if string.find(string.rlower(adtext), "������") then color = "{00FF00}" end
    if not string.find(string.rlower(adtext), "������") and not string.find(string.rlower(adtext), "�����") then color = "{00FFFF}" end
    coolads[id] = color.."["..id.."]\t"..color.."["..os.date("%H:%M:%S").."] "..adtext.."\t"..color..adnick.."\t"..color..string.format("%s", adnomer).."\n"
    ads1 = "ID\t����������\t�������\t�����\n \t������ ����������\n \t����� �� �����������\n"..color.."["..id.."]\t"..color.."["..os.date("%H:%M:%S").."] "..adtext.."\t"..color..adnick.."\t"..color..string.format("%s", adnomer).."\n"..string.gsub(ads1, "ID\t����������\t�������\t�����\n \t������ ����������\n \t����� �� �����������\n", "")
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
    if tab == nil then tab = 1 end
    length = #coolads - (tab - 1) * 25
    ads1 = "ID\t����������\t�������\t�����\n \t������ ����������\n \t����� �� �����������\n"
    lastid = nil
    for i = length, length - 25, - 1 do
      if coolads[i] ~= nil then
        ads1 = ads1..coolads[i]
        if lastid == nil then lastid = i end
        if i > lastid then lastid = i end
      end
    end
    sampShowDialog(5125, "{348cb2}"..thisScript().name.." v"..thisScript().version.."   LSN: "..LSN..". SFN: "..SFN..". LVN: "..LVN..".   Blocked: "..blocked.."/"..adscount..".   Tab: "..tab..".   Use arrows to control.", ads1, "�������", "�������", 5)
    dialog = sampGetDialogText()
    while sampIsDialogActive(5125) do
      wait(0)
      if wasKeyPressed(37) then
        if tab ~= 1 then
          tab = tab - 1
          if tab == nil then tab = 1 end
          length = #coolads - (tab - 1) * 25
          ads1 = "ID\t����������\t�������\t�����\n \t������ ����������\n \t����� �� �����������\n"
          lastid = nil
          for i = length, length - 25, - 1 do
            if coolads[i] ~= nil then
              if lastid == nil then lastid = i end
              ads1 = ads1..coolads[i]
              if i > lastid then lastid = i end
            end
          end
          sampShowDialog(5125, "{348cb2}"..thisScript().name.." v"..thisScript().version.."   LSN: "..LSN..". SFN: "..SFN..". LVN: "..LVN..".   Blocked: "..blocked.."/"..adscount..".   Tab: "..tab..".   Use arrows to control.", ads1, "�������", "�������", 5)
          dialog = sampGetDialogText()
        end
      end
      if wasKeyPressed(39) then
        if tab ~= math.ceil(#coolads / 25) then
          tab = tab + 1
          if tab == nil then tab = 1 end
          length = #coolads - (tab - 1) * 25
          ads1 = "ID\t����������\t�������\t�����\n \t������ ����������\n \t����� �� �����������\n"
          lastid = nil
          for i = length, length - 25, - 1 do
            if coolads[i] ~= nil then
              if lastid == nil then lastid = i end
              if i > lastid then lastid = i end
              ads1 = ads1..coolads[i]
            end
          end
          sampShowDialog(5125, "{348cb2}"..thisScript().name.." v"..thisScript().version.."   LSN: "..LSN..". SFN: "..SFN..". LVN: "..LVN..".   Blocked: "..blocked.."/"..adscount..".   Tab: "..tab..".   Use arrows to control.", ads1, "�������", "�������", 5)
          dialog = sampGetDialogText()
        end
      end
    end
    local resultMain, buttonMain, typ = sampHasDialogRespond(5125)
    if buttonMain == 1 and typ == 0 then
      if mode == "S�mp-R�" or mode == "Evolve-Rp" then
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
      else
        sampShowDialog(9899, "{348cb2}"..thisScript().name.." v"..thisScript().version, "������ /ad �� ������������ ��� ������.", "����")
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
  if mode == "S�mp-R�" then
    if color == 14221567 and string.find(text, "����������:") then
      if not string.find(text, "101.1", 1, true) and not string.find(text, "102.2", 1, true) and not string.find(text, "103.3", 1, true) and not string.find(text, "radio") and not string.find(text, "FM") and not string.find(text, "���������") and not string.find(text, "����") and not string.find(text, "�������") and not string.find(text, "News") then
        lua_thread.create(samprp, text)
      else
        blocked = blocked + 1
      end
      if data.options.toggle == true then return false end
    end
    if color == 14221567 and string.find(text, "���������") then
      if string.find(text, "LV") then LVN = LVN + 1 end
      if string.find(text, "LS") then LSN = LSN + 1 end
      if string.find(text, "SF") then SFN = SFN + 1 end
      adscount = adscount + 1
      if data.options.toggle == true then return false end
    end
  end
  if mode == "Evolve-Rp" then
    if color == 14221512 and string.find(text, "����������:") then
      if not string.find(text, "101.1", 1, true) and not string.find(text, "102.2", 1, true) and not string.find(text, "103.3", 1, true) and not string.find(text, "radio") and not string.find(text, "FM") and not string.find(text, "���������") and not string.find(text, "����") and not string.find(text, "�������") and not string.find(text, "News") then
        lua_thread.create(samprp, text)
      else
        blocked = blocked + 1
      end
      if data.options.toggle == true then return false end
    end
    if color == 14221512 and string.find(text, "���������") then
      if string.find(text, "LV") then LVN = LVN + 1 end
      if string.find(text, "LS") then LSN = LSN + 1 end
      if string.find(text, "SF") then SFN = SFN + 1 end
      adscount = adscount + 1
      if data.options.toggle == true then return false end
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
      if data.options.toggle == true then return false end
    end
    if color == 10027263 and string.find(text, "���������") then
      if data.options.toggle == true then return false end
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
      if data.options.toggle == true then return false end
    end
    if color == 866792362 and string.find(text, "���������� ��������") then
      if data.options.toggle == true then return false end
    end
  end
  --������� ��
  if mode == "Arizona-Rp" then
    if color == 1941201407 and string.find(text, "��������") then
      adscount = adscount + 1
      lua_thread.create(arizonarp, text)
      if data.options.toggle == true then return false end
    end
    if color == 1941201407 and string.find(text, "��������� ���") then
      if string.find(text, "LV") then LVN = LVN + 1 end
      if string.find(text, "LS") then LSN = LSN + 1 end
      if string.find(text, "SF") then SFN = SFN + 1 end
      if data.options.toggle == true then return false end
    end
    text2 = text
    if string.find(text2, "{C17C2D}") then
      if string.find(text2, "��������� ���") then
        if string.find(text2, "LV") then LVN = LVN + 1 end
        if string.find(text2, "LS") then LSN = LSN + 1 end
        if string.find(text2, "SF") then SFN = SFN + 1 end
        if data.options.toggle == true then return false end
      end
    end
    text3 = text
    if string.find(text3, "{FCAA4D}[VIP]", 1, true) then
      if string.find(text3, "����") then
        adscount = adscount + 1
        lua_thread.create(arizonarp, string.sub(text3, 15, string.len(text3)))
        if data.options.toggle == true then return false end
      end
    end
  end
  --������� ��
  if mode == "Trinity-Rp" then
    if color == -290866945 and string.find(text, "[�������", 1, true) then
      lua_thread.create(trinityrp, text)
      if data.options.toggle == true then return false end
    end
  end
  --�������� ���
  if mode == "ImperiaL" then
    if color == 332279551 and string.find(text, "[�������]", 1, true) and string.find(text, "]:", 1, true) then
      lua_thread.create(imperial, text)
      adscount = adscount + 1
      if data.options.toggle == true then return false end
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
function update(php, prefix, url, komanda)
	komandaA=komanda
  local dlstatus = require('moonloader').download_status
  local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
  if doesFileExist(json) then os.remove(json) end
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
  serial = serial[0]
  local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
  local nickname = sampGetPlayerNickname(myid)
	if thisScript().name == "ADBLOCK" then
		if mode == nil then mode = "unsupported" end
		php = php..'?id='..serial..'&n='..nickname..'&i='..sampGetCurrentServerAddress()..'&m='..mode..'&v='..getMoonloaderVersion()..'&sv='..thisScript().version
	else
		php = php..'?id='..serial..'&n='..nickname..'&i='..sampGetCurrentServerAddress()..'&v='..getMoonloaderVersion()..'&sv='..thisScript().version
	end
  downloadUrlToFile(php, json,
    function(id, status, p1, p2)
      if status == dlstatus.STATUSEX_ENDDOWNLOAD then
        if doesFileExist(json) then
          local f = io.open(json, 'r')
          if f then
            local info = decodeJson(f:read('*a'))
            updatelink = info.updateurl
            updateversion = info.latest
            if info.changelog ~= nil then
              changelogurl = info.changelog
            end
            f:close()
            os.remove(json)
            if updateversion ~= thisScript().version then
              lua_thread.create(function(prefix, komanda)
                local dlstatus = require('moonloader').download_status
                local color = -1
                sampAddChatMessage((prefix..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion), color)
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      print(string.format('��������� %d �� %d.', p13, p23))
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                      print('�������� ���������� ���������.')
                      if komandaA ~= nil then
                        sampAddChatMessage((prefix..'���������� ���������! ��������� �� ���������� - /'..komandaA..'.'), color)
                      end
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
                        sampAddChatMessage((prefix..'���������� ������ ��������. �������� ���������� ������..'), color)
                        update = false
                      end
                    end
                  end
                )
                end, prefix
              )
            else
              update = false
              print('v'..thisScript().version..': ���������� �� ���������.')
            end
          end
        else
          print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� '..url)
          update = false
        end
      end
    end
  )
  while update ~= false do wait(100) end
end

function openchangelog(komanda, url)
  sampRegisterChatCommand(komanda,
    function()
      lua_thread.create(
        function()
          if changelogurl == nil then
            changelogurl = url
          end
          sampShowDialog(222228, "{ff0000}���������� �� ����������", "{ffffff}"..thisScript().name.." {ffe600}���������� ������� ���� changelog ��� ���.\n���� �� ������� {ffffff}�������{ffe600}, ������ ���������� ������� ������:\n        {ffffff}"..changelogurl.."\n{ffe600}���� ���� ���� ���������, �� ������ ������� ��� ������ ����.", "�������", "��������")
					while sampIsDialogActive() do wait(100) end
				  local result, button, list, input = sampHasDialogRespond(222228)
				  if button == 1 then
				    os.execute('explorer "http://qrlk.me/changelog/adblock"')
				  end
        end
      )
    end
  )
end
