----------------------------------------------------------------------------
-- @Author: JTSage ---------------------------------------------------------
----------------------------------------------------------------------------

aiBetterLights = {};

function aiBetterLights:updateAILights(isWorking)
    local spec = self.spec_lights

    if not g_currentMission.environment.isSunOn or g_currentMission.environment.weather:getIsRaining() then
        local typeMask = spec.aiLightsTypesMask
        if isWorking then
            typeMask = spec.aiLightsTypesMaskWork
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

Lights.updateAILights = Utils.overwrittenFunction(Lights.updateAILights, aiBetterLights.updateAILights);