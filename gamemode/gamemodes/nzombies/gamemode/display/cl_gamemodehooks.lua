function GM:ContextMenuOpen()
	return nzRound:InState( ROUND_CREATE ) and LocalPlayer():IsAdmin()
end

function GM:PopulateMenuBar(panel)
	panel:Remove()
	return false
end

function GM:OnUndo( name, strCustomString )

	if ( !strCustomString ) then
		local str = "#Undone_" .. name
		local translated = language.GetPhrase( str )
		if ( str == translated ) then
			-- No translation available, apply our own
			translated = string.format( language.GetPhrase( "hint.undoneX" ), language.GetPhrase( name ) )
		else
			-- Try to translate some of this
			local strmatch = string.match( translated, "^Undone (.*)$" )
			if ( strmatch ) then
				translated = string.format( language.GetPhrase( "hint.undoneX" ), language.GetPhrase( strmatch ) )
			end
		end

		notification.AddLegacy( translated, NOTIFY_UNDO, 2 )
	else
		-- This is a hack for SWEPs, etc, to support #translations from server
		local str = string.match( strCustomString, "^Undone (.*)$" )
		if ( str ) then
			strCustomString = string.format( language.GetPhrase( "hint.undoneX" ), language.GetPhrase( str ) )
		end

		notification.AddLegacy( strCustomString, NOTIFY_UNDO, 2 )
	end

	-- Find a better sound :X
	surface.PlaySound( "buttons/button15.wav" )

end
