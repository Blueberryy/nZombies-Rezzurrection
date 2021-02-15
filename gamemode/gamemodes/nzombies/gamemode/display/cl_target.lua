--

local traceents = {
	["wall_buys"] = function(ent)
		local wepclass = ent:GetWepClass()
		local price = ent:GetPrice()
		local wep = weapons.Get(wepclass)
		upgrade= ""
		upgrade2=""
		if wep.NZPaPReplacement then
		upgrade = wep.NZPaPReplacement
		local wep2 =  weapons.Get( wep.NZPaPReplacement)
		if  wep2.NZPaPReplacement then
		 upgrade2 = wep2.NZPaPReplacement
		else
		 upgrade2 = ""
		end
		else
		 upgrade = ""
		end
		if !wep then return "INVALID WEAPON" end
		local name = wep.PrintName
		local ammo_price = math.Round((price - (price % 10))/2)
		local text = ""
		if  LocalPlayer():HasWeapon( upgrade ) then
		 pap = true
		end
		if  LocalPlayer():HasWeapon( upgrade2 ) then
		 pap = true
		end
		
		if !LocalPlayer():HasWeapon( wepclass ) and !pap then
			text = translate.Format("nzr_press_e_to_buy_weapon_for_price_points", name, price)
		elseif string.lower(wep.Primary.Ammo) != "none" then
			if pap then
			if  LocalPlayer():HasWeapon( upgrade ) then
			if LocalPlayer():GetWeapon( upgrade ):HasNZModifier("pap") then
			text = translate.Format("nzr_press_e_to_buy_ammotype_ammo_for_price_points", wep.Primary.Ammo)
			pap = false
			end
			
			elseif LocalPlayer():HasWeapon( upgrade2 ) then
			if LocalPlayer():GetWeapon( upgrade2 ):HasNZModifier("pap") then
			text = translate.Format("nzr_press_e_to_buy_ammotype_ammo_for_price_points", wep.Primary.Ammo)
			pap = false
			end
			end
			else
			if LocalPlayer():GetWeapon( wepclass ):HasNZModifier("pap") then
				text = translate.Format("nzr_press_e_to_buy_ammotype_ammo_for_price_points", wep.Primary.Ammo)
			else
				text = translate.Format("nzr_press_e_to_buy_ammotype_ammo_for_price_points2", wep.Primary.Ammo, ammo_price)
			end
			end
		else
			text = translate.Get("nzr_you_already_have_this_weapon")
		end

		return text
	end,
	["breakable_entry"] = function(ent)
		if ent:GetHasPlanks() and ent:GetNumPlanks() < GetConVar("nz_difficulty_barricade_planks_max"):GetInt() then
			local text = translate.Get("nzr_hold_e_to_rebuild_the_barricade")
			return text
		end
	end,
	["random_box"] = function(ent)
		if !ent:GetOpen() then
			local text = nzPowerUps:IsPowerupActive("firesale") and translate.Get("nzr_press_e_to_buy_a_random_weapon_for_10_points") or translate.Get("nzr_press_e_to_buy_a_random_weapon_for_950_points")
			return text
		end
	end,
	["random_box_windup"] = function(ent)
		if !ent:GetWinding() and ent:GetWepClass() != "nz_box_teddy" then
			local wepclass = ent:GetWepClass()
			local wep = weapons.Get(wepclass)
			local name = translate.Get("unknown")
			if wep != nil then
				name = wep.PrintName
			end
			if name == nil then name = wepclass end
			name = translate.Format("press_e_to_take_weapon_from_the_box", name)

			return name
		end
	end,
	["perk_machine"] = function(ent)
		local text = ""
		if !ent:IsOn() then
			text = translate.Get("no_power")
		elseif ent:GetBeingUsed() then
			text = translate.Get("currently_in_use")
		else
			if ent:GetPerkID() == "pap" then
				local wep = LocalPlayer():GetActiveWeapon()
				if wep:HasNZModifier("pap") then
					if wep.NZRePaPText then
						text = translate.Format("press_e_to_pap_for_2000_points", wep.NZRePaPText)
					elseif wep:CanRerollPaP() then
						text = translate.Get("press_e_to_reroll_attachments")
					else
						text = translate.Get("this_weapon_is_already_upgraded")
					end
				else
					text = translate.Get("press_e_to_buy_packapunch_for_5000_points")
				end
			else
				local perkData = nzPerks:Get(ent:GetPerkID())
				-- Its on
				if nzPerks:GetMachineType(nzMapping.Settings.perkmachinetype) == "IW" then
						text = translate.Format("press_e_to_buy_perknameskin_for_x_points", translate.Get(perkData.name_skin), ent:GetPrice())
						else
						text = translate.Format("press_e_to_buy_perkname_for_x_points", translate.Get(perkData.name), ent:GetPrice())
						end
				-- Check if they already own it
				if LocalPlayer():HasPerk(ent:GetPerkID()) then
					text = translate.Get("you_already_own_this_perk")
				end
			end
		end

		return text
	end,
	["player_spawns"] = function() if nzRound:InState( ROUND_CREATE ) then return "Player Spawn" end end,
	["nz_spawn_zombie_normal"] = function() if nzRound:InState( ROUND_CREATE ) then return "Zombie Spawn" end end,
	["nz_spawn_zombie_special"] = function() if nzRound:InState( ROUND_CREATE ) then return "Zombie Special Spawn" end end,
	["nz_spawn_zombie_boss"] = function() if nzRound:InState( ROUND_CREATE ) then return "Zombie Boss Spawn" end end,
	["pap_weapon_trigger"] = function(ent)
		local wepclass = ent:GetWepClass()
		local wep = weapons.Get(wepclass)
		local name = translate.Get("unknown")
		if wep != nil then
			name = nz.Display_PaPNames[wepclass] or nz.Display_PaPNames[wep.PrintName] or "Upgraded "..wep.PrintName
		end
		name = translate.Format("press_e_to_take_perk_from_the_machine", name)

		return name
	end,
	["wunderfizz_machine"] = function(ent)
		local text = ""
		if !ent:IsOn() then
			text = translate.Get("the_wunderfizz_is_currently_at_another_location")
		elseif ent:GetBeingUsed() then
			if ent:GetUser() == LocalPlayer() and ent:GetPerkID() != "" and !ent:GetIsTeddy() then
				
				if nzPerks:GetMachineType(nzMapping.Settings.perkmachinetype) == "IW" then
						text = translate.Format("press_e_to_take_perkskin_der", nzPerks:Get(ent:GetPerkID()).name_skin)
						else
						text = translate.Format("press_e_to_take_perk_der", nzPerks:Get(ent:GetPerkID()).name)
						end
			else
				text = translate.Get("currently_in_use")
			end
		else
			if #LocalPlayer():GetPerks() >= GetConVar("nz_difficulty_perks_max"):GetInt() then
				text = translate.Get("you_cannot_have_more_perks")
			else
				text = translate.Format("press_e_to_buy_der_wunderfizz", ent:GetPrice())
			end
		end

		return text
	end,
}

local function GetTarget()
	local tr =  {
		start = EyePos(),
		endpos = EyePos() + LocalPlayer():GetAimVector()*150,
		filter = LocalPlayer(),
	}
	local trace = util.TraceLine( tr )
	if (!trace.Hit) then return end
	if (!trace.HitNonWorld) then return end

	--print(trace.Entity:GetClass())
	return trace.Entity
end

local function GetDoorText( ent )
	local door_data = ent:GetDoorData()
	local text = ""

	if door_data and tonumber(door_data.price) == 0 and nzRound:InState(ROUND_CREATE) then
		if tobool(door_data.elec) then
			text = translate.Get("this_door_will_open_when_electricity")
		else
			text = translate.Get("this_door_will_open_on_game_start")
		end
	elseif door_data and tonumber(door_data.buyable) == 1 then
		local price = tonumber(door_data.price)
		local req_elec = tobool(door_data.elec)
		local link = door_data.link

		if ent:IsLocked() then
			if req_elec and !IsElec() then
				text = translate.Get("nzr_you_must_turn_on_the_electricity_first")
			elseif door_data.text then
				text = door_data.text
			elseif price != 0 then
				--print("Still here", nz.nzDoors.Data.OpenedLinks[tonumber(link)])
				text = translate.Format("nzr_press_e_to_open_for_price_points", price)
			end
		end
		elseif door_data and tonumber(door_data.buyable) != 1 and nzRound:InState( ROUND_CREATE ) then
		text = translate.Get("this_door_is_locked_and_cannot_be_bought")
		--PrintTable(door_data)
	end

	return text
end

local function GetText( ent )

	if !IsValid(ent) then return "" end
	
	if ent.GetNZTargetText then return ent:GetNZTargetText() end

	local class = ent:GetClass()
	local text = ""

	local neededcategory, deftext, hastext = ent:GetNWString("NZRequiredItem"), ent:GetNWString("NZText"), ent:GetNWString("NZHasText")
	local itemcategory = ent:GetNWString("NZItemCategory")

	if neededcategory != "" then
		local hasitem = LocalPlayer():HasCarryItem(neededcategory)
		text = hasitem and hastext != "" and hastext or deftext
	elseif deftext != "" then
		text = deftext
	elseif itemcategory != "" then
		local item = nzItemCarry.Items[itemcategory]
		local hasitem = LocalPlayer():HasCarryItem(itemcategory)
		if hasitem then
			text = item and item.hastext or translate.Get("you_already_have_this")
		else
			text = item and item.text or translate.Get("press_e_to_pick_up")
		end
	elseif ent:IsPlayer() then
		if ent:GetNotDowned() then
			text = translate.Format("player_hp", ent:Nick(), ent:Health())
		else
			text = translate.Format("hold_e_to_revive_x", ent:Nick())
		end
	elseif ent:IsDoor() or ent:IsButton() or ent:GetClass() == "class C_BaseEntity" or ent:IsBuyableProp() then
		text = GetDoorText(ent)
	else
		text = traceents[class] and traceents[class](ent)
	end

	return text
end

local function GetMapScriptEntityText()
	local text = ""

	for k,v in pairs(ents.FindByClass("nz_script_triggerzone")) do
		local dist = v:NearestPoint(EyePos()):Distance(EyePos())
		if dist <= 1 then
			text = GetDoorText(v)
			break
		end
	end

	return text
end

local function DrawTargetID( text )

	if !text then return end

	local font = "nz.display.hud.small"
	surface.SetFont( font )
	local w, h = surface.GetTextSize( text )

	local MouseX, MouseY = gui.MousePos()

	if ( MouseX == 0 && MouseY == 0 ) then

		MouseX = ScrW() / 2
		MouseY = ScrH() / 2

	end

	local x = MouseX
	local y = MouseY

	x = x - w / 2
	y = y + 30

	-- The fonts internal drop shadow looks lousy with AA on
	draw.SimpleText( text, font, x+1, y+1, Color(255,255,255,255) )
end


function GM:HUDDrawTargetID()

	local ent = GetTarget()

	if ent != nil then
		DrawTargetID(GetText(ent))
	else
		DrawTargetID(GetMapScriptEntityText())
	end

end
