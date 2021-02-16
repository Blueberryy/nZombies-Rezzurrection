local playerColors = {
	Color(239,154,154),
	Color(244,143,177),
	Color(159,168,218),
	Color(129,212,250),
	Color(128,203,196),
	Color(165,214,167),
	Color(230,238,156),
	Color(255,241,118),
	Color(255,224,130),
	Color(255,171,145),
	Color(161,136,127),
	Color(224,224,224),
	Color(144,164,174),
	nil
}

function player:GetHUDPointsType(id)
	if id == translate.Get("hud_type_bo_three") then
	 return "bo3_score1.png"
	end
		if id == translate.Get("hud_type_buried") then
	return "buried_score1.png"
	end
	if id == translate.Get("hud_type_division_nine") then
	 return "d9s.png"
	end
	if id == translate.Get("hud_type_shadows_of_evil") then
		return "bo3_score2.png"
	end
	if id == translate.Get("hud_type_bo_one") then
	 return "bo1s.png"
	end
		if id == translate.Get("hud_type_mob_of_the_dead") then
	return "bloodline_score2.png"
	end
	if id == translate.Get("hud_type_fade") then
	return "fades.png"
	end
		if id == translate.Get("hud_type_origins_bo_two") then
	return "bloodline_score2.png"
	end
		if id == translate.Get("hud_type_tranzit_bo_two") then
	return "bloodline_score3.png"
	end
		if id == translate.Get("hud_type_nzombies_classic_hd") then
	return "hd_score1.png"
	end
	if id == translate.Get("hud_type_covenant") then
	return "covenant_score1.png"
	end
	if id == translate.Get("hud_type_unsc") then
	return "unsc_score1.png"
	end
	if id == translate.Get("hud_type_dead_space") then
	return "bloodline_score2.png"
	end
	if id == translate.Get("hud_type_devil_may_cry_dante") then
	return "dante_score1.png"
	end
	if id == translate.Get("hud_type_devil_may_cry_nero") then
	return "nero_score1.png"
	end
	if id == translate.Get("hud_type_devil_may_cry_v") then
	return "V_score1.png"
	end
	if id == translate.Get("hud_type_devil_may_cry_vergil") then
	return "vergil_score1.png"
	end
	if id == translate.Get("hud_type_gears_of_war") then
	return "gears_score1.png"
	end
	if id == translate.Get("hud_type_killing_floor_two") then
	return "hd_score4.png"
	end
	if id == translate.Get("hud_type_resident_evil") then
	return "RE_score1.png"
	end
	if id == translate.Get("hud_type_simple_black") then
	return "simple_score1.png"
	end
	if id == translate.Get("hud_type_simple_outline") then
	return "simple_score1.png"
	end
	if id == nil then
	return "bloodline_score2.png"
	end
end

local blooddecals = {
	Material("bloodline_score1.png", "unlitgeneric smooth"),
	Material("bloodline_score2.png", "unlitgeneric smooth"),
	Material("bloodline_score3.png", "unlitgeneric smooth"),
	Material("bloodline_score4.png", "unlitgeneric smooth"),
	nil
}

--shuffle the colors on map start
local rand = math.random
local n = #playerColors

while n > 2 do

	local k = rand(n) -- 1 <= k <= n

	playerColors[n], playerColors[k] = playerColors[k], playerColors[n]
	n = n - 1
end

n = #blooddecals

while n > 2 do

	local k = rand(n) -- 1 <= k <= n

	blooddecals[n], blooddecals[k] = blooddecals[k], blooddecals[n]
	n = n - 1
end

function player.GetColorByIndex(index)
	return playerColors[((index - 1) % #playerColors) + 1]
end

function player.GetBloodByIndex(index)
	return Material(player:GetHUDPointsType(nzMapping.Settings.hudtype), "unlitgeneric smooth")
end
