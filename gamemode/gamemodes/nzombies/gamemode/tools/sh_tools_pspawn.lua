nzTools:CreateTool("pspawn", {
	displayname = translate.Get("player_spawn_creator_tool"),
	desc = translate.Get("player_spawn_creator_tool_tip"),
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:PlayerSpawn(tr.HitPos, ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "player_spawns" then
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
	displayname = translate.Get("player_spawn_creator_tool"),
	desc = translate.Get("player_spawn_creator_tool_tip"),
	icon = "icon16/user.png",
	weight = 2,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data) end,
	-- defaultdata = {}
})