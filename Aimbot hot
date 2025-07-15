-- Load Rayfield UI (official) local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({ Name = "Aimbot Hub", LoadingTitle = "Loading...", ConfigurationSaving = { Enabled = true, FolderName = "AimbotHub", FileName = "Settings" }, Discord = { Enabled = false, }, })

local Players = game:GetService("Players") local LocalPlayer = Players.LocalPlayer local RunService = game:GetService("RunService") local Workspace = workspace local Camera = Workspace.CurrentCamera local UserInputService = game:GetService("UserInputService")

-- Settings local AimbotEnabled = false local PredictMovement = false local PredictionStrength = 0.11 local LockPart = "Head" local TeamCheck = true local WallCheck = true local WalkSpeed = 16 local JumpPower = 50 local NoclipEnabled = false

local noclipConnection

local function isOnSameTeam(player) return LocalPlayer.Team and player.Team and LocalPlayer.Team == player.Team end

local function canSeeTarget(character) local origin = Camera.CFrame.Position local targetPart = character:FindFirstChild("HumanoidRootPart") if not targetPart then return false end local rayParams = RaycastParams.new() rayParams.FilterDescendantsInstances = {LocalPlayer.Character} rayParams.FilterType = Enum.RaycastFilterType.Blacklist local result = Workspace:Raycast(origin, (targetPart.Position - origin), rayParams) return not result or result.Instance:IsDescendantOf(character) end

-- Tabs local AimbotTab = Window:CreateTab("Aimbot") local MovementTab = Window:CreateTab("Movement")

-- Aimbot Controls AimbotTab:CreateToggle({ Name = "Enable Aimbot", CurrentValue = AimbotEnabled, Callback = function(v) AimbotEnabled = v end, })

AimbotTab:CreateDropdown({ Name = "Lock On Part", Options = {"Head", "HumanoidRootPart"}, CurrentOption = LockPart, Callback = function(opt) LockPart = opt end, })

AimbotTab:CreateToggle({ Name = "Team Check", CurrentValue = TeamCheck, Callback = function(v) TeamCheck = v end, })

AimbotTab:CreateToggle({ Name = "Wall Check", CurrentValue = WallCheck, Callback = function(v) WallCheck = v end, })

AimbotTab:CreateToggle({ Name = "Movement Prediction", CurrentValue = PredictMovement, Callback = function(v) PredictMovement = v end, })

-- Movement Controls MovementTab:CreateSlider({ Name = "WalkSpeed", Range = {0, 500}, Increment = 1, CurrentValue = WalkSpeed, Callback = function(v) WalkSpeed = v local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") if hum then hum.WalkSpeed = WalkSpeed end end, })

MovementTab:CreateSlider({ Name = "JumpPower", Range = {0, 500}, Increment = 1, CurrentValue = JumpPower, Callback = function(v) JumpPower = v local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") if hum then hum.JumpPower = JumpPower end end, })

MovementTab:CreateToggle({ Name = "Noclip", CurrentValue = NoclipEnabled, Callback = function(value) NoclipEnabled = value if value then noclipConnection = RunService.Stepped:Connect(function() if LocalPlayer.Character then for _, part in ipairs(LocalPlayer.Character:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = false end end end end) elseif noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end end, })

-- Smoother Aimbot Logic RunService.RenderStepped:Connect(function() if not AimbotEnabled then return end

local closestTarget, closestDistance = nil, math.huge
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
        if TeamCheck and isOnSameTeam(player) then continue end
        if WallCheck and not canSeeTarget(player.Character) then continue end

        local targetPart = player.Character:FindFirstChild(LockPart)
        if targetPart then
            local screenPos, onScreen = Camera:WorldToScreenPoint(targetPart.Position)
            if onScreen then
                local mousePos = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
                local dist = (mousePos - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                if dist < closestDistance then
                    closestDistance = dist
                    closestTarget = targetPart
                end
            end
        end
    end
end

if closestTarget then
    local aimPos = closestTarget.Position
    if PredictMovement then
        local vel = closestTarget.Velocity
        aimPos = aimPos + (vel * PredictionStrength)
    end
    local currentPos = Camera.CFrame.Position
    local newLook = (aimPos - currentPos).Unit
    Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(currentPos, currentPos + newLook), 0.15)
end

end)

