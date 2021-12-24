local MainMenu = RageUI.CreateMenu("SGJAIL", "Prison"); -- Options menu
MainMenu.EnableMouse = false;

local Checked = false;
local ListIndex = 1;
Jailtime = 0;
JailReason = "Default";
local GridX, GridY = 0, 0
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
ESX                             = nil
RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(newData)
	PlayerData = newData

	Citizen.Wait(250)

	ESX.TriggerServerCallback("esx_jail:get", function(inJail, newJailTime, newJailReason)
		if inJail then
            Jailtime = newJailTime
            JailReason = newJailReason

			JailLogin()
            JailIn()
            Verif()
		end
	end)
    
end)
function RageUI.PoolMenus:Example()
    MainMenu:IsVisible(function(Items)
        Items:AddButton("" ..Jailtime.." Secondes", "" ..Jailtime.." Secondes", { IsDisabled = true }, function(onSelected)

        end)
        Items:AddButton("Raison : ".. JailReason .. "", "Raison : "..JailReason.. "", { IsDisabled = true }, function(onSelected)

        end)


    end, function(Panels)
    end)
end
Citizen.CreateThread(function()
    Verif()
end)
function Verif()
Citizen.CreateThread(function()
    while Jailtime == 0 do
    Wait(10000) 
    ESX.TriggerServerCallback("esx_jail:get", function(inJail, newJailTime, newJailReason)
        if inJail then
             if Jailtime <= 0 then
             Jailtime = newJailTime
             JailReason = newJailReason
             JailLogin()
             JailIn()
             end
    
        end
    end)
    end
    end)
end
function JailLogin()
	SetEntityCoords(PlayerPedId(), 1799.8345947266, 2489.1350097656, -119.02998352051 - 1)
end

function JailIn()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    Citizen.CreateThread(function()
    while (Jailtime > 0) do 
        Jailtime = Jailtime - 1
        TriggerEvent('esx_status:set', 'hunger', 1000000)
        TriggerEvent('esx_status:set', 'thirst', 1000000)
        local playerPed = PlayerPedId()
        SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
        if Jailtime == 0 then
            ESX.TriggerServerCallback("esx_jail:update", function(unJail)
                RageUI.CloseAll()
                SetEntityCoords(PlayerPedId(), 1841.638, 2533.722, 45.672)
            end)
            Jailtime = 0;
            Verif()
        end
        Wait( 1000 ) 
    end
    end)
Citizen.CreateThread(function()
while Jailtime > 0 do
    DisableControlAction(0,21,false)
    DisableControlAction(0,24,false)
    DisableControlAction(0,25,false)
    DisableControlAction(0,47,false)
    DisableControlAction(0,58,false)
    DisableControlAction(0,71,false)
    DisableControlAction(0,72,false)
    DisableControlAction(0,63,false) 
    DisableControlAction(0,64,false) 
    DisableControlAction(0,263,false) 
    DisableControlAction(0,264,false) 
    DisableControlAction(0,257,false) 
    DisableControlAction(0,140,false) 
    DisableControlAction(0,141,false) 
    DisableControlAction(0,142,false) 
    DisableControlAction(0,143,false) 
    DisableControlAction(0,177,false) 
    DisableControlAction(0,178,false) 
    DisableControlAction(0,37,false) 
    RageUI.CloseAll()
    RageUI.Visible(MainMenu, not RageUI.Visible(MainMenu))
    Wait(1)
end
end)
end