ESX = nil
Config.Gangs = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('onMySQLReady', function (cb)

  MySQL.Async.fetchAll('SELECT * FROM gangs', {}, function(gangs)

    for i=1, #gangs, 1 do
	  local name = gang[i].name
      table.insert(Config.Gangs.name, {
        label     = Gangs[i].label
		ranks	  = {}
      })

    end

  end)
  
  MySQL.Async.fetchAll('SELECT * FROM gang_grades', {}, function(gang_grades)
    for i=1, #gang_grades, 1 do
	  local name = gang_grades[i].gang_name
	  table.insert(Config.Gangs.name.ranks, {
		grade = gang_grades[i].grade
		name = gang_grades[i].name
		label = gang_grades[i].label
	  })
	end
  end)
  cb(Config.Gangs)  
end)

RegisterServerEvent('esx_gangs:onPlayerConnect')
RegisterServerEvent('esx_gangs:getGangData')--Fetches SQL data on gangs for player
RegisterServerEvent('esx_gangs:getGangMembers')--Fetches all players in one gang
RegisterServerEvent('esx_gangs:getPlayerGang')--Fetches player current gang
RegisterServerEvent('esx_gangs:setPlayerGang')--Sets player gang
RegisterServerEvent('esx_gangs:getPlayerGangRank')--Fetches player gang rank
RegisterServerEvent('esx_gangs:setPlayerGangRank')--Sets player gang rank
RegisterServerEvent('esx_gangs:getGangMoney')--Gets society money for gang
RegisterServerEvent('esx_gangs:addGangMoney')--Adds money to society
RegisterServerEvent('esx_gangs:removeGangMoney')--Removes money from society
RegisterServerEvent('esx_gangs:getGangLocker')--Gets weapons in gang locker
RegisterServerEvent('esx_gangs:modifyGangLocker')--Modifies gang weapon locker

AddEventHandler('esx_gangs:onPlayerConnect', function(player, cb)

end)

AddEventHandler('esx_gangs:getGangData', function()

end)

AddEventHandler('esx_gangs:getGangMembers', function(gang, cb)

end)

AddEventHandler('esx_gangs:getPlayerGang', function(player, cb)

end)

AddEventHandler('esx_gangs:setPlayerGang', function(player)

end)

AddEventHandler('esx_gangs:getPlayerGangRank', function(player, cb)

end)

AddEventHandler('esx_gangs:setPlayerGangRank', function(player)

end)

AddEventHandler('esx_gangs:getGangMoney', function(gang, cb)

end)

AddEventHandler('esx_gangs:addGangMoney', function(gang, amount)

end)

AddEventHandler('esx_gangs:removeGangMoney', function(gang, amount)

end)

AddEventHandler('esx_gangs:getGangLocker', function(gang, cb)

end)

AddEventHandler('esx_gangs:modifyGangLocker', function(gang, locker)

end)
