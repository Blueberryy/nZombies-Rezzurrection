if SERVER then
	function nzRound:SetNextSpecialRound( num )
		self.NextSpecialRound = num
	end

	function nzRound:GetNextSpecialRound()
		return self.NextSpecialRound
	end

	function nzRound:MarkedForSpecial( num )
		return ((self.NextSpecialRound == num and self.SpecialRoundType and self.SpecialData[self.SpecialRoundType] and true) or (nzConfig.RoundData[ num ] and nzConfig.RoundData[ num ].special)) or false
	end
	
	function nzRound:SetSpecialRoundType(id)
		if id == "None" then
			self.SpecialRoundType = nil -- "None" makes a nil key
		else
			self.SpecialRoundType = id or "Hellhounds" -- A nil id defaults to "Hellhounds", otherwise id
		end
	end
	
	function nzRound:GetSpecialRoundType(id)
		return self.SpecialRoundType
	end
	
	function nzRound:GetSpecialRoundData()
		if !self.SpecialRoundType then return nil end
		return self.SpecialData[self.SpecialRoundType]
	end

	util.AddNetworkString("nz_hellhoundround")
	function nzRound:CallHellhoundRound()
		net.Start("nz_hellhoundround")
			net.WriteBool(true)
		net.Broadcast()
	end
end

nzRound.PerkSelectData = nzRound.PerkSelectData or {}
function nzRound:AddMachineType(id, class)
	if SERVER then
		if class then
			local data = {}
			-- Which entity to spawn
			data.class = class
			nzRound.PerkSelectData[id] = data
		else
			nzRound.PerkSelectData[id] = nil -- Remove it if no valid class was added
		end
	else
		-- Clients only need it for the dropdown, no need to actually know the data and such
		nzRound.PerkSelectData[id] = class
	end
end

nzRound:AddMachineType(translate.Get("perk_machine_skin_original"), "nz_zombie_walker", {
}) 
nzRound:AddMachineType(translate.Get("perk_machine_skin_iw"), "nz_zombie_walker", {
}) 

nzRound.BoxSkinData = nzRound.BoxSkinData or {}
function nzRound:AddBoxType(id, class)
	if SERVER then
		if class then
			local data = {}
			-- Which entity to spawn
			data.class = class
			nzRound.BoxSkinData[id] = data
		else
			nzRound.BoxSkinData[id] = nil -- Remove it if no valid class was added
		end
	else
		-- Clients only need it for the dropdown, no need to actually know the data and such
		nzRound.BoxSkinData[id] = class
	end
end

nzRound:AddBoxType(translate.Get("weapon_box_skin_original"), "", {}) 
nzRound:AddBoxType(translate.Get("weapon_box_skin_mob_of_the_dead"), "", {}) 
nzRound:AddBoxType(translate.Get("weapon_box_skin_origins"), "", {}) 
nzRound:AddBoxType(translate.Get("weapon_box_skin_dead_space"), "", {}) 
nzRound:AddBoxType(translate.Get("weapon_box_skin_resident_evil"), "", {}) 

nzRound.HudSelectData = nzRound.HudSelectData or {}
function nzRound:AddHUDType(id, class)
	if SERVER then
		if class then
			local data = {}
			-- Which entity to spawn
			data.class = class
			nzRound.HudSelectData[id] = data
		else
			nzRound.HudSelectData[id] = nil -- Remove it if no valid class was added
		end
	else
		-- Clients only need it for the dropdown, no need to actually know the data and such
		nzRound.HudSelectData[id] = class
	end
end

nzRound:AddHUDType(translate.Get("hud_type_bo_three"), "nz_zombie_walker", {
}) 
nzRound:AddHUDType(translate.Get("hud_type_division_nine"), "nz_zombie_walker", {
}) 
nzRound:AddHUDType(translate.Get("hud_type_mob_of_the_dead"), "nz_zombie_walker", {
}) 
nzRound:AddHUDType(translate.Get("hud_type_fade"), "nz_zombie_walker", {
}) 
nzRound:AddHUDType(translate.Get("hud_type_shadows_of_evil"), "nz_zombie_walker", {
}) 
nzRound:AddHUDType(translate.Get("hud_type_bo_one"), "nz_zombie_walker", {
}) 
nzRound:AddHUDType(translate.Get("hud_type_buried"), "nz_zombie_walker", {
}) 
nzRound:AddHUDType(translate.Get("hud_type_origins_bo_two"), "nz_zombie_walker", {
}) 
nzRound:AddHUDType(translate.Get("hud_type_tranzit_bo_two"), "nz_zombie_walker", {
}) 
nzRound:AddHUDType(translate.Get("hud_type_nzombies_classic_hd"), "nz_zombie_walker", {
}) 
nzRound:AddHUDType(translate.Get("hud_type_covenant"), "nz_zombie_walker", {
}) 
nzRound:AddHUDType(translate.Get("hud_type_unsc"), "nz_zombie_walker", {
}) 
nzRound:AddHUDType(translate.Get("hud_type_dead_space"), "nz_zombie_walker", {
}) 
nzRound:AddHUDType(translate.Get("hud_type_devil_may_cry_dante"), "nz_zombie_walker", {
}) 
nzRound:AddHUDType(translate.Get("hud_type_devil_may_cry_nero"), "nz_zombie_walker", {
}) 
nzRound:AddHUDType(translate.Get("hud_type_devil_may_cry_v"), "nz_zombie_walker", {
}) 
nzRound:AddHUDType(translate.Get("hud_type_devil_may_cry_vergil"), "nz_zombie_walker", {
}) 
nzRound:AddHUDType(translate.Get("hud_type_gears_of_war"), "nz_zombie_walker", {
}) 
nzRound:AddHUDType(translate.Get("hud_type_killing_floor_two"), "nz_zombie_walker", {
}) 
nzRound:AddHUDType(translate.Get("hud_type_resident_evil"), "nz_zombie_walker", {
}) 
nzRound:AddHUDType(translate.Get("hud_type_simple_black"), "nz_zombie_walker", {
}) 
nzRound:AddHUDType(translate.Get("hud_type_simple_outline"), "nz_zombie_walker", {
}) 

function nzRound:GetHUDType(id)
	if id == translate.Get("hud_type_bo_three") then
	return "b03_hud.png"
	end
	if id == translate.Get("hud_type_division_nine") then
	return "D9.png"
	end
	if id == translate.Get("hud_type_mob_of_the_dead") then
	return "motd.png"
	end
	if id == translate.Get("hud_type_shadows_of_evil") then
	return "soe.png"
	end
	if id == translate.Get("hud_type_fade") then
	return "fade.png"
	end
	if id == translate.Get("hud_type_bo_one") then
	return "bo1.png"
	end
		if id == translate.Get("hud_type_buried") then
	return "buried_hud.png"
	end
		if id == translate.Get("hud_type_origins_bo_two") then
	return "origins_hud.png"
	end
		if id == translate.Get("hud_type_tranzit_bo_two") then
	return "tranzit_hud.png" 
	end
		if id == translate.Get("hud_type_nzombies_classic_hd") then
	return "HD_hud.png"
	end
	if id == translate.Get("hud_type_covenant") then
	return "covenant_hud.png"
	end
	if id == translate.Get("hud_type_unsc") then
	return "Halo_hud.png"
	end
	if id == translate.Get("hud_type_dead_space") then
	return "deadspace_hud.png"
	end
	if id == translate.Get("hud_type_devil_may_cry_dante") then
	return "DMC_Dante__hud.png"
	end
	if id == translate.Get("hud_type_devil_may_cry_nero") then
	return "DMC_Nero__hud.png"
	end
	if id == translate.Get("hud_type_devil_may_cry_v") then
	return "DMC_V__hud.png"
	end
	if id == translate.Get("hud_type_devil_may_cry_vergil") then
	return "DMC_Vergil__hud.png"
	end
	if id == translate.Get("hud_type_gears_of_war") then
	return "gears_hud.png"
	end
	if id == translate.Get("hud_type_killing_floor_two") then
	return "KF2__hud.png"
	end
	if id == translate.Get("hud_type_resident_evil") then
	return "RE_hud.png"
	end
	if id == translate.Get("hud_type_simple_black") then
	return "simple_hud.png"
	end
	if id == translate.Get("hud_type_simple_outline") then
	return "simple_hud2.png"
	end
	if id == nil then
	return "origins_hud.png"
	end
end


nzRound.ZombieSkinData = nzRound.ZombieSkinData or {}
function nzRound:AddZombieType(id, class)
	if SERVER then
		if class then
			local data = {}
			-- Which entity to spawn
			data.class = class
			nzRound.ZombieSkinData[id] = data
		else
			nzRound.ZombieSkinData[id] = nil -- Remove it if no valid class was added
		end
	else
		-- Clients only need it for the dropdown, no need to actually know the data and such
		nzRound.ZombieSkinData[id] = class
	end
end

nzRound:AddZombieType(translate.Get("zombie_type_kino_der_toten"), "nz_zombie_walker", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_ascension"), "nz_zombie_walker_ascension", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_call_of_the_dead"), "nz_zombie_walker_cotd", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_five"), "nz_zombie_walker_five", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_gorod_krovi"), "nz_zombie_walker_gorodkrovi", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_mod_of_the_dead"), "nz_zombie_walker_motd", {
})
nzRound:AddZombieType(translate.Get("zombie_type_shadows_of_evil"), "nz_zombie_walker_soemale", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_zetsubou_no_shima"), "nz_zombie_walker_zetsubou", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_origins"), "nz_zombie_walker_origins", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_world_war_one_soldiers"), "nz_zombie_walker_origins_soldier", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_crusader_zombies"), "nz_zombie_walker_origins_templar", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_moon"), "nz_zombie_walker_moon", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_area_guard"), "nz_zombie_walker_moon_guard", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_moon_tech"), "nz_zombie_walker_moon_tech", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_der_eisendrache"), "nz_zombie_walker_eisendrache", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_buried"), "nz_zombie_walker_buried", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_shangrila"), "nz_zombie_walker_shangrila", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_shi_no_numa"), "nz_zombie_walker_sumpf", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_tranzit"), "nz_zombie_walker_greenrun", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_nuketown"), "nz_zombie_walker_nuketown", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_zombies_in_spaceland"), "nz_zombie_walker_clown", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_deathtrooper"), "nz_zombie_walker_deathtrooper", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_skeleton"), "nz_zombie_walker_skeleton", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_xenomorph"), "nz_zombie_walker_xeno", {
}) 
nzRound:AddZombieType(translate.Get("zombie_type_necromorph"), "nz_zombie_walker_necromorph", {
}) 

function nzRound:GetZombieType(id)
	if id == translate.Get("zombie_type_skeleton") then
	return "nz_zombie_walker_skeleton"
	end
		if id == translate.Get("zombie_type_deathtrooper") then
	return "nz_zombie_walker_deathtrooper"
	end
		if id == "Zombies in Spaceland" then
	return "nz_zombie_walker_clown"
	end
		if id == translate.Get("zombie_type_tranzit") then
	return "nz_zombie_walker_greenrun" 
	end
		if id == translate.Get("zombie_type_mod_of_the_dead") then
	return "nz_zombie_walker_motd" 
	end
		if id == translate.Get("zombie_type_nuketown") then
	return "nz_zombie_walker_nuketown"
	end
	if id == translate.Get("zombie_type_ascension") then
	return "nz_zombie_walker_ascension"
	end
	if id == translate.Get("zombie_type_call_of_the_dead") then
	return "nz_zombie_walker_cotd"
	end
	if id == translate.Get("zombie_type_five") then
	return "nz_zombie_walker_five"
	end
	if id == translate.Get("zombie_type_gorod_krovi") then
	return "nz_zombie_walker_gorodkrovi"
	end
	if id == translate.Get("zombie_type_shadows_of_evil") then
	return "nz_zombie_walker_soemale"
	end
	if id == translate.Get("zombie_type_zetsubou_no_shima") then
	return "nz_zombie_walker_zetsubou"
	end
	if id == translate.Get("zombie_type_xenomorph") then
	return "nz_zombie_walker_xeno"
	end
	if id == translate.Get("zombie_type_necromorph") then
	return "nz_zombie_walker_necromorph"
	end
	if id == translate.Get("zombie_type_kino_der_toten") then
	return "nz_zombie_walker"
	end
	if id == translate.Get("zombie_type_origins") then
	return "nz_zombie_walker_origins"
	end
	if id == translate.Get("zombie_type_world_war_one_soldiers") then
	return "nz_zombie_walker_origins_soldier"
	end
	if id == translate.Get("zombie_type_origins") then
	return "nz_zombie_walker_origins"
	end
	if id == translate.Get("zombie_type_crusader_zombies") then
	return "nz_zombie_walker_origins_templar"
	end
	if id == translate.Get("zombie_type_moon") then
	return "nz_zombie_walker_moon"
	end
	if id == translate.Get("zombie_type_moon_tech") then
	return "nz_zombie_walker_moon_guard"
	end
	if id == translate.Get("zombie_type_area_guard") then
	return "nz_zombie_walker_moon_guard"
	end
	if id == translate.Get("zombie_type_buried") then
	return "nz_zombie_walker_buried"
	end
	if id == translate.Get("zombie_type_der_eisendrache") then
	return "nz_zombie_walker_eisendrache"
	end
	if id == translate.Get("zombie_type_shangrila") then
	return "nz_zombie_walker_shangrila"
	end
	if id == translate.Get("zombie_type_shi_no_numa") then
	return "nz_zombie_walker_sumpf"
	end
	if id == nil then
	return "nz_zombie_walker"
	end
end

nzRound.SpecialData = nzRound.SpecialData or {}
function nzRound:AddSpecialRoundType(id, data, spawnfunc, roundfunc, endfunc)
	if SERVER then
		nzRound.SpecialData[id] = {}
		-- Zombie data, like those in the configuration files
		nzRound.SpecialData[id].data = data
		-- Optional spawn function, runs when a zombie spawns (can be used to set health, speed, etc)
		if spawnfunc then nzRound.SpecialData[id].spawnfunc = spawnfunc end
		-- Optional round function, runs when the round starts (can be used to set amount, sounds, fog, etc)
		if roundfunc then nzRound.SpecialData[id].roundfunc = roundfunc end
		-- Optional end function, runs when the special round ends (can be used to clean up changes)
		if endfunc then nzRound.SpecialData[id].endfunc = endfunc end
	else
		-- Clients only need it for the dropdown, no need to actually know the data and such
		nzRound.SpecialData[id] = (data and true or nil)
	end
end

nzRound:AddSpecialRoundType(translate.Get("special_round_hellhounds"), {
	specialTypes = {
		["nz_zombie_special_dog"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return nzRound:GetNumber() * #player.GetAllPlaying() end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
	local hp = 55
	for i=1,nzRound:GetNumber() do 
	hp = hp* 1.13
								end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType(translate.Get("special_round_keepers"), {
	specialTypes = {
		["nz_zombie_special_keeper"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return nzRound:GetNumber() * #player.GetAllPlaying() end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
	local hp = 50
	for i=1,nzRound:GetNumber() do 
	hp = hp* 1.05
								end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType(translate.Get("special_round_nova_crawlers"), {
	specialTypes = {
		["nz_zombie_special_nova"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return nzRound:GetNumber() * #player.GetAllPlaying() end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
	local hp = 40
	for i=1,nzRound:GetNumber() do 
	hp = hp* 1.1
								end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType(translate.Get("special_round_lickers"), {
	specialTypes = {
		["nz_zombie_special_licker"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return nzRound:GetNumber() * #player.GetAllPlaying() end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
	local hp = 54
	for i=1,nzRound:GetNumber() do 
	hp = hp* 1.17
								end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType(translate.Get("special_round_raptors"), {
	specialTypes = {
		["nz_zombie_special_raptor"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return nzRound:GetNumber() * #player.GetAllPlaying() end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
	local hp = 70
	for i=1,nzRound:GetNumber() do 
	hp = hp* 1.05
								end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType(translate.Get("special_round_facehuggers"), {
	specialTypes = {
		["nz_zombie_special_facehugger"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return nzRound:GetNumber() * #player.GetAllPlaying() end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(50)
	else
	local hp = 32
	for i=1,nzRound:GetNumber() do 
	hp = hp* 1.1
								end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType(translate.Get("special_round_the_pack"), {
	specialTypes = {
		["nz_zombie_special_pack"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return nzRound:GetNumber() * #player.GetAllPlaying() end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
	local hp = 50
	for i=1,nzRound:GetNumber() do 
	hp = hp* 1.1
								end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType(translate.Get("special_round_spiders"), {
	specialTypes = {
		["nz_zombie_special_spooder"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return nzRound:GetNumber() * #player.GetAllPlaying() end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
	local hp = 48
	for i=1,nzRound:GetNumber() do 
	hp = hp* 1.1
								end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType(translate.Get("special_round_burning_zombies"), {
	normalTypes = {
		["nz_zombie_special_burning"] = {chance = 100}
	},
	normalDelay = 0.75,
	normalCountMod = function(original) return original * 0.5 end, -- Half the normal count here
}) -- No special functions or anything really

nzRound.AdditionalZombieData = nzRound.AdditionalZombieData or {}
function nzRound:AddAdditionalZombieType(id, class)
	if SERVER then
		if class then
			local data = {}
			-- Which entity to spawn
			data.class = class
			nzRound.AdditionalZombieData[id] = data
		else
			nzRound.AdditionalZombieData[id] = nil -- Remove it if no valid class was added
		end
	else
		-- Clients only need it for the dropdown, no need to actually know the data and such
		nzRound.AdditionalZombieData[id] = class
	end
end

nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_nazi_zombies"), "nz_zombie_walker", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_ascension_zombies"), "nz_zombie_walker_ascension", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_siberian_zombies"), "nz_zombie_walker_cotd", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_pentagon_zombies"), "nz_zombie_walker_five", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_gorod_krovi_zombies"), "nz_zombie_walker_gorodkrovi", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_mob_of_the_dead_zombies"), "nz_zombie_walker_motd", {
})
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_shadows_of_evil_zombies"), "nz_zombie_walker_soemale", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_zetsubou_no_shima_zombies"), "nz_zombie_walker_zetsubou", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_origins_zombies"), "nz_zombie_walker_origins", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_world_war_one_soldiers"), "nz_zombie_walker_origins_soldier", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_crusader_zombies"), "nz_zombie_walker_origins_templar", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_moon_zombies"), "nz_zombie_walker_moon", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_moon_tech_zombies"), "nz_zombie_walker_moon_tech", {
})
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_area_fiftyone_guard_zombies"), "nz_zombie_walker_moon_guard", {
})
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_der_eisendrache_zombies"), "nz_zombie_walker_eisendrache", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_western_zombies"), "nz_zombie_walker_buried", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_vietnamese_zombies"), "nz_zombie_walker_shangrila", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_shi_no_numa_zombies"), "nz_zombie_walker_sumpf", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_tranzit_zombies"), "nz_zombie_walker_greenrun", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_nuketown_zombies"), "nz_zombie_walker_nuketown", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_clowns"), "nz_zombie_walker_clown", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_deathtroopers"), "nz_zombie_walker_deathtrooper", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_skeletons"), "nz_zombie_walker_skeleton", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_xenomorphs"), "nz_zombie_walker_xeno", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_necromorphs"), "nz_zombie_walker_necromorph", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("extra_zombie_type_burning_zombie"), "nz_zombie_special_burning", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("special_round_spiders"), "nz_zombie_special_spooder", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("special_round_the_pack"), "nz_zombie_special_pack", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("special_round_facehuggers"), "nz_zombie_special_facehugger", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("special_round_raptors"), "nz_zombie_special_raptor", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("special_round_lickers"), "nz_zombie_special_licker", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("special_round_nova_crawlers"), "nz_zombie_special_nova", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("special_round_keepers"), "nz_zombie_special_keeper", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("special_round_hellhounds"), "nz_zombie_special_dog", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("boss_round_panzer"), "nz_zombie_boss_panzer", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("boss_round_dilophosaurus"), "nz_zombie_boss_dilophosaurus", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("boss_round_brute"), "nz_zombie_boss_brute", {
})
nzRound:AddAdditionalZombieType(translate.Get("boss_round_brutus"), "nz_zombie_boss_brutus", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("boss_round_divider"), "nz_zombie_boss_Divider", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("boss_round_william_birkin"), "nz_zombie_boss_G1", {
}) 
nzRound:AddAdditionalZombieType(translate.Get("boss_round_the_mangler"), "nz_zombie_boss_mangler", {
})
nzRound:AddAdditionalZombieType(translate.Get("boss_round_the_margwa"), "nz_zombie_boss_margwa", {
})
nzRound:AddAdditionalZombieType(translate.Get("boss_round_napalm_zombie"), "nz_zombie_boss_napalm", {
})
nzRound:AddAdditionalZombieType(translate.Get("boss_round_shrieker_zombie"), "nz_zombie_boss_shrieker", {
})
nzRound:AddAdditionalZombieType(translate.Get("boss_round_nemesis"), "nz_zombie_boss_nemesis", {
})
nzRound:AddAdditionalZombieType(translate.Get("boss_round_thrasher"), "nz_zombie_boss_thrasher", {
})    
function nzRound:GetSpecialType(id)
	if id == translate.Get("extra_zombie_type_burning_zombie") then
	return "nz_zombie_special_burning"
	end
		if id == translate.Get("special_round_spiders") then
	return "nz_zombie_special_spooder"
	end
		if id == translate.Get("special_round_the_pack") then
	return "nz_zombie_special_pack"
	end
		if id == translate.Get("special_round_facehuggers") then
	return "nz_zombie_special_facehugger" 
	end
		if id == translate.Get("special_round_raptors") then
	return "nz_zombie_special_raptor" 
	end
		if id == translate.Get("special_round_lickers") then
	return "nz_zombie_special_licker"
	end
	if id == translate.Get("special_round_nova_crawlers") then
	return "nz_zombie_special_nova"
	end
	if id == translate.Get("special_round_keepers") then
	return "nz_zombie_special_keeper"
	end
	if id == translate.Get("special_round_hellhounds") then
	return "nz_zombie_special_dog"
	end
	if id == translate.Get("boss_round_panzer") then
	return "nz_zombie_boss_panzer"
	end
	if id == translate.Get("boss_round_dilophosaurus") then
	return "nz_zombie_boss_dilophosaurus"
	end
	if id == translate.Get("boss_round_brute") then
	return "nz_zombie_boss_brute"
	end
	if id == translate.Get("boss_round_brutus") then
	return "nz_zombie_boss_brutus"
	end
	if id == translate.Get("boss_round_divider") then
	return "nz_zombie_boss_Divider"
	end
	if id == translate.Get("boss_round_william_birkin") then
	return "nz_zombie_boss_G1"
	end
	if id == translate.Get("boss_round_the_mangler") then
	return "nz_zombie_boss_mangler"
	end
	if id == translate.Get("boss_round_the_margwa") then
	return "nz_zombie_boss_margwa"
	end
	if id == translate.Get("boss_round_napalm_zombie") then
	return "nz_zombie_boss_Napalm"
	end
	if id == translate.Get("boss_round_nemesis") then
	return "nz_zombie_boss_Nemesis"
	end
	if id == translate.Get("boss_round_george_romero") then
	return "nz_zombie_boss_romero"
	end
	if id == translate.Get("boss_round_shrieker_zombie") then
	return "nz_zombie_boss_shrieker"
	end
	if id == translate.Get("boss_round_thrasher") then
	return "nz_zombie_boss_thrasher"
	end
	if id == translate.Get("extra_zombie_type_skeletons") then
	return "nz_zombie_walker_skeleton"
	end
		if id == translate.Get("extra_zombie_type_deathtroopers") then
	return "nz_zombie_walker_deathtrooper"
	end
		if id == translate.Get("extra_zombie_type_clowns") then
	return "nz_zombie_walker_clown"
	end
		if id == translate.Get("extra_zombie_type_tranzit_zombies") then
	return "nz_zombie_walker_greenrun" 
	end
		if id == translate.Get("extra_zombie_type_mob_of_the_dead_zombies") then
	return "nz_zombie_walker_motd" 
	end
		if id == translate.Get("extra_zombie_type_nuketown_zombies") then
	return "nz_zombie_walker_nuketown"
	end
	if id == translate.Get("extra_zombie_type_ascension_zombies") then
	return "nz_zombie_walker_ascension"
	end
	if id == translate.Get("extra_zombie_type_siberian_zombies") then
	return "nz_zombie_walker_cotd"
	end
	if id == translate.Get("extra_zombie_type_pentagon_zombies") then
	return "nz_zombie_walker_five"
	end
	if id == translate.Get("extra_zombie_type_gorod_krovi_zombies") then
	return "nz_zombie_walker_gorodkrovi"
	end
	if id == translate.Get("extra_zombie_type_shadows_of_evil_zombies") then
	return "nz_zombie_walker_soemale"
	end
	if id == translate.Get("extra_zombie_type_zetsubou_no_shima_zombies") then
	return "nz_zombie_walker_zetsubou"
	end
	if id == translate.Get("extra_zombie_type_xenomorphs") then
	return "nz_zombie_walker_xeno"
	end
	if id == translate.Get("extra_zombie_type_necromorphs") then
	return "nz_zombie_walker_necromorph"
	end
	if id == translate.Get("extra_zombie_type_nazi_zombies") then
	return "nz_zombie_walker"
	end
	if id == translate.Get("extra_zombie_type_origins_zombies") then
	return "nz_zombie_walker_origins"
	end
	if id == translate.Get("extra_zombie_type_world_war_one_soldiers") then
	return "nz_zombie_walker_origins_soldier"
	end
	if id == translate.Get("extra_zombie_type_crusader_zombies") then
	return "nz_zombie_walker_origins_templar"
	end
	if id == translate.Get("extra_zombie_type_moon_zombies") then
	return "nz_zombie_walker_moon"
	end
	if id == translate.Get("extra_zombie_type_moon_tech_zombies") then
	return "nz_zombie_walker_moon_tech"
	end
	if id == translate.Get("extra_zombie_type_area_fiftyone_guard_zombies") then
	return "nz_zombie_walker_moon_guard"
	end
	if id == translate.Get("extra_zombie_type_western_zombies") then
	return "nz_zombie_walker_buried"
	end
	if id == translate.Get("extra_zombie_type_der_eisendrache_zombies") then
	return "nz_zombie_walker_eisendrache"
	end
	if id == translate.Get("extra_zombie_type_vietnamese_zombies") then
	return "nz_zombie_walker_shangrila"
	end
	if id == translate.Get("extra_zombie_type_shi_no_numa_zombies") then
	return "nz_zombie_walker_sumpf"
	end
	if id == nil then
	return "nz_zombie_special_dog"
	end
end