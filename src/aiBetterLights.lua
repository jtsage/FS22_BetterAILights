----------------------------------------------------------------------------
-- @Author: JTSage ---------------------------------------------------------
----------------------------------------------------------------------------

AIBetterLights = {};

function AIBetterLights:updateAILights(superFunc, isWorking)
	local spec          = self.spec_lights

	local isCombine     = ( self.spec_combine ~= nil )
	local hasPipe       = ( self.spec_pipe ~= nil)
	local isPipeOut     = false
	local hasLightType4 = false

	if ( isCombine and hasPipe ) then
		isPipeOut     = ( self.spec_pipe.currentState == 2)
		hasLightType4 = ( self.spec_lights.maxLightState >= 4 )
	end

	if not g_currentMission.environment.isSunOn or g_currentMission.environment.weather:getIsRaining() then
		local typeMask = spec.aiLightsTypesMask

		-- Check to see if we are on a field.  This may be nessesary for courseplay.
		-- if self.getIsOnField ~= nil and self:getIsOnField() then
		-- 	typeMask = spec.aiLightsTypesMaskWork
		-- end

		if isWorking then
			typeMask = spec.aiLightsTypesMaskWork
		end

		if isCombine and isPipeOut and hasLightType4 then
			-- Combine type, with a pipe, that is out, and it has a lightType 4
			-- which is likely (base game) the pipe light, so lets turn that on too.
			typeMask = bitOR(typeMask, 2 ^ 4)
		end

		if spec.lightsTypesMask ~= typeMask then
			self:setLightsTypesMask(typeMask)
		end
	else
		if spec.lightsTypesMask ~= 0 then
			self:setLightsTypesMask(0)
		end
	end
end

Lights.updateAILights = Utils.overwrittenFunction(Lights.updateAILights, AIBetterLights.updateAILights);