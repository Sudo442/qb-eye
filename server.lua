QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Code

QBCore.Commands.Add("refresheye", "Reset het oogje", {}, false, function(source, args)
    TriggerClientEvent('qb-eye:client:refresh', source)
end)

RegisterServerEvent('qb-eye:server:setup:trunk:data')
AddEventHandler('qb-eye:server:setup:trunk:data', function(Plate)
    Config.TrunkData[Plate] = {['Busy'] = false}
    TriggerClientEvent('qb-eye:client:sync:trunk:data', -1, Config.TrunkData)
end)

RegisterServerEvent('qb-eye:server:set:trunk:data')
AddEventHandler('qb-eye:server:set:trunk:data', function(Plate, Bool)
    Config.TrunkData[Plate]['Busy'] = Bool
    TriggerClientEvent('qb-eye:client:sync:trunk:data', -1, Config.TrunkData)
end)
