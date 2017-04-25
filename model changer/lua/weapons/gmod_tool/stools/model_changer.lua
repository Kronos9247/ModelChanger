TOOL.Category = "Kronos9247's Tools"
TOOL.Name = "#tool.model_changer.name"
TOOL.Command = nil
TOOL.ConfigName = ""

TOOL.ClientConVar[ "model" ] = ""

if ( CLIENT ) then
	TOOL.Information = {
		{ name = "info", stage = 1 },
		{ name = "left" },
		{ name = "right" },
		
	}
	
	language.Add("tool.model_changer.name", "Model Changer")
	language.Add("tool.model_changer.desc", "This tool can change the model of every entity, prop and swep!")
	
	language.Add( "tool.model_changer.left", "Sets the model of the thing you clicked." )
	language.Add( "tool.model_changer.right", "Gets the model of the thing you clicked." )
end

function TOOL:LeftClick( trace )	
	if(trace.Entity) then
		local Ent = trace.Entity 
		
		if(Ent:IsValid()) then
			if(!Ent:IsRagdoll()) then
				if(!Ent:IsWorld()) then
					if(self:GetOwner():GetNWString("model")) then
						local Model = self:GetOwner():GetNWString("model")
						
						Ent:PhysicsDestroy() 
						Ent:SetModel( Model ) 
						
						Ent:PhysicsInit( SOLID_VPHYSICS ) 
						Ent:SetMoveType( MOVETYPE_VPHYSICS )
						Ent:SetSolid( SOLID_VPHYSICS )
						
						Ent:PhysWake()
						
						return true
					end
				end
			end
		end
		
		return false
	end
end

function TOOL:RightClick( trace )
	if(trace.Entity) then
		local Ent = trace.Entity 
		
		if(Ent:IsValid()) then
			if(!Ent:IsRagdoll()) then
				if(!Ent:IsWorld()) then
					self:GetOwner():SetNWString( "model", Ent:GetModel() )
					
					return true
				end
			end
		end
		
		return false
	end
end

function TOOL.BuildCPanel( panel )
	panel:AddControl("Header", { Text = "#tool.model_changer.name", Description = "#tool.model_changer.desc" })
	
end

if CLIENT then
	local screenMaterial = Material( "modelchanger/model_changer" )
	
	function TOOL:DrawToolScreen(width, height)
		cam.Start2D()
		render.Clear(0,0,0,0)
		
		render.SetShadowsDisabled( true ) 
		
		surface.SetMaterial( screenMaterial )
		
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect( -40, -40, width + 80, height + 80 )
		
		render.SetShadowsDisabled( false ) 
		
		cam.End2D()
	end
end