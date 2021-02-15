nzTools:CreateTool("elec", {
	displayname = translate.Get("electricity_switch_placer_tool"),
	desc = translate.Get("electricity_switch_placer_tool_tip"),
	condition = function(wep, ply)
		return true
	end,

	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:Electric(tr.HitPos + tr.HitNormal*5, tr.HitNormal:Angle(), nil, ply)
	end,

	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "power_box" then
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
	displayname = translate.Get("electricity_switch_placer_tool"),
	desc = translate.Get("electricity_switch_placer_tool_tip"),
	icon = "icon16/lightning.png",
	weight = 8,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)

	end,
	--defaultdata = {}
})