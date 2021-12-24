ESX, players = nil, {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("jail", function(src, args, raw)

	local xPlayer = ESX.GetPlayerFromId(src)
    local source = src
    if players[source] then
        return
    end
	if xPlayer.getGroup() == "user" then
		return
	end

		local jailPlayer = args[1]
		local jailTime = tonumber(args[2])
		local jailReason = args[3]

		if GetPlayerName(jailPlayer) ~= nil then
			if jailTime ~= nil then
				if args[3] ~= nil then
					local xPlayer1 = ESX.GetPlayerFromId(jailPlayer)
					local Identifier1 = xPlayer1.identifier
					TriggerClientEvent("esx:showNotification", source, "[".. jailPlayer .. "] " ..GetPlayerName(jailPlayer).. " a été mit en jail !")
					TriggerClientEvent("esx:showNotification", source, "Temps: ".. jailTime .. "")
					TriggerClientEvent("esx:showNotification", source, "Raison: ".. jailReason .. "")
					MySQL.Async.execute(
						"UPDATE users SET jail = @identifier2 WHERE identifier = @identifier",
						{
							['@identifier'] = Identifier1,
							['@identifier2'] = "1"
						}
					)
					MySQL.Async.execute(
						"UPDATE users SET time = @identifier22  WHERE identifier = @identifier1",
						{
							['@identifier1'] = Identifier1,
							['@identifier22'] = jailTime
						}
					)
					MySQL.Async.execute(
						"UPDATE users SET jail_reason = @identifier222  WHERE identifier = @identifier1",
						{
							['@identifier1'] = Identifier1,
							['@identifier222'] = jailReason
						}
					)
				end
			else
				TriggerClientEvent("esx:showNotification", src, "Temps invalide!")
			end
		else
			TriggerClientEvent("esx:showNotification", src, "Ce joueur n\'est pas connecté")
		end
end)

ESX.RegisterServerCallback("esx_jail:update", function(source, cb)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier


	MySQL.Async.execute(
		"UPDATE users SET jail = @identifier2 WHERE identifier = @identifier",
		{
			['@identifier'] = Identifier,
			['@identifier2'] = "0"
		}
	)
	MySQL.Async.execute(
		"UPDATE users SET time = @identifier22  WHERE identifier = @identifier1",
		{
			['@identifier1'] = Identifier,
			['@identifier22'] = "0"
		}
	)
	cb(true)
end)
ESX.RegisterServerCallback("esx_jail:get", function(source, cb)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier


	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		local JailTime = tonumber(result[1].time)
		local reason = result[1].jail_reason
		if result[1].jail == 1 then

		if JailTime > 0 then

			cb(true, JailTime, reason)
		else
			cb(false, 0)
		end
	end

	end)
end)