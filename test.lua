-- Улучшенное меню с рабочими функциями и слайдером
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaMenuPro"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Панель заголовка
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(0.5, -15, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "DELTA MENU"
Title.TextColor3 = Color3.fromRGB(0, 170, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Кнопки управления
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.TextSize = 20
CloseButton.Parent = TopBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Position = UDim2.new(1, -70, 0, 0)
MinimizeButton.Size = UDim2.new(0, 35, 0, 35)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 20
MinimizeButton.Parent = TopBar

-- Вкладки сбоку
local TabButtonsFrame = Instance.new("Frame")
TabButtonsFrame.Name = "TabButtons"
TabButtonsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TabButtonsFrame.BorderSizePixel = 0
TabButtonsFrame.Position = UDim2.new(0, 0, 0, 35)
TabButtonsFrame.Size = UDim2.new(0, 100, 1, -35)
TabButtonsFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = TabButtonsFrame

-- Контейнер для контента вкладок
local TabContentFrame = Instance.new("Frame")
TabContentFrame.Name = "TabContent"
TabContentFrame.BackgroundTransparency = 1
TabContentFrame.Position = UDim2.new(0, 105, 0, 40)
TabContentFrame.Size = UDim2.new(1, -110, 1, -45)
TabContentFrame.Parent = MainFrame

local ContentListLayout = Instance.new("UIListLayout")
ContentListLayout.Padding = UDim.new(0, 15)
ContentListLayout.Parent = TabContentFrame

-- Создаем вкладки
local Tabs = {
    ESP = {
        Button = Instance.new("TextButton"),
        Content = Instance.new("ScrollingFrame")
    },
    MOVEMENT = {
        Button = Instance.new("TextButton"),
        Content = Instance.new("ScrollingFrame")
    },
    AIMBOT = {
        Button = Instance.new("TextButton"),
        Content = Instance.new("ScrollingFrame")
    },
    SETTINGS = {
        Button = Instance.new("TextButton"),
        Content = Instance.new("ScrollingFrame")
    }
}

-- Функция создания вкладки
local function CreateTab(tabName)
    local tab = Tabs[tabName]
    
    -- Кнопка вкладки
    tab.Button.Name = tabName.."Tab"
    tab.Button.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    tab.Button.BackgroundTransparency = 0.5
    tab.Button.Size = UDim2.new(1, -10, 0, 35)
    tab.Button.Position = UDim2.new(0, 5, 0, 5)
    tab.Button.Font = Enum.Font.GothamMedium
    tab.Button.Text = tabName
    tab.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.Button.TextSize = 13
    tab.Button.Parent = TabButtonsFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = tab.Button
    
    -- Контент вкладки
    tab.Content.Name = tabName.."Content"
    tab.Content.BackgroundTransparency = 1
    tab.Content.Size = UDim2.new(1, 0, 1, 0)
    tab.Content.Visible = false
    tab.Content.ScrollBarThickness = 4
    tab.Content.ScrollBarImageColor3 = Color3.fromRGB(0, 170, 255)
    tab.Content.CanvasSize = UDim2.new(0, 0, 0, 0)
    tab.Content.Parent = TabContentFrame
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 15)
    layout.Parent = tab.Content
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tab.Content.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 15)
    end)
    
    tab.Button.MouseButton1Click:Connect(function()
        for name, t in pairs(Tabs) do
            t.Content.Visible = false
            t.Button.BackgroundTransparency = 0.5
        end
        tab.Content.Visible = true
        tab.Button.BackgroundTransparency = 0
    end)
end

-- Создаем все вкладки
for tabName, _ in pairs(Tabs) do
    CreateTab(tabName)
end

-- Активируем первую вкладку
Tabs.MOVEMENT.Content.Visible = true
Tabs.MOVEMENT.Button.BackgroundTransparency = 0

-- Функции для элементов меню
local function CreateButton(parent, text, callback)
    local Button = Instance.new("TextButton")
    Button.Name = text .. "Button"
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    Button.Size = UDim2.new(1, 0, 0, 35)
    Button.Font = Enum.Font.GothamMedium
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 13
    Button.Parent = parent
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = Button
    
    Button.MouseButton1Click:Connect(callback)
    
    return Button
end

local function CreateToggle(parent, text, default, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = text .. "Toggle"
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
    ToggleFrame.Parent = parent
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Name = "Label"
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    ToggleLabel.Font = Enum.Font.GothamMedium
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 13
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = ToggleFrame
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "Toggle"
    ToggleButton.BackgroundColor3 = default and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 60, 60)
    ToggleButton.Position = UDim2.new(0.7, 0, 0.1, 0)
    ToggleButton.Size = UDim2.new(0.3, 0, 0.8, 0)
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Text = default and "ON" or "OFF"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextSize = 13
    ToggleButton.Parent = ToggleFrame
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = ToggleButton
    
    local state = default
    
    ToggleButton.MouseButton1Click:Connect(function()
        state = not state
        ToggleButton.Text = state and "ON" or "OFF"
        ToggleButton.BackgroundColor3 = state and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 60, 60)
        if callback then callback(state) end
    end)
    
    return {
        Set = function(value)
            state = value
            ToggleButton.Text = state and "ON" or "OFF"
            ToggleButton.BackgroundColor3 = state and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 60, 60)
            if callback then callback(state) end
        end,
        Get = function() return state end
    }
end

local function CreateSlider(parent, text, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = text .. "Slider"
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Size = UDim2.new(1, 0, 0, 50)
    SliderFrame.Parent = parent
    
    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Name = "Label"
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Size = UDim2.new(1, 0, 0, 20)
    SliderLabel.Font = Enum.Font.GothamMedium
    SliderLabel.Text = text .. ": " .. default
    SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderLabel.TextSize = 13
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    SliderLabel.Parent = SliderFrame
    
    local SliderTrack = Instance.new("Frame")
    SliderTrack.Name = "Track"
    SliderTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    SliderTrack.Position = UDim2.new(0, 0, 0, 25)
    SliderTrack.Size = UDim2.new(1, 0, 0, 5)
    SliderTrack.Parent = SliderFrame
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = SliderTrack
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Name = "Fill"
    SliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.Parent = SliderTrack
    
    local UICorner2 = Instance.new("UICorner")
    UICorner2.CornerRadius = UDim.new(1, 0)
    UICorner2.Parent = SliderFill
    
    local SliderButton = Instance.new("TextButton")
    SliderButton.Name = "Button"
    SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderButton.Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8)
    SliderButton.Size = UDim2.new(0, 16, 0, 16)
    SliderButton.Text = ""
    SliderButton.Parent = SliderTrack
    
    local UICorner3 = Instance.new("UICorner")
    UICorner3.CornerRadius = UDim.new(1, 0)
    UICorner3.Parent = SliderButton
    
    local dragging = false
    local value = default
    
    local function updateSlider(input)
        local x = (input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X
        x = math.clamp(x, 0, 1)
        value = math.floor(min + (max - min) * x)
        
        SliderFill.Size = UDim2.new(x, 0, 1, 0)
        SliderButton.Position = UDim2.new(x, -8, 0.5, -8)
        SliderLabel.Text = text .. ": " .. value
        
        if callback then callback(value) end
    end
    
    SliderButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    SliderButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)
    
    return {
        Set = function(newValue)
            value = math.clamp(newValue, min, max)
            local x = (value - min) / (max - min)
            SliderFill.Size = UDim2.new(x, 0, 1, 0)
            SliderButton.Position = UDim2.new(x, -8, 0.5, -8)
            SliderLabel.Text = text .. ": " .. value
            if callback then callback(value) end
        end,
        Get = function() return value end
    }
end

-- Функционал перемещения окна
local dragging = false
local dragStart
local startPos

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

TopBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Функционал сворачивания
local minimized = false
local originalSize = MainFrame.Size

MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.2), {
            Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset, 0, 35)
        }):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.2), {
            Size = originalSize
        }):Play()
    end
end)

-- Закрытие меню
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Горячая клавиша для меню (RightShift)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- Рабочие функции для MOVEMENT
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Noclip переменные
local NoclipActive = false
local NoclipConnection

local function NoclipLoop()
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end

local function ToggleNoclip(state)
    NoclipActive = state
    if state then
        NoclipConnection = RunService.Stepped:Connect(NoclipLoop)
    elseif NoclipConnection then
        NoclipConnection:Disconnect()
    end
end

-- Автоматическое обновление character и humanoid при смерти
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
end)

-- Добавляем функционал на вкладки

-- Вкладка MOVEMENT
local SpeedSlider = CreateSlider(Tabs.MOVEMENT.Content, "Скорость", 16, 100, 16, function(value)
    if humanoid then
        humanoid.WalkSpeed = value
    end
end)

local JumpSlider = CreateSlider(Tabs.MOVEMENT.Content, "Высота прыжка", 50, 200, 50, function(value)
    if humanoid then
        humanoid.JumpPower = value
    end
end)

local NoclipToggle = CreateToggle(Tabs.MOVEMENT.Content, "Режим Noclip", false, function(state)
    ToggleNoclip(state)
end)

-- Вкладка ESP
local ESPToggle = CreateToggle(Tabs.ESP.Content, "ESP Игроков", false, function(state)
    print("ESP:", state)
end)

local ESPBoxToggle = CreateToggle(Tabs.ESP.Content, "Показывать рамки", false, function(state)
    print("ESP Boxes:", state)
end)

-- Вкладка AIMBOT
local AimbotToggle = CreateToggle(Tabs.AIMBOT.Content, "Включить Aimbot", false, function(state)
    print("Aimbot:", state)
end)

-- Вкладка SETTINGS
CreateButton(Tabs.SETTINGS.Content, "Сохранить настройки", function()
    print("Настройки сохранены")
end)
