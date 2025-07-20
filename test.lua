-- Улучшенное меню с вкладками для Roblox
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AdvancedMenu"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = MainFrame

-- Панель заголовка
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(0.5, -10, 1, 0)
Title.Font = Enum.Font.GothamSemibold
Title.Text = "Delta Menu"
Title.TextColor3 = Color3.fromRGB(0, 170, 255)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Кнопки управления
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.TextSize = 14
CloseButton.Parent = TopBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 14
MinimizeButton.Parent = TopBar

-- Вкладки сбоку
local TabButtonsFrame = Instance.new("Frame")
TabButtonsFrame.Name = "TabButtons"
TabButtonsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TabButtonsFrame.BorderSizePixel = 0
TabButtonsFrame.Position = UDim2.new(0, 0, 0, 30)
TabButtonsFrame.Size = UDim2.new(0, 80, 1, -30)
TabButtonsFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = TabButtonsFrame

-- Контейнер для контента вкладок
local TabContentFrame = Instance.new("Frame")
TabContentFrame.Name = "TabContent"
TabContentFrame.BackgroundTransparency = 1
TabContentFrame.Position = UDim2.new(0, 85, 0, 35)
TabContentFrame.Size = UDim2.new(1, -90, 1, -40)
TabContentFrame.Parent = MainFrame

local ContentListLayout = Instance.new("UIListLayout")
ContentListLayout.Padding = UDim.new(0, 10)
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
    tab.Button.Size = UDim2.new(1, -10, 0, 30)
    tab.Button.Position = UDim2.new(0, 5, 0, 5)
    tab.Button.Font = Enum.Font.GothamMedium
    tab.Button.Text = tabName
    tab.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.Button.TextSize = 12
    tab.Button.Parent = TabButtonsFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = tab.Button
    
    -- Контент вкладки
    tab.Content.Name = tabName.."Content"
    tab.Content.BackgroundTransparency = 1
    tab.Content.Size = UDim2.new(1, 0, 1, 0)
    tab.Content.Visible = false
    tab.Content.ScrollBarThickness = 3
    tab.Content.ScrollBarImageColor3 = Color3.fromRGB(0, 170, 255)
    tab.Content.CanvasSize = UDim2.new(0, 0, 0, 0)
    tab.Content.Parent = TabContentFrame
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.Parent = tab.Content
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tab.Content.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
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
Tabs.ESP.Content.Visible = true
Tabs.ESP.Button.BackgroundTransparency = 0

-- Функции для элементов меню
local function CreateButton(parent, text, callback)
    local Button = Instance.new("TextButton")
    Button.Name = text .. "Button"
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    Button.Size = UDim2.new(1, 0, 0, 30)
    Button.Font = Enum.Font.GothamMedium
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 12
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
    ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
    ToggleFrame.Parent = parent
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Name = "Label"
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    ToggleLabel.Font = Enum.Font.GothamMedium
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 12
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
    ToggleButton.TextSize = 12
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

-- Функционал перемещения окна
local dragging = false
local dragStart
local startPos

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
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
            Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset, 0, 30)
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

-- Добавляем функционал на вкладки

-- Вкладка ESP
local ESPToggle = CreateToggle(Tabs.ESP.Content, "ESP Игроков", false, function(state)
    -- Здесь будет код ESP
    print("ESP:", state)
end)

local ESPBoxToggle = CreateToggle(Tabs.ESP.Content, "Показывать рамки", false, function(state)
    print("ESP Boxes:", state)
end)

local ESPNamesToggle = CreateToggle(Tabs.ESP.Content, "Показывать имена", true, function(state)
    print("ESP Names:", state)
end)

-- Вкладка MOVEMENT
local SpeedToggle = CreateToggle(Tabs.MOVEMENT.Content, "Скорость x2", false, function(state)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = state and 32 or 16
    end
end)

local JumpToggle = CreateToggle(Tabs.MOVEMENT.Content, "Высокий прыжок", false, function(state)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = state and 100 or 50
    end
end)

local NoclipToggle = CreateToggle(Tabs.MOVEMENT.Content, "Режим Noclip", false, function(state)
    print("Noclip:", state)
    -- Здесь будет код Noclip
end)

-- Вкладка AIMBOT
local AimbotToggle = CreateToggle(Tabs.AIMBOT.Content, "Включить Aimbot", false, function(state)
    print("Aimbot:", state)
end)

local SmoothnessSlider = CreateToggle(Tabs.AIMBOT.Content, "Плавность прицела", false, function(state)
    print("Smoothness:", state)
end)

local FOVToggle = CreateToggle(Tabs.AIMBOT.Content, "Показывать FOV", true, function(state)
    print("Show FOV:", state)
end)

-- Вкладка SETTINGS
CreateButton(Tabs.SETTINGS.Content, "Сменить тему", function()
    print("Тема изменена")
end)

CreateButton(Tabs.SETTINGS.Content, "Сбросить настройки", function()
    print("Настройки сброшены")
end)

local WatermarkToggle = CreateToggle(Tabs.SETTINGS.Content, "Водяной знак", true, function(state)
    print("Watermark:", state)
end)
