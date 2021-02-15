nzTools:CreateTool("ee", {
	displayname = translate.Get("easter_egg_placer_tool"),
	desc = translate.Get("easter_egg_placer_tool_tip"),
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:EasterEgg(tr.HitPos, Angle(0,0,0), "models/props_lab/huladoll.mdl", ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "easter_egg" then
			tr.Entity:Remove()
		end
	end,
	Reload = function(wep, ply, tr, data)
		-- Nothing
	end,
	OnEquip = function(wep, ply, data)

	end,
	OnHolster = function(wep, ply, data)

	end
}, {
	displayname = translate.Get("easter_egg_placer_tool"),
	desc = translate.Get("easter_egg_placer_tool_tip"),
	icon = "icon16/music.png",
	weight = 20,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)

	end,
	--defaultdata = {}
})
nzTools:CreateTool("usable_ending", {
	displayname = translate.Get("ending_placer_tool"),
	desc = translate.Get("ending_placer_tool_tip"),
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:BuyableEnding(tr.HitPos, Angle(0,0,0), "models/hoff/props/teddy_bear/teddy_bear.mdl", ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "buyable_ending" then
			tr.Entity:Remove()
		end
	end,
	Reload = function(wep, ply, tr, data)
		-- Nothing
	end,
	OnEquip = function(wep, ply, data)

	end,
	OnHolster = function(wep, ply, data)

	end
}, {
	displayname = translate.Get("ending_placer_tool"),
	desc = translate.Get("ending_placer_tool_tip"),
	icon = "icon16/tick.png",
	weight = 20,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)

	end,
	--defaultdata = {}
})