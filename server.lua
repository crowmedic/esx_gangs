ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.Gangs = {}

AddEventHandler('onMySQLReady', function ()

  MySQL.Async.fetchAll('SELECT * FROM gangs', {}, function(gangs)

    for i=1, #gangs, 1 do
	local name = gangs[i].name
	local label = gangs[i].label
	ESX.Gangs[name] = {
		label = label,
		ranks = {}
	}
	MySQL.Async.fetchAll('SELECT * FROM gang_grades WHERE gang_name = @name', {['@name'] = name}, function (grades)
	  for i=1, #grades, 1 do
	    local grade = grades[i].grade
	    local name2 = grades[i].name
	    local label2 = grades[i].label
		ESX.Gangs[name].ranks[grade] = {
		  name = name2,
		  label = label2
		}
	    print (ESX.Gangs[name].label)
		print (ESX.Gangs[name].ranks[grade].label)
	  end
	end)
	
    end
  end)  
end)

RegisterServerEvent('esx_gangs:getGangMembers')--Fetches all players in one gang
RegisterServerEvent('esx_gangs:getPlayerGang')--Fetches player current gang and rank
RegisterServerEvent('esx_gangs:setPlayerGang')--Sets player gang and rank
RegisterServerEvent('esx_gangs:getGangMoney')--Gets society money for gang
RegisterServerEvent('esx_gangs:addGangMoney')--Adds money to society
RegisterServerEvent('esx_gangs:removeGangMoney')--Removes money from society
RegisterServerEvent('esx_gangs:getGangLocker')--Gets weapons in gang locker
RegisterServerEvent('esx_gangs:modifyGangLocker')--Modifies gang weapon locker

AddEventHandler('esx:playerLoaded', function(source) 
  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(_source)
  local gangData = {}
  MySQL.Async.fetchAll('SELECT * FROM `users` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(gangInfo)
    gangData.gang = gangInfo[1].gang
	gangData.gang_grade = gangInfo[1].gang_grade
  TriggerClientEvent('esx_gangs:gangLoaded', _source, gangData, ESX.Gangs)
end)
end)



AddEventHandler('esx_gangs:getGangMembers', function(source, gang)

  local _source = source
  local cbmembers = {}
  MySQL.Async.fetchAll('SELECT `identifier`,`gang_grade`,`firstname`,`lastname` FROM `users` WHERE `gang` = @gang',{['@gang'] = gang}, function(members)
    for i=1, #members, 1 do
	  cbmembers[i] = {
	    identifier = members[i].identifier,
		grade = members[i].gang_grade,
		fname = members[i].firstname,
		lname = members[i].lastname
	  }
	end
  TriggerClientEvent('esx_gangs:GangMembers', _source, cbmembers)
  end)
end)

AddEventHandler('esx_gangs:setPlayerGang', function(source, player, gang, grade)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(player)
  local _gang = gang
  local _grade = grade
  MySQL.Async.execute('UPDATE `users` SET `gang` = @gang, `gang_grade` = @grade WHERE `identifier` = @identifier', 
  {
  ['@gang'] = _gang,
  ['@grade'] = _grade,
  ['@identifier'] = xPlayer.identifier
  }, function ()
  end)
  TriggerClientEvent ('esx_gangs:UpdateGang', player, _gang, _grade)
end)

AddEventHandler('esx_gangs:getGangMoney', function(source, gang)

end)

AddEventHandler('esx_gangs:addGangMoney', function(source, gang, amount)

end)

AddEventHandler('esx_gangs:removeGangMoney', function(source, gang, amount)

end)

AddEventHandler('esx_gangs:getGangLocker', function(source, gang, cb)

end)

AddEventHandler('esx_gangs:modifyGangLocker', function(source, gang, locker)

end)

--setgang cmd
TriggerEvent('es:addGroupCommand', 'setgang', 'admin', function(source, args, user)
  local player = args[1]
  local gang = args[2]
  local grade = args[3]
  TriggerEvent('esx_gangs:setPlayerGang', source, player, gang, grade)
  
end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficient Permissions.")
end, {help = 'setgang', params = {{name = "id", help = 'PlayerID'}, {name = "gang", help = 'Gang'}, {name = "grade_id", help = 'Grade'}}})
