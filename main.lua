RMenu.Add('accr', 'main', RageUI.CreateMenu("USS Luxington", "Aircraft Carrier Control Center"))
RMenu:Get('accr', 'main'):SetRectangleBanner(200, 170, 40)

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('accr', 'main'), true, true, true, function()
	
			RageUI.ButtonWithStyle("Catapult",nil, {RightBadge = RageUI.BadgeStyle.Alert }, true, function(Hovered, Active, Selected)
				if Selected then  
					local result = 1
					KeyboardInput("Please enter the Catapult Strength (1-20)", "", 2)
					ExecuteCommand('catapult ' .. result)
				end
			end)

			RageUI.ButtonWithStyle("Elevator",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
				if Selected then   
					ExecuteCommand('elevator')
				end
			end)
	
			RageUI.ButtonWithStyle("Runway-Takeoff",nil, {RightBadge = RageUI.BadgeStyle.Alert }, true, function(Hovered, Active, Selected)
				if Selected then   
					local result = 1
					KeyboardInput("Please enter the Thrust Strength (1-20)", "", 2)
					ExecuteCommand('runway ' .. result)
				end
			end)
		
			RageUI.ButtonWithStyle("Runway-Touchdown",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
				if Selected then   
					ExecuteCommand('runwayland')
				end
			end)
	
			RageUI.ButtonWithStyle("Runway-Reset",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
				if Selected then   
					ExecuteCommand('resetrunway')
				end
			end)

        end, function()
	    end)
        
        Citizen.Wait(0)
    end
end)       

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1)
		if IsControlJustReleased(0 , 73) then
			RageUI.Visible(RMenu:Get('accr', 'main'), not RageUI.Visible(RMenu:Get('accr', 'main')))
		end
	end
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = 1 
		result = tonumber(GetOnscreenKeyboardResult())
		Citizen.Wait(500)
		blockinput = false
		if result >= 20 then
			result = 20
		elseif result <= 1 then
			result = 1
		end
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end