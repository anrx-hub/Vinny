-- Performance Optimization Script (Anti-Lag)
local Lighting = game:GetService("Lighting")
local Terrain = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")

-- 1. Reduce Environment & Graphics Quality
if Terrain then
    Terrain.WaterWaveSize = 0
    Terrain.WaterWaveSpeed = 0
    Terrain.WaterReflectance = 0
    Terrain.WaterTransparency = 0
end

Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9
Lighting.Brightness = 1

-- 2. Disable Heavy Visual Effects
for _, effect in pairs(Lighting:GetChildren()) do
    if effect:IsA("PostEffect") or effect:IsA("BloomEffect") or effect:IsA("BlurEffect") then
        effect.Enabled = false
    end
end

-- 3. Clean Up Remote or Transparent Objects
for _, obj in pairs(game.Workspace:GetDescendants()) do
    if obj:IsA("BasePart") then
        -- Disable reflections
        obj.Reflectance = 0
        -- Optimize rendering for invisible parts
        if obj.Transparency >= 1 then
            obj.CanCollide = false
        end
    elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
        obj.Enabled = false
    end
end

print("Performance mode activated!")
