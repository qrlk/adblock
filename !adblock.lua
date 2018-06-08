--������ �������� �� ������ ����� ����� �� �����: http://www.rubbishman.ru/samp
--------------------------------------------------------------------------------
-------------------------------------META---------------------------------------
--------------------------------------------------------------------------------
script_name("ADBLOCK")
script_version("1.6")
script_author("rubbishman")
script_description("/ads")
-------------------------------------var----------------------------------------
local sampev = require 'lib.samp.events'
local dlstatus = require('moonloader').download_status
id = -1
ads1 = "ID\t����������\t�������\t�����\n"
adnicks = {}
allads = {}
LSN = 0
SFN = 0
LVN = 0
color = 0xFFFFF
-------------------------------------MAIN---------------------------------------
function main()
	if not isSampfuncsLoaded() or not isSampLoaded() then return end
	while not isSampAvailable() do wait(100) end

	-- ������ ���, ���� ������ ��������� �������� ����������
	update()
	while update ~= false do wait(100) end
	-- ������ ���, ���� ������ ��������� �������� ����������

	-- �������� ���, ���� ������ ��������� ��������� ��� ����� � ����
	sampAddChatMessage(("ADBLOCK by rubbishman successfully loaded! /ads - show hidden ads!"), color)
	-- �������� ���, ���� ������ ��������� ��������� ��� ����� � ����

	sampRegisterChatCommand("ads", ads)
	while true do
		wait(0)
	end
end
--��������� ������� ������
function new(text)
	trigger = false
	--sampAddChatMessage(text, - 1) -- ��� ������� � ��� ������, ������� ������ ������ � ������
	for i = #allads - 35, #allads do
		if allads[i] ~= nil and text == allads[i] then trigger = true break end
	end
	if trigger == false then
		id = id + 1
		allads[id] = text
		adtext = string.sub(text, 13, string.find(text, " �������: ") - 2)
		adnick = string.sub(text, string.find(text, " �������: ") + 10, string.find(text, " ���: ") - 2)
		adnomer = string.sub(text, string.find(text, " ���: ") + 6, string.len(text))
		adnicks[id] = adnick
		ads1 = "ID\t����������\t�������\t�����\n".."["..id.."]\t["..os.date("%H:%M:%S").."] "..adtext.."\t"..adnick.."\t"..string.format("%s", adnomer).."\n"..string.gsub(ads1, "ID\t����������\t�������\t�����\n", "")
		if id > 35 then ads1 = string.sub(ads1, 1, (string.find(ads1, "\n%["..(id - 35).."%]") - 1)) end --� ������� ����������� ���� ����� �� ����� ������, ������� ����� ����������� � 35 �����. ����� ������������ �� ����������, �� ��� ����.
	end
	trigger = false
end
--��������� ������ ������� ����������
function ads()
	lua_thread.create(adss)
end
--������ ������� ����������
function adss()
	sampShowDialog(5125, "{348cb2}"..thisScript().name.." v"..thisScript().version.."   LSN: "..LSN..". SFN: "..SFN..". LVN: "..LVN..".", ads1, "�������", "�������", 5)
	dialog = sampGetDialogText()
	lastid = id
	while sampIsDialogActive(5125) do wait(100) end
	local resultMain, buttonMain, typ = sampHasDialogRespond(5125)
	if buttonMain == 1 and ads1 ~= "ID\t����������\t�������\t�����\n" then
		for i = 0, 1001 do
			if sampIsPlayerConnected(i) and sampGetPlayerNickname(i) == adnicks[lastid - typ] then
				sampShowDialog(9899, "����������: "..adnicks[lastid - typ], "������� ����� ����� � ������� \"���������\".", "���������", "�������", 1)
				while sampIsDialogActive(9899) do wait(100) end
				local resultMain, buttonMain, typ = sampHasDialogRespond(9899)
				if buttonMain == 1 then
					if sampGetCurrentDialogEditboxText(9899) ~= "" then
						sampSendChat("/t "..i.." "..sampGetCurrentDialogEditboxText(9899))
					end
				else
					ads()
				end
				break
			end
			if i == 1001 then sampShowDialog(9899, "{348cb2}"..thisScript().name.." v"..thisScript().version, "����� "..adnicks[lastid - typ].." �������.", "����") break end
		end
	end
end
--------------------------------------------------------------------------------
-------------------------------------HOOK---------------------------------------
--------------------------------------------------------------------------------
function sampev.onServerMessage(color, text)
	if color == 14221512 and string.find(text, "����������:") then
		if not string.find(text, "101.1") and not string.find(text, "102.2") and not string.find(text, "103.3") and not string.find(text, "radio") and not string.find(text, "FM") and not string.find(text, "���������") and not string.find(text, "����") then
			lua_thread.create(new, text)
		end
		return false
	end
	if color == 14221512 and string.find(text, "���������") then
		if string.find(text, "LV") then LVN = LVN + 1 end
		if string.find(text, "LS") then LSN = LSN + 1 end
		if string.find(text, "SF") then SFN = SFN + 1 end
		return false
	end
end
--------------------------------------------------------------------------------
------------------------------------UPDATE--------------------------------------
--------------------------------------------------------------------------------
function update()
	local fpath = os.getenv('TEMP') .. '\\adblock-version.json'
	downloadUrlToFile('http://rubbishman.ru/dev/samp/adblock/version.json', fpath, function(id, status, p1, p2)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
		local f = io.open(fpath, 'r')
		if f then
			local info = decodeJson(f:read('*a'))
			updatelink = info.updateurl
			if info and info.latest then
				version = tonumber(info.latest)
				if version > tonumber(thisScript().version) then
					lua_thread.create(goupdate)
				else
					update = false
				end
			end
		end
	end
end)
end
--���������� ���������� ������
function goupdate()
sampAddChatMessage(("[ADBLOCK]: ���������� ����������. �������� ����������.."), color)
sampAddChatMessage(("[ADBLOCK]: ������� ������: "..thisScript().version..". ����� ������: "..version), color)
wait(300)
downloadUrlToFile(updatelink, thisScript().path, function(id3, status1, p13, p23)
	if status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
	sampAddChatMessage(("[ADBLOCK]: ���������� ���������!"), color)
	thisScript():reload()
end
end)
end
