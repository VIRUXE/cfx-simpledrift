local kmh, mph = 3.6, 2.23693629
local speedUnit = kmh -- or mph
local speedLimit = 1000.0 

local driftMode = false
local driftKey, activationKey = 21, 'k' -- LEFT SHIFT

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500) -- I find it easier to control with this delay. Specially around corners.

		if driftMode then
			local pPed 		= PlayerPedId()
			local pVehicle 	= GetVehiclePedIsIn(pPed, false)

			if pVehicle and GetPedInVehicleSeat(pVehicle, -1) == pPed then -- Is player the one driving
				if ((GetEntitySpeed(pVehicle) * speedUnit) <= speedLimit) then -- Check if within "limit"
					SetVehicleReduceGrip(pVehicle, IsControlPressed(0, driftKey))
				end
			end
		end
	end
end)

RegisterCommand('driftmode', function()
	driftMode = not driftMode
	
	TriggerEvent('chat:addMessage', {
		color = { 255, 0, 0},
		multiline = true,
		args = {"SERVER ", string.format("Drift Mode is %s", (driftMode and "ON" or "OFF"))}
	  })
end)

RegisterKeyMapping('driftmode', 'Toggle Drift Mode', 'keyboard', activationKey)