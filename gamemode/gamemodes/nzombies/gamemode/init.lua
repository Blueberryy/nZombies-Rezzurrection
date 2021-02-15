local plyMeta = FindMetaTable("Player")
FullSyncModules = {}

function plyMeta:SendFullSync()
	-- Modules add their own fullsync functions into this table
	for k,v in pairs(FullSyncModules) do
		v(self)
	end
end

include( "shared.lua" )
AddCSLuaFile( "shared.lua" )

include( "sh_translate.lua" )
AddCSLuaFile( "sh_translate.lua" )

include( "loader.lua" )
AddCSLuaFile( "loader.lua" )