ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.Gangs = {}

AddEventHandler('onMySQLReady', function ()

  MySQL.Async.fetchAll('SELECT * FROM gangs', {}, function(gangs)
    MySQL.Async.fetchAll('SELECT * FROM gang_grades', {}, function(grades)

      for i=1, #gangs, 1 do
        ESX.Gangs[gangs[i].name] = {
          label = gangs[i].label,
		  color = json.decode(gangs[i].color),
          ranks = {}
        }
      end

      for i=1, #grades, 1 do
        ESX.Gangs[grades[i].gang_name].ranks[grades[i].grade] = {
            name = grades[i].name,
            label = grades[i].label
        }
		print (grades[i].gang_name)
		print (grades[i].label)
      end    
    end)
  end)  
end)

RegisterServerEvent('esx_gangs:getGangMembers')--Fetches all players in one gang
RegisterServerEvent('esx_gangs:getPlayerGang')--Fetches player current gang and rank
RegisterServerEvent('esx_gangs:setPlayerGang')--Sets player gang and rank
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
  
  local gangData = {
    name = _gang,
	gang_grade = tonumber(_grade),
	gang_label = ESX.Gangs[gang].label,
	gang_grade_label = ESX.Gangs[gang].ranks[tonumber(grade)].label,
	gang_grade_name = ESX.Gangs[gang].ranks[tonumber(grade)].name
  }
  TriggerClientEvent ('esx_gangs:UpdateGang', player, gangData)
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
