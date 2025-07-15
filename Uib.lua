--// EX+ UI Library (VanillaUI-style) // -- Returns: UI object with methods to create toggles, buttons, textboxes, dropdowns, and tabs

local Players = game:GetService("Players") local CoreGui = game:GetService("CoreGui")

local function CreateVanillaUI() local UI = {}

local gui = Instance.new("ScreenGui")
gui.Name = "EXPlusUILib"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 460, 0, 360)
main.Position = UDim2.new(0.5, -230, 0.5, -180)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 110, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 10)
local listLayout = Instance.new("UIListLayout", sidebar)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 8)

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -120, 1, -20)
content.Position = UDim2.new(0, 120, 0, 10)
content.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", content).CornerRadius = UDim.new(0, 10)

function UI.NewTab(name)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, -12, 0, 36)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

    local page = Instance.new("Frame", content)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false

    btn.MouseButton1Click:Connect(function()
        for _, child in pairs(content:GetChildren()) do
            if child:IsA("Frame") then child.Visible = false end
        end
        page.Visible = true
    end)

    return page
end

function UI.MakeToggle(parent, pos, label, default, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, 200, 0, 32)
    btn.Position = pos
    btn.Text = (default and "✔ " or "✘ ") .. label
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = (state and "✔ " or "✘ ") .. label
        callback(state)
    end)
end

function UI.MakeButton(parent, pos, text, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, 200, 0, 36)
    btn.Position = pos
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
    btn.MouseButton1Click:Connect(callback)
end

function UI.MakeTextBox(parent, pos, default, placeholder, callback)
    local box = Instance.new("TextBox", parent)
    box.Size = UDim2.new(0, 200, 0, 30)
    box.Position = pos
    box.Text = default
    box.PlaceholderText = placeholder
    box.ClearTextOnFocus = false
    box.Font = Enum.Font.GothamBold
    box.TextSize = 14
    box.BackgroundColor3 = Color3.fromRGB(50,50,50)
    box.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,6)
    box.FocusLost:Connect(function(enter)
        if enter then
            local val = tonumber(box.Text)
            if val then callback(val) end
        end
    end)
end

function UI.MakeDropdown(parent, pos, options, default, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, 200, 0, 32)
    btn.Position = pos
    btn.Text = "Target: " .. default
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

    btn.MouseButton1Click:Connect(function()
        local current = table.find(options, default) or 1
        local nextIndex = (current % #options) + 1
        default = options[nextIndex]
        btn.Text = "Target: " .. default
        callback(default)
    end)
end

return UI

end

return CreateVanillaUI

