nzTools:CreateTool("navedit", {
	displayname = translate.Get("navmesh_editor_tool"),
	desc = translate.Get("navmesh_editor_tool_tip"),
	condition = function(wep, ply)
		return true
	end,

	PrimaryAttack = function(wep, ply, tr, data)
		if data.Primary then
			RunConsoleCommand(data.Primary)
		end
	end,

	SecondaryAttack = function(wep, ply, tr, data)
		if data.Secondary then
			RunConsoleCommand(data.Secondary)
		end
	end,
	Reload = function(wep, ply, tr, data)
		if data.Reload then
			RunConsoleCommand(data.Reload)
		else
			RunConsoleCommand("nav_mark")
		end
	end,
	OnEquip = function(wep, ply, data)
		if wep.Owner:IsListenServerHost() then
			RunConsoleCommand("nav_edit", 1)
		end
	end,
	OnHolster = function(wep, ply, data)
		if SERVER and wep.Owner:IsListenServerHost() then
			RunConsoleCommand("nav_edit", 0)
		end
	end
}, {
	displayname = translate.Get("navmesh_editor_tool"),
	desc = translate.Get("navmesh_editor_tool_tip"),
	icon = "icon16/map.png",
	weight = 39,
	condition = function(wep, ply)
		return nzTools.Advanced
	end,
	interface = function(frame, data)

		local cont = vgui.Create("DScrollPanel", frame)
		cont:Dock(FILL)
		
		function cont.CompileData()
			return data
		end
		
		function cont.UpdateData(data)
			nzTools:SendData(data, "navedit") -- Save the same data here
		end

		--command and mode declaration

		local modes = {
			[translate.Get("navmesh_editor_mode_change_att")] = {
				Primary = "nav_jump",
				PrimaryDesc = translate.Get("navmesh_editor_change_att_control"),
				Secondary = "nav_no_jump",
				SecondaryDesc = translate.Get("navmesh_editor_change_att_control_two")
			},
			[translate.Get("navmesh_editor_mode_delete_area")] = {
				Primary = "nav_delete",
				PrimaryDesc = translate.Get("navmesh_editor_delete_area_control")
			},
			[translate.Get("navmesh_editor_mode_corners")] = {
				Primary = "nav_corner_place_on_ground",
				PrimaryDesc = translate.Get("navmesh_editor_corners_control")
			},
			[translate.Get("navmesh_editor_mode_edit_area")] = {
				Primary = "nav_split",
				PrimaryDesc = translate.Get("navmesh_editor_edit_area_control"),
				Secondary = "nav_merge",
				SecondaryDesc = translate.Get("navmesh_editor_edit_area_control_two")
			},
			[translate.Get("navmesh_editor_mode_create_areas")] = {
				Primary = "nav_begin_area",
				PrimaryDesc = translate.Get("navmesh_editor_create_areas_control"),
				Secondary = "nav_end_area",
				SecondaryDesc = translate.Get("navmesh_editor_create_areas_control_two")
			},
			[translate.Get("navmesh_editor_mode_connect_areas")] = {
				Primary = "nav_connect",
				PrimaryDesc = translate.Get("navmesh_editor_connect_areas_control"),
				Secondary = "nav_disconnect",
				SecondaryDesc = translate.Get("navmesh_editor_connect_areas_control_two")
			},
			[translate.Get("navmesh_editor_mode_ladder")] = {
				Primary = "nav_build_ladder",
				PrimaryDesc = translate.Get("navmesh_editor_ladder_control")
			},
			[translate.Get("navmesh_editor_mode_slice")] = {
				Primary = "nav_splice",
				PrimaryDesc = translate.Get("navmesh_editor_slice_control"),
				Secondary = "nav_split",
				SecondaryDesc = translate.Get("navmesh_editor_slice_control_two"),
			}
		}

		local commands = {
			[translate.Get("quick_commands_build_ladder")] = "nav_build_ladder",
			[translate.Get("quick_commands_toggle_jump_area")] = "nav_jump",
			[translate.Get("quick_commands_toggle_no_jump_area")] = "nav_no_jump",
			[translate.Get("quick_commands_begin_area_creation")] = "nav_begin_area",
			[translate.Get("quick_commands_end_area_creation")] = "nav_end_area",
			[translate.Get("quick_commands_merge_areas")] = "nav_merge",
			[translate.Get("quick_commands_place_corner_on_ground")] = "nav_corner_place_on_ground",
			[translate.Get("quick_commands_connect_areas")] = "nav_connect",
			[translate.Get("quick_commands_disconnect_areas")] = "nav_disconnect",
			[translate.Get("quick_commands_delete_area")] = "nav_delete",
			[translate.Get("quick_commands_split_area")] = "nav_split",
			[translate.Get("quick_commands_mark_area")] = "nav_mark",
			[translate.Get("quick_commands_generate_incremental")] = "nav_generate_incremental",
			[translate.Get("quick_commands_clear_selected_set")] = "nav_clear_selected_set",
			[translate.Get("quick_commands_mark_walkable")] = "nav_mark_walkable",
		}

		--update helper

		local function UpdateDesc()
			local result = ""
			if data.PrimaryDesc then
				result = translate.Format("navmesh_editor_modes_control", data.PrimaryDesc)
			end
			if data.SecondaryDesc then
				if result != "" then
					result = result .. ", "
				end
				result = translate.Format("navmesh_editor_modes_control_two", result, data.SecondaryDesc)
			end
			if data.ReloadDesc then
				if result != "" then
					result = result .. ", "
				end
				result = translate.Format("navmesh_editor_modes_control_three", result, data.ReloadDesc)
			else
				if result != "" then
					result = result .. ", "
				end
				result = translate.Format("navmesh_editor_modes_control_four", result)
			end
			nzTools.ToolData["navedit"].desc = result
		end

		--"basic" stuff

		local basicCat = vgui.Create( "DCollapsibleCategory", cont )
		basicCat:SetExpanded( 1 )
		basicCat:SetLabel( translate.Get("navmesh_editor_category_basics") )
		basicCat:Dock(TOP)

		local basic = vgui.Create("DListLayout", cont)
		basic:Dock(TOP)
		basic:DockMargin(5,5,5,5)

		local modePnl = basic:Add( "DPanel" )
		modePnl:Dock(TOP)

		local modeLbl = modePnl:Add( "DLabel" )
		modeLbl:SetText(translate.Get("navmesh_editor_select_edit_mode"))
		modeLbl:SetDark(true)
		modeLbl.Paint = function() end
		modeLbl:Dock(LEFT)
		modeLbl:SizeToContents()

		local mode = modePnl:Add( "DComboBox" )
		mode:Dock(TOP)
		for k,v in pairs(modes) do
			mode:AddChoice(k,v)
		end
		mode:AddChoice(translate.Get("navmesh_editor_mode_custom"))

		-- custom mode

		local custom = basic:Add( "DPanel" )
		custom:Dock(TOP)
		custom:SetVisible(false)

		local primCust = custom:Add( "DComboBox" )
		primCust:Dock(LEFT)
		for k,v in pairs(commands) do
			primCust:AddChoice(v, k)
		end
		primCust:SetValue(translate.Get("navmesh_editor_custom_primary"))

		local secCust = custom:Add( "DComboBox" )
		secCust:Dock(LEFT)
		for k,v in pairs(commands) do
			secCust:AddChoice(v, k)
		end
		secCust:SetValue(translate.Get("navmesh_editor_custom_secondary"))

		local reCust = custom:Add( "DComboBox" )
		reCust:Dock(LEFT)
		for k,v in pairs(commands) do
			reCust:AddChoice(v, k)
		end
		reCust:SetValue(translate.Get("navmesh_editor_custom_reload"))

		local subCust = custom:Add( "DButton" )
		subCust:Dock(LEFT)
		subCust:SetText(translate.Get("navmesh_editor_custom_submit"))
		function subCust:DoClick()
			if primCust:GetValue() != translate.Get("navmesh_editor_custom_primary") then
				data.Primary, data.PrimaryDesc = primCust:GetSelected()
			end
			if secCust:GetValue() != translate.Get("navmesh_editor_custom_secondary") then
				data.Secondary, data.SecondaryDesc = secCust:GetSelected()
			end
			if reCust:GetValue() != translate.Get("navmesh_editor_custom_reload") then
				data.Reload, data.ReloadDesc = reCust:GetSelected()
			end
			UpdateDesc()
			cont.UpdateData(cont.CompileData())
		end

		-- end custom mode

		-- basic settings
		local settingsPnl = basic:Add( "DListLayout" )
		settingsPnl:Dock(TOP)
		settingsPnl:DockMargin(0,10,0,0)

		local settingsLbl = settingsPnl:Add( "DLabel" )
		settingsLbl:SetText(translate.Get("navmesh_editor_settings"))
		settingsLbl:SetDark(true)
		settingsLbl.Paint = function() end
		settingsLbl:Dock(TOP)
		settingsLbl:SetContentAlignment(5)

		local snapGrid = settingsPnl:Add("DNumSlider")
		snapGrid:Dock(TOP)
		snapGrid:SetText(translate.Get("navmesh_editor_snap_to_grid"))
		snapGrid:SetMin(0)
		snapGrid:SetMax(2)
		snapGrid:SetDecimals(0)
		snapGrid:SetDark(true)
		snapGrid:SetConVar("nav_snap_to_grid")

		local showInfo = settingsPnl:Add("DNumSlider")
		showInfo:Dock(TOP)
		showInfo:SetText(translate.Get("navmesh_editor_display_are_info"))
		showInfo:SetMin(0)
		showInfo:SetMax(60)
		showInfo:SetDecimals(1)
		showInfo:SetDark(true)
		showInfo:SetConVar("nav_show_area_info")

		local cvars = {
			[translate.Get("navmesh_editor_place_created_areas_on_ground")] = "nav_create_place_on_ground",
			[translate.Get("navmesh_editor_place_splitted_areas_on_ground")] = "nav_split_place_on_ground",
			[translate.Get("navmesh_editor_show_compass")] = "nav_show_compass"
		}

		for k,v in pairs(cvars) do
			local cvar = settingsPnl:Add( "DCheckBoxLabel" )
			cvar:SetConVar(v)
			cvar:SetText(k)
			cvar:SizeToContents()
			cvar:SetDark(true)
			cvar:Dock(TOP)
		end

		-- end settings

		function mode:OnSelect(index, name, val)
			if name == "Custom" then
				custom:SetVisible(true)
			else
				custom:SetVisible(false)
				data.Primary = val.Primary
				data.Secondary = val.Secondary
				data.PrimaryDesc = val.PrimaryDesc
				data.SecondaryDesc = val.SecondaryDesc
				UpdateDesc()
				cont.UpdateData(cont.CompileData())
			end
		end

		basicCat:SetContents(basic)

		--danger zone

		local dangerCat = vgui.Create( "DCollapsibleCategory", cont )
		dangerCat:SetExpanded( 1 )
		dangerCat:SetLabel( translate.Get("navmesh_editor_category_danger_zone") )
		dangerCat:Dock(TOP)

		local danger = vgui.Create("DListLayout", cont)
		danger:Dock(TOP)
		danger:DockMargin(5,5,5,5)

		local innerPnl = danger:Add("DPanel")
		innerPnl:Dock(TOP)

		local save = innerPnl:Add("DButton")
		save:Dock(FILL)
		save:SetText(translate.Get("navmesh_editor_danger_zone_save"))
		save:SetConsoleCommand("nav_save")
		save:SizeToContents()

		local gen = innerPnl:Add("DButton")
		gen:Dock(LEFT)
		gen:SetText(translate.Get("navmesh_editor_danger_zone_generate"))
		gen:SizeToContents()
		gen:DockPadding(5,0,5,0)
		gen:SetConsoleCommand("say", "/generate")

		local analyze = innerPnl:Add("DButton")
		analyze:Dock(RIGHT)
		analyze:SetText(translate.Get("navmesh_editor_danger_zone_analyze"))
		analyze:SizeToContents()
		analyze:DockPadding(5,0,5,0)
		analyze:SetConsoleCommand("nav_analyze")

		local quick = danger:Add("DCheckBoxLabel")
		quick:SetConVar("nav_quicksave")
		quick:SetText(translate.Get("navmesh_editor_danger_zone_enable_quicksave"))
		quick:SizeToContents()
		quick:SetDark(true)
		quick:Dock(TOP)
		quick:DockMargin(0,10,0,0)

		dangerCat:SetContents(danger)


		-- end danger zone

		--"advanced" stuff

		local advCat = vgui.Create( "DCollapsibleCategory", cont )
		advCat:SetExpanded( 0 )
		advCat:SetLabel( translate.Get("navmesh_editor_category_quick_commands") )
		advCat:Dock(TOP)

		local adv = vgui.Create("DListLayout", cont)
		adv:Dock(TOP)

		for k,v in pairs(commands) do
			local btn = vgui.Create("DButton")
			btn:SetText(k)
			btn:Dock(TOP)
			btn:DockMargin(5,5,5,0)
			btn:SetConsoleCommand(v)
			adv:Add(btn)
		end

		advCat:SetContents(adv)

		return cont
	end,
	defaultdata = {
	}
})
