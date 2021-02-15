local plyMeta = FindMetaTable( "Player" )

function plyMeta:ReadyUp()

	if !navmesh.IsLoaded() then
		PrintTranslatedMessage( HUD_PRINTTALK, "error_ready_no_navmesh")
		return false
	end

	if nzMapping:CheckSpawns() == false then
		PrintTranslatedMessage( HUD_PRINTTALK, "error_ready_no_spawns")
		return false
	end

	--Check if we have enough player spawns
	if nzMapping:CheckEnoughPlayerSpawns() == false then
		PrintTranslatedMessage( HUD_PRINTTALK, "error_ready_not_enough_spawns", #player.GetAll(), #ents.FindByClass("player_spawns") )
		return false
	end

	if nzRound:InState( ROUND_WAITING ) or nzRound:InState( ROUND_INIT ) then
		if !self:IsReady() then
			PrintTranslatedMessage( HUD_PRINTTALK, "x_is_ready", self:Nick() )
			self:SetReady( true )
			self:SetTeam(TEAM_PLAYERS)
			hook.Call( "OnPlayerReady", nzRound, self )
		else
			self:PrintTranslatedMessage( HUD_PRINTTALK, "you_are_already_ready" )
		end
	elseif nzRound:InProgress() then
		if self:IsPlaying() then
			self:PrintTranslatedMessage( HUD_PRINTTALK, "you_are_already_playing" )
		else
			self:PrintTranslatedMessage( HUD_PRINTTALK, "you_will_be_dropin_next_round" )
			self:DropIn()
		end
	end

	return true

end

function plyMeta:UnReady()
	if nzRound:InState( ROUND_WAITING ) then
		if self:IsReady() then
			PrintTranslatedMessage( HUD_PRINTTALK, "x_no_longer_ready", self:Nick() )
			self:SetReady( false )
			hook.Call( "OnPlayerUnReady", nzRound, self )
		end
	end
	if nzRound:InProgress() then
		self:DropOut()
	end
end

function plyMeta:DropIn()
	if GetConVar("nz_round_dropins_allow"):GetBool() and !self:IsPlaying() then
		self:SetReady( true )
		self:SetPlaying( true )
		self:SetTeam( TEAM_PLAYERS )
		self:RevivePlayer()
		hook.Call( "OnPlayerDropIn", nzRound, self )
		if nzRound:GetNumber() == 1 and nzRound:InState(ROUND_PREP) then
			PrintTranslatedMessage( HUD_PRINTTALK, "x_is_dropping_in", self:Nick() )
			self:ReSpawn()
		else
			PrintTranslatedMessage( HUD_PRINTTALK, "x_will_be_dropping_in_next_round", self:Nick() )
		end
	else
		self:PrintTranslatedMessage( HUD_PRINTTALK, "you_are_already_in_queue_or_server_block" )
	end
end

function plyMeta:DropOut()
	if self:IsPlaying() then
		PrintTranslatedMessage( HUD_PRINTTALK, "x_has_dropped_out_of_the_game", self:Nick() )
		self:SetReady( false )
		self:SetPlaying( false )
		self:RevivePlayer()
		self:KillSilent()
		self:SetTargetPriority(TARGET_PRIORITY_NONE)
		hook.Call( "OnPlayerDropOut", nzRound, self )
	end
end

function plyMeta:ReSpawn()

	--Setup a player
	player_manager.SetPlayerClass( self, "player_ingame" )
	if !self:Alive() then
		self:Spawn()
		self:SetTeam( TEAM_PLAYERS )
	end

end

function plyMeta:GiveCreativeMode()

	player_manager.SetPlayerClass( self, "player_create" )
	if !self:Alive() then
		self:Spawn()
	end

end

function plyMeta:RemoveCreativeMode()

	player_manager.SetPlayerClass( self, "player_ingame" ) -- Defaults to ingame
	self:SetSpectator()

end

function plyMeta:ToggleCreativeMode()
	if self:IsInCreative() then
		self:RemoveCreativeMode()
		
		if nzRound:InState(ROUND_CREATE) then
			local creative = false
			for k,v in pairs(player.GetAll()) do
				if v:IsInCreative() then
					creative = true
					break
				end
			end
			
			-- If there are no other players left in creative, return to survival
			if !creative then
				nzRound:Create(false)
			end
		end
	else
		if !nzRound:InState(ROUND_CREATE) then
			nzRound:Create(true)
		end
		if nzRound:InState(ROUND_CREATE) then -- Only if we already are or we successfully switched to it
			self:GiveCreativeMode()
		else
			self:ChatPrintTranslated("cant_go_in_creative_right_now")
		end
	end
end