local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local GUI           = {}
GUI.Time            = 0
local PlayerData = {}
PlayerData.gang = {
  name = nil,
  gang_grade = nil,
  gang_label = nil,
  gang_grade_label = nil,
  gang_grade_name = nil,
  money = 0,
  locker = nil,
  garage = nil
}

ESX              = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	print ('ESX received from server')
end)


RegisterNetEvent('esx_gangs:gangLoaded')
AddEventHandler('esx_gangs:gangLoaded', function(gangData, Gangs)
    PlayerData.gang.name = gangData.gang
    PlayerData.gang.gang_grade = gangData.gang_grade
	ESX.Gangs = Gangs
	print ('GangData recieved')
	print (PlayerData.gang.name)
	print (PlayerData.gang.gang_grade)
	
	PlayerData.gang.gang_label = ESX.Gangs[gangData.gang].label
	PlayerData.gang.gang_grade_label = ESX.Gangs[gangData.gang].ranks[gangData.gang_grade].label
	PlayerData.gang.gang_grade_name = ESX.Gangs[gangData.gang].ranks[gangData.gang_grade].name
	
end)

RegisterNetEvent('esx_gangs:GangMembers')
AddEventHandler('esx_gangs:GangMembers', function(members)
   PlayerData.gang.members = members
end)

RegisterNetEvent('esx_gangs:UpdateGang')
AddEventHandler('esx_gangs:UpdateGang', function (gang, grade)
  PlayerData.gang = gang
  PlayerData.gang_grade = grade
  print ('GangData updated')
  print (PlayerData.gang)
  print (PlayerData.gang_grade)
	PlayerData.gang.gang_label = ESX.Gangs[gang].label
	PlayerData.gang.gang_grade_label = ESX.Gangs[gang].ranks[grade].label
	PlayerData.gang.gang_grade_name = ESX.Gangs[gang].ranks[grade].name  
end)


--Debug to check current gangdata
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
	if IsControlPressed(0,  Keys['[']) then
	  Citizen.Wait(500)
	  print ('---Displaying Gang Data---')
	    print (PlayerData.gang.gang_label)
	    print (PlayerData.gang.gang_grade_label)
	end
  end
end)
