
function nzPerks:NewPerk(id, data)
	if SERVER then 
		//Sanitise any client data.
	else
		data.Func = nil
	end
	nzPerks.Data[id] = data
end

function nzPerks:Get(id)
	return nzPerks.Data[id]
end

function nzPerks:GetByName(name)
	for _, perk in pairs(nzPerks.Data) do
		if perk.name == name then
			return perk
		end
	end

	return nil
end

function nzPerks:GetList()
	local tbl = {}

	for k,v in pairs(nzPerks.Data) do
		tbl[k] = v.name
	end

	return tbl
end

function nzPerks:GetIcons()
	local tbl = {}
	
	for k,v in pairs(nzPerks.Data) do
		tbl[k] = v.icon
	end
	
	return tbl
end

function nzPerks:GetBottleMaterials()
	local tbl = {}
	
	for k,v in pairs(nzPerks.Data) do
		tbl[k] = v.material
	end
	
	return tbl
end

function nzPerks:GetMachineType(id)
	if id == translate.Get("perk_machine_skin_original") then
	return "OG"
	end
	if id == translate.Get("perk_machine_skin_iw") then
	return "IW"
	end
	if id == nil then
	return "OG"
	end
end

nzPerks:NewPerk("jugg", {
	name = "perk_juggernog",
	name_skin = "perk_tuff_nuff",
	model = "models/yolojoenshit/bo3perks/juggernog/mc_mtl_p7_zm_vending_jugg.mdl",
	skin = "models/IWperks/tuff/mc_mtl_p7_zm_vending_jugg.mdl",
	off_skin = 1,
	on_skin = 0,
	price = 2500,
	price_skin = 2500,
	material = "models/perk_bottle/c_perk_bottle_jugg",
	icon = Material("perk_icons/chron/jugg.png", "smooth unlitgeneric"),
	icon_skin = Material("perk_icons/chron/tuff.png", "smooth unlitgeneric"),
	color = Color(255, 100, 100),
	func = function(self, ply, machine)
			ply:SetMaxHealth(250)
			ply:SetHealth(250)
	end,
	lostfunc = function(self, ply)
		ply:SetMaxHealth(100)
		if ply:Health() > 100 then ply:SetHealth(100) end
	end,
})

nzPerks:NewPerk("dtap", {
	name = "perk_double_tap",
	name_skin = "perk_bang_bangs",
	model = "models/alig96/perks/doubletap/doubletap_on.mdl",
	model_off = "models/alig96/perks/doubletap/doubletap_off.mdl",
	skin = "models/IWperks/bang/mc_mtl_p7_zm_vending_doubletap2.mdl",
	off_skin = 1,
	on_skin = 0,
	price = 2000,
	price_skin = 2000,
	material = "models/perk_bottle/c_perk_bottle_dtap",
	icon = Material("perk_icons/chron/dtap.png", "smooth unlitgeneric"),
	icon_skin = Material("perk_icons/chron/bangs.png", "smooth unlitgeneric"),
	color = Color(255, 255, 100),
	func = function(self, ply, machine)
		local tbl = {}
		for k,v in pairs(ply:GetWeapons()) do
			if v:IsFAS2() then
				table.insert(tbl, v)
			end
		end
		if tbl[1] != nil then
			for k,v in pairs(tbl) do
				v:ApplyNZModifier("dtap")
			end
		end
	end,
	lostfunc = function(self, ply)
			local tbl = {}
			for k,v in pairs(ply:GetWeapons()) do
				if v:IsFAS2() then
					table.insert(tbl, v)
				end
			end
			if tbl[1] != nil then
				for k,v in pairs(tbl) do
					v:RevertNZModifier("dtap")
				end
			end
	end,
})

nzPerks:NewPerk("revive", {
	name = "perk_quick_revive",
	name_skin = "perk_up_n_atoms",
	model = "models/yolojoenshit/bo3perks/revivesoda/mc_mtl_p7_zm_vending_revive.mdl",
	skin = "models/IWperks/atoms/mc_mtl_p7_zm_vending_revive.mdl",
	off_skin = 1,
	on_skin = 0,
	price = 1500,
	price_skin = 1500,
	material = "models/perk_bottle/c_perk_bottle_revive",
	icon = Material("perk_icons/chron/revive.png", "smooth unlitgeneric"),
	icon_skin = Material("perk_icons/chron/atoms.png", "smooth unlitgeneric"),
	color = Color(100, 100, 255),
	func = function(self, ply, machine)
			if #player.GetAllPlaying() <= 1 then
				if !ply.SoloRevive or ply.SoloRevive < 3 or !IsValid(machine) then
					ply:ChatPrint(translate.Get("perk_revive_solo"))
				else
					ply:ChatPrint(translate.Get("perk_revive_solo2"))
					return false
				end
			end
	end,
	lostfunc = function(self, ply)

	end,
})

nzPerks:NewPerk("speed", {
	name = "perk_speed_cola",
	name_skin = "perk_quickies",
	model = "models/yolojoenshit/bo3perks/speedcola/mc_mtl_p7_zm_vending_speedcola.mdl",
	skin = "models/IWperks/quickies/mc_mtl_p7_zm_vending_speedcola.mdl",
	off_skin = 1,
	on_skin = 0,
	price = 3000,
	price_skin = 3000,
	material = "models/perk_bottle/c_perk_bottle_speed",
	icon = Material("perk_icons/chron/speed.png", "smooth unlitgeneric"),
	icon_skin = Material("perk_icons/chron/quickies.png", "smooth unlitgeneric"),
	color = Color(100, 255, 100),
	func = function(self, ply, machine)
		local tbl = {}
		for k,v in pairs(ply:GetWeapons()) do
			if v:NZPerkSpecialTreatment() then
				table.insert(tbl, v)
			end
		end
		if tbl[1] != nil then
			--local str = ""
			for k,v in pairs(tbl) do
				v:ApplyNZModifier("speed")
				--str = str .. v.ClassName .. ", "
			end
		end
	end,
	lostfunc = function(self, ply)
		local tbl = {}
		for k,v in pairs(ply:GetWeapons()) do
			if v:NZPerkSpecialTreatment() then
				table.insert(tbl, v)
			end
		end
		if tbl[1] != nil then
			for k,v in pairs(tbl) do
				v:RevertNZModifier("speed")
			end
		end
	end,
})

nzPerks:NewPerk("pap", {
	name = "perk_packapunch",
	name_skin = "perk_packapunch2",
	model = "models/yolojoenshit/extras/packapunch/mc_mtl_p7_packapunch.mdl",
	off_skin = 1,
	on_skin = 0,
	price = 0,
	price_skin = 0,
	specialmachine = true, -- Prevents players from getting the perk when they buy it
	nobuy = true, -- A "Buy" event won't run when this is used (we do that ourselves in its function)
	-- We don't use materials
	icon = Material("vulture_icons/pap.png", "smooth unlitgeneric"),
	icon_skin = Material("vulture_icons/pap.png", "smooth unlitgeneric"),
	color = Color(200, 220, 220),
	condition = function(self, ply, machine)
		local wep = ply:GetActiveWeapon()
		if (!wep:HasNZModifier("pap") or wep:CanRerollPaP()) and !machine:GetBeingUsed() then
			local reroll = false
			if wep:HasNZModifier("pap") and wep:CanRerollPaP() then
				reroll = true
			end
			local cost = reroll and 2000 or 5000
			return ply:GetPoints() >= cost
		else
			ply:PrintTranslatedMessage( HUD_PRINTTALK, "text_weapon_packapunched")
			
			return false
		end
	end,
	func = function(self, ply, machine)
		local wep = ply:GetActiveWeapon()
	
		local reroll = false
		if wep:HasNZModifier("pap") and wep:CanRerollPaP() then
			reroll = true
		end
		local cost = reroll and 2000 or 5000

		ply:Buy(cost, machine, function()
			hook.Call("OnPlayerBuyPackAPunch", nil, ply, wep, machine)
		
			ply:Give("nz_packapunch_arms")

			machine:SetBeingUsed(true)
			machine:EmitSound("nz/machines/pap_up.wav")
			local class = wep:GetClass()
			
			local e = EffectData()
			e:SetEntity(machine)
			local ang = machine:GetAngles()
			e:SetOrigin(machine:GetPos() + ang:Up()*35 + ang:Forward()*20 - ang:Right()*2)
			e:SetMagnitude(3)
			util.Effect("pap_glow", e, true, true)

			wep:Remove()
			local wep = ents.Create("pap_weapon_fly")
			local startpos = machine:GetPos() + ang:Forward()*30 + ang:Up()*25 + ang:Right()*-3
			wep:SetPos(startpos)
			wep:SetAngles(ang + Angle(0,90,0))
			wep.WepClass = class
			wep:Spawn()
			local weapon = weapons.Get(class)
			local model = (weapon and weapon.WM or weapon.WorldModel) or "models/weapons/w_rif_ak47.mdl"
			if !util.IsValidModel(model) then model = "models/weapons/w_rif_ak47.mdl" end
			wep:SetModel(model)
			wep.machine = machine
			wep.Owner = ply
			wep:SetMoveType( MOVETYPE_FLY )

			--wep:SetNotSolid(true)
			--wep:SetGravity(0.000001)
			--wep:SetCollisionBounds(Vector(0,0,0), Vector(0,0,0))
			timer.Simple(0.5, function()
				if IsValid(wep) then
					wep:SetLocalVelocity(ang:Forward()*-30)
				end
			end)
			timer.Simple(1.8, function()
				if IsValid(wep) then
					wep:SetMoveType(MOVETYPE_NONE)
					wep:SetLocalVelocity(Vector(0,0,0))
				end
			end)
			timer.Simple(3, function()
				if IsValid(wep) and IsValid(machine) then
					local weapon = weapons.Get(class)
					if weapon and weapon.NZPaPReplacement and weapons.Get(weapon.NZPaPReplacement) then
						local pos, ang = wep:GetPos(), wep:GetAngles()
						wep:Remove()
						wep = ents.Create("pap_weapon_fly") -- Recreate a new entity with the replacement class instead
						wep:SetPos(pos)
						wep:SetAngles(ang)
						wep.WepClass = weapon.NZPaPReplacement
						wep:Spawn()
						wep.TriggerPos = startpos
						
						local replacewep = weapons.Get(weapon.NZPaPReplacement)
						local model = (replacewep and replacewep.WM or replacewep.WorldModel) or "models/weapons/w_rif_ak47.mdl"
						if !util.IsValidModel(model) then model = "models/weapons/w_rif_ak47.mdl" end
						wep:SetModel(model) -- Changing the model and name
						wep.machine = machine
						wep.Owner = ply
						wep:SetMoveType( MOVETYPE_FLY )
					end
					
					--print(wep, wep.WepClass, wep:GetModel())
				
					machine:EmitSound("nz/machines/pap_ready.wav")
					wep:SetCollisionBounds(Vector(0,0,0), Vector(0,0,0))
					wep:SetMoveType(MOVETYPE_FLY)
					wep:SetGravity(0.000001)
					wep:SetLocalVelocity(ang:Forward()*30)
					--print(ang:Forward()*30, wep:GetVelocity())
					wep:CreateTriggerZone(reroll)
					--print(reroll)
				end
			end)
			timer.Simple(4.2, function()
				if IsValid(wep) then
					--print("YDA")
					--print(wep:GetMoveType())
					--print(ang:Forward()*30, wep:GetVelocity())
					wep:SetMoveType(MOVETYPE_NONE)
					wep:SetLocalVelocity(Vector(0,0,0))
				end
			end)
			timer.Simple(10, function()
				if IsValid(wep) then
					wep:SetMoveType(MOVETYPE_FLY)
					wep:SetLocalVelocity(ang:Forward()*-2)
				end
			end)
			timer.Simple(25, function()
				if IsValid(wep) then
					wep:Remove()
					if IsValid(machine) then
						machine:SetBeingUsed(false)
					end
				end
			end)

			timer.Simple(2, function() ply:RemovePerk("pap") end)
			return true
		end)
	end,
	lostfunc = function(self, ply)

	end,
})

nzPerks:NewPerk("dtap2", {
	name = "perk_vigor_rush",
	name_skin = "perk_bang_bangs_triple_damage",
	model = "models/nzr/vigor.mdl",
	skin = "models/IWperks/bang/mc_mtl_p7_zm_vending_doubletap2.mdl",
	off_skin = 1,
	on_skin = 0,
	price = 2500,
	price_skin = 2000,
	material = "models/perk_bottle/c_perk_bottle_vigor",
	icon = Material("perk_icons/chron/dtap2.png", "smooth unlitgeneric"),
	icon_skin = Material("perk_icons/chron/bangs2.png", "smooth unlitgeneric"),
	color = Color(128, 128, 64),
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
})

nzPerks:NewPerk("fire", {
	name = "perk_napalm_nectar",
	name_skin = "perk_firestarter_fizzy",
	model = "models/nzr/firestarter/firestarter.mdl",
	model_off = "models/nzr/firestarter/firestarter_off.mdl",
	price = 2000,
	price_skin = 2000,
	material = "models/perk_bottle/c_perk_bottle_fire",
	icon = Material("perk_icons/chron/fire.png", "smooth unlitgeneric"),
	icon_skin = Material("perk_icons/chron/fire.png", "smooth unlitgeneric"),
	color = Color(222, 69, 2),
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
})

nzPerks:NewPerk("staminup", {
	name = "perk_staminup",
	name_skin = "perk_racin_stripes",
	model = "models/yolojoenshit/bo3perks/staminup/mc_mtl_p7_zm_vending_marathon.mdl",
	skin = "models/IWperks/stripes/mc_mtl_p7_zm_vending_marathon.mdl",
	off_skin = 1,
	on_skin = 0,
	price = 2000,
	price_skin = 2000,
	material = "models/perk_bottle/c_perk_bottle_stamin",
	icon = Material("perk_icons/chron/staminup.png", "smooth unlitgeneric"),
	icon_skin = Material("perk_icons/chron/stripes.png", "smooth unlitgeneric"),
	color = Color(200, 255, 100),
	func = function(self, ply, machine)
		ply:SetRunSpeed(321)
		ply:SetMaxRunSpeed( 321 )
		ply:SetStamina( 200 )
		ply:SetMaxStamina( 200 )
	end,
	lostfunc = function(self, ply)
		ply:SetRunSpeed(300)
		ply:SetMaxRunSpeed( 300 )
		ply:SetStamina( 100 )
		ply:SetMaxStamina( 100 )
	end,
})

nzPerks:NewPerk("politan", {
	name = "perk_randomopolitian",
	name_skin = "perk_randomopolitian2",
	model = "models/alig96/perks/random/random_on.mdl",
	model_off = "models/alig96/perks/random/random_off.mdl",
	price = 5000,
	price_skin = 5000,
	material = "models/perk_bottle/c_perk_bottle_random",
	icon = Material("perk_icons/chron/random.png", "smooth unlitgeneric"),
	icon_skin = Material("perk_icons/chron/random.png", "smooth unlitgeneric"),
	color = Color(255, 172, 224),
	func = function(self, ply, machine)
		local tbl = {}
		for k,v in pairs(ply:GetWeapons()) do
				table.insert(tbl, v)
		end
			for k,v in pairs(tbl) do
			if !v:IsSpecial() then
				v:ApplyNZModifier("rando")
				end
			end
	end,
	lostfunc = function(self, ply)
			local tbl = {}
			for k,v in pairs(ply:GetWeapons()) do
				if v:HasNZModifier("rando") then
					v:RevertNZModifier("rando")
			end
			end
		
	end,
})

nzPerks:NewPerk("sake", {
	name = "perk_slashers_sake",
	name_skin = "perk_slappy_taffy",
	skin = "models/IWperks/taffy/sake.mdl",
	model = "models/alig96/perks/sake/sake.mdl",
	off_skin = 1,
	on_skin = 0,
	price = 6000,
	price_skin = 6000,
	material = "models/perk_bottle/c_perk_bottle_sake",
	icon = Material("perk_icons/chron/sake.png", "smooth unlitgeneric"),
	icon_skin = Material("perk_icons/chron/taffy.png", "smooth unlitgeneric"),
	color = Color(185, 214, 0),
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	ply:StripWeapon( "nz_yamato" )
	ply:Give("nz_quickknife_crowbar")
	end,
})



nzPerks:NewPerk("wall", {
	name = "perk_wall_power_whiskey_sour",
	name_skin = "perk_wall_power_whiskey_sour2",
	model_off = "models/alig96/perks/wall/wall_off.mdl",
	model = "models/alig96/perks/wall/wall.mdl",
	price = 8000,
	price_skin = 8000,
	material = "models/perk_bottle/c_perk_bottle_wall",
	icon = Material("perk_icons/chron/wall.png", "smooth unlitgeneric"),
	icon_skin = Material("perk_icons/chron/wall.png", "smooth unlitgeneric"),
	color = Color(230, 104, 167),
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
})

nzPerks:NewPerk("danger", {
	name = "perk_danger_costarican",
	name_skin = "perk_danger_costarican2",
	model_off = "models/alig96/perks/danger/danger_off.mdl",
	model = "models/alig96/perks/danger/danger_on.mdl",
	price = 2000,
	price_skin = 2000,
	material = "models/perk_bottle/c_perk_bottle_danger",
	icon = Material("perk_icons/chron/danger.png", "smooth unlitgeneric"),
	icon_skin = Material("perk_icons/chron/danger.png", "smooth unlitgeneric"),
	color = Color(232, 116, 116),
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
})

nzPerks:NewPerk("everclear", {
	name = "perk_explosive_everclear",
	name_skin = "perk_trail_blazers",
	skin = "models/IWperks/trailblazer/everclear.mdl",
	off_skin = 1,
	on_skin = 0,
	model_off = "models/alig96/perks/everclear/everclear.mdl",
	model = "models/alig96/perks/everclear/everclear.mdl",
	price = 3000,
	price_skin = 3000,
	material = "models/perk_bottle/c_perk_bottle_everclear",
	icon = Material("perk_icons/chron/everclear.png", "smooth unlitgeneric"),
	icon_skin = Material("perk_icons/chron/blazers.png", "smooth unlitgeneric"),
	color = Color(222, 222, 222),
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
})

nzPerks:NewPerk("gin", {
	name = "perk_juicers_gin",
	name_skin = "perk_juicers_gin2",
	model_off = "models/alig96/perks/gin/gin.mdl",
	model = "models/alig96/perks/gin/gin.mdl",
	price = 2000,
	price_skin = 2000,
	material = "models/perk_bottle/c_perk_bottle_gin",
	icon = Material("perk_icons/chron/gin.png", "smooth unlitgeneric"),
	icon_skin = Material("perk_icons/chron/gin.png", "smooth unlitgeneric"),
	color = Color(75, 158, 188),
	func = function(self, ply, machine)
	if #player.GetAllPlaying() <= 1 then
	local perks =   GetConVar("nz_difficulty_perks_max"):GetInt()
	GetConVar("nz_difficulty_perks_max"):SetInt(perks+3)
	else
	local perks =   GetConVar("nz_difficulty_perks_max"):GetInt()
	GetConVar("nz_difficulty_perks_max"):SetInt(perks+1)
	end
	end,
	lostfunc = function(self, ply)
		if #player.GetAllPlaying() <= 1 then
	local perks =   GetConVar("nz_difficulty_perks_max"):GetInt()
	GetConVar("nz_difficulty_perks_max"):SetInt(perks-3)
	else
	local perks =   GetConVar("nz_difficulty_perks_max"):GetInt()
	GetConVar("nz_difficulty_perks_max"):SetInt(perks-1)
	end
	end,
})

nzPerks:NewPerk("phd", {
	name = "perk_phd_flopper",
	name_skin = "perk_bombstoppers",
	skin = "models/IWperks/bomb/phdflopper.mdl", 
	off_skin = 1,
	on_skin = 0,
	model_off = "models/alig96/perks/phd/phdflopper_off.mdl",
	model = "models/alig96/perks/phd/phdflopper.mdl",
	price = 2000,
	price_skin = 2000,
	material = "models/perk_bottle/c_perk_bottle_phd",
	icon = Material("perk_icons/chron/phd.png", "smooth unlitgeneric"),
	icon_skin = Material("perk_icons/chron/bomb.png", "smooth unlitgeneric"),
	color = Color(255, 50, 255),
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
})

nzPerks:NewPerk("deadshot", {
	name = "perk_deadshot_daiquiri",
	name_skin = "perk_deadshot_dewdrops",
	model = "models/yolojoenshit/bo3perks/deadshot/mc_mtl_p7_zm_vending_deadshot.mdl",
	skin = "models/IWperks/deadeye/mc_mtl_p7_zm_vending_deadshot.mdl",
	off_skin = 1,
	on_skin = 0,
	price = 2000,
	price_skin = 1500,
	material = "models/perk_bottle/c_perk_bottle_deadshot",
	icon = Material("perk_icons/chron/deadshot.png", "smooth unlitgeneric"),
	icon_skin = Material("perk_icons/chron/deadeye.png", "smooth unlitgeneric"),
	color = Color(150, 200, 150),
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
})

nzPerks:NewPerk("mulekick", {
	name = "perk_mule_kick",
	name_skin = "perk_mule_munchies",
	model = "models/yolojoenshit/bo3perks/mulekick/mc_mtl_p7_zm_vending_mulekick.mdl",
	skin = "models/IWperks/munchies/mc_mtl_p7_zm_vending_mulekick.mdl",
	off_skin = 1,
	on_skin = 0,
	price = 4000,
	price_skin = 2000,
	material = "models/perk_bottle/c_perk_bottle_mulekick",
	icon = Material("perk_icons/chron/mulekick.png", "smooth unlitgeneric"),
	icon_skin = Material("perk_icons/chron/munchies.png", "smooth unlitgeneric"),
	color = Color(100, 200, 100),
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
		for k,v in pairs(ply:GetWeapons()) do
			if v:GetNWInt("SwitchSlot") == 3 then
				ply:StripWeapon(v:GetClass())
			end
		end
	end,
})

nzPerks:NewPerk("tombstone", {
	name = "perk_tombstone_soda",
	name_skin = "perk_tombstone_soda2",
	model_off = "models/alig96/perks/tombstone/tombstone_off.mdl",
	model = "models/alig96/perks/tombstone/tombstone.mdl",
	price = 2000,
	price_skin = 2000,
	material = "models/perk_bottle/c_perk_bottle_tombstone",
	icon = Material("perk_icons/chron/tombstone.png", "smooth unlitgeneric"),
	icon_skin = Material("perk_icons/chron/tombstone.png", "smooth unlitgeneric"),
	color = Color(100, 100, 100),
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
})

nzPerks:NewPerk("whoswho", {
	name = "perk_whoswho",
	name_skin = "perk_whoswho2",
	model_off = "models/alig96/perks/whoswho/whoswho_off.mdl",
	model = "models/alig96/perks/whoswho/whoswho.mdl",
	price = 2000,
	price_skin = 2000,
	material = "models/perk_bottle/c_perk_bottle_whoswho",
	icon = Material("perk_icons/chron/whoswho.png", "smooth unlitgeneric"),
	icon_skin = Material("perk_icons/chron/whoswho.png", "smooth unlitgeneric"),
	color = Color(100, 100, 255),
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
})

nzPerks:NewPerk("cherry", {
	name = "perk_electric_cherry",
	name_skin = "perk_blue_bolts",
	skin = "models/IWperks/bolts/cherry.mdl",
	off_skin = 1,
	on_skin = 0,
	model_off = "models/alig96/perks/cherry/cherry_off.mdl",
	model = "models/alig96/perks/cherry/cherry.mdl",
	price = 2000,
	price_skin = 1500,
	material = "models/perk_bottle/c_perk_bottle_cherry",
	icon = Material("perk_icons/chron/cherry.png", "smooth unlitgeneric"),
	icon_skin = Material("perk_icons/chron/bolts.png", "smooth unlitgeneric"),
	color = Color(50, 50, 200),
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
})

nzPerks:NewPerk("vulture", {
	name = "perk_vulture",
	name_skin = "perk_vulture2",
	model_off = "models/alig96/perks/vulture/vultureaid_off.mdl",
	model = "models/alig96/perks/vulture/vultureaid.mdl",
	price = 3000,
	price_skin = 3000,
	material = "models/perk_bottle/c_perk_bottle_vulture",
	icon = Material("perk_icons/chron/vulture.png", "smooth unlitgeneric"),
	icon_skin = Material("perk_icons/chron/vulture.png", "smooth unlitgeneric"),
	color = Color(255, 100, 100),
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
})

nzPerks:NewPerk("wunderfizz", {
	name = "perk_der_wunderfizz", -- Nothing more is needed, it is specially handled
	specialmachine = true,
})

nzPerks:NewPerk("widowswine", {
	name = "perk_widowswine",
	name_skin = "perk_widowswine2",
	model = "models/yolojoenshit/bo3perks/widows_wine/mc_mtl_p7_zm_vending_widows_wine.mdl",
	skin = "models/yolojoenshit/bo3perks/widows_wine/mc_mtl_p7_zm_vending_widows_wine.mdl",
	off_skin = 1,
	on_skin = 0,
	price = 4000,
	price_skin = 4000,
	material = "models/perk_bottle/c_perk_bottle_widowswine",
	icon = Material("perk_icons/chron/widows_wine.png", "smooth unlitgeneric"),
	icon_skin = Material("perk_icons/chron/widows_wine.png", "smooth unlitgeneric"),
	color = Color(255, 50, 200),
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
})