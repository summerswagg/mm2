--[[
  Красивое меню для Roblox с анимациями и настройками
  Поддерживает инжектор Delta
]]

-- Настройки меню
local Settings = {
    Title = "Delta Menu",
    TitleColor = Color3.fromRGB(0, 170, 255),
    BackgroundColor = Color3.fromRGB(30, 30, 40),
    WindowColor = Color3.fromRGB(45, 45, 55),
    TextColor = Color3.fromRGB(255, 255, 255),
    AccentColor = Color3.fromRGB(0, 170, 255),
    ToggleOnColor = Color3.fromRGB(0, 255, 127),
    ToggleOffColor = Color3.fromRGB(255, 60, 60),
    SliderColor = Color3.fromRGB(0, 170, 255),
    ButtonColor = Color3.fromRGB(0, 120, 215),
    ButtonHoverColor = Color3.fromRGB(0, 150, 255),
    
    WindowSize = UDim2.new(0, 400, 0, 500),
    MinWindowSize = UDim2.new(0, 300, 0, 300),
    
    AnimationSpeed = 0.2,
    DragSensitivity = 1,
    
    DefaultTab = "Main",
    WatermarkEnabled = true,
    WatermarkText = "Delta Injector | v1.0",
    
    Keybinds = {
        ToggleMenu = Enum.KeyCode.RightShift,
        CloseMenu = Enum.KeyCode.End
    }
}

-- Создаем основной GUI
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local DeltaMenu = Instance.new("ScreenGui")
DeltaMenu.Name = "DeltaMenu"
DeltaMenu.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
DeltaMenu.ResetOnSpawn = false
DeltaMenu.Parent = CoreGui

-- Основной контейнер
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Settings.BackgroundColor
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
MainFrame.Size = Settings.WindowSize
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.ClipsDescendants = true
MainFrame.Parent = DeltaMenu

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.BackgroundColor3 = Settings.WindowColor
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.Parent = MainFrame

local UICorner2 = Instance.new("UICorner")
UICorner2.CornerRadius = UDim.new(0, 6)
UICorner2.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(0.5, -10, 1, 0)
Title.Font = Enum.Font.GothamSemibold
Title.Text = Settings.Title
Title.TextColor3 = Settings.TitleColor
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

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
MinimizeButton.TextColor3 = Settings.TextColor
MinimizeButton.TextSize = 14
MinimizeButton.Parent = TopBar

local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.BackgroundColor3 = Settings.WindowColor
TabContainer.BorderSizePixel = 0
TabContainer.Position = UDim2.new(0, 0, 0, 30)
TabContainer.Size = UDim2.new(0, 100, 1, -30)
TabContainer.Parent = MainFrame

local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 100, 0, 30)
ContentContainer.Size = UDim2.new(1, -100, 1, -30)
ContentContainer.ClipsDescendants = true
ContentContainer.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = TabContainer

local Tabs = {}

-- Водяной знак
if Settings.WatermarkEnabled then
    local Watermark = Instance.new("TextLabel")
    Watermark.Name = "Watermark"
    Watermark.BackgroundColor3 = Settings.WindowColor
    Watermark.BackgroundTransparency = 0.5
    Watermark.Position = UDim2.new(0.5, -100, 0, 10)
    Watermark.Size = UDim2.new(0, 200, 0, 20)
    Watermark.AnchorPoint = Vector2.new(0.5, 0)
    Watermark.Font = Enum.Font.GothamMedium
    Watermark.Text = Settings.WatermarkText
    Watermark.TextColor3 = Settings.TextColor
    Watermark.TextSize = 12
    Watermark.Parent = DeltaMenu
    
    local UICorner3 = Instance.new("UICorner")
    UICorner3.CornerRadius = UDim.new(0, 4)
    UICorner3.Parent = Watermark
end

-- Функции для меню
local function CreateTab(tabName)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabName .. "TabButton"
    TabButton.BackgroundColor3 = Settings.WindowColor
    TabButton.BackgroundTransparency = 0.5
    TabButton.Size = UDim2.new(1, -10, 0, 30)
    TabButton.Position = UDim2.new(0, 5, 0, 5)
    TabButton.Font = Enum.Font.GothamMedium
    TabButton.Text = tabName
    TabButton.TextColor3 = Settings.TextColor
    TabButton.TextSize = 12
    TabButton.Parent = TabContainer
    
    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Name = tabName .. "TabContent"
    TabContent.BackgroundTransparency = 1
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.Visible = false
    TabContent.ScrollBarThickness = 3
    TabContent.ScrollBarImageColor3 = Settings.AccentColor
    TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContent.Parent = ContentContainer
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 10)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = TabContent
    
    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabContent.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
    end)
    
    Tabs[tabName] = {
        Button = TabButton,
        Content = TabContent
    }
    
    TabButton.MouseButton1Click:Connect(function()
        for name, tab in pairs(Tabs) do
            tab.Content.Visible = false
            tab.Button.BackgroundTransparency = 0.5
        end
        
        TabContent.Visible = true
        TabButton.BackgroundTransparency = 0
    end)
    
    if tabName == Settings.DefaultTab then
        TabContent.Visible = true
        TabButton.BackgroundTransparency = 0
    end
    
    return TabContent
end

local function CreateButton(tab, text, callback)
    local Button = Instance.new("TextButton")
    Button.Name = text .. "Button"
    Button.BackgroundColor3 = Settings.ButtonColor
    Button.Size = UDim2.new(1, -20, 0, 30)
    Button.Position = UDim2.new(0, 10, 0, 0)
    Button.Font = Enum.Font.GothamMedium
    Button.Text = text
    Button.TextColor3 = Settings.TextColor
    Button.TextSize = 12
    Button.Parent = tab
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = Button
    
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Settings.ButtonHoverColor}):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Settings.ButtonColor}):Play()
    end)
    
    Button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    return Button
end

local function CreateToggle(tab, text, default, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = text .. "ToggleFrame"
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Size = UDim2.new(1, -20, 0, 30)
    ToggleFrame.Parent = tab
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Name = "ToggleLabel"
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    ToggleLabel.Font = Enum.Font.GothamMedium
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Settings.TextColor
    ToggleLabel.TextSize = 12
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = ToggleFrame
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.BackgroundColor3 = default and Settings.ToggleOnColor or Settings.ToggleOffColor
    ToggleButton.Position = UDim2.new(0.7, 0, 0, 5)
    ToggleButton.Size = UDim2.new(0.3, 0, 1, -10)
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Text = default and "ON" or "OFF"
    ToggleButton.TextColor3 = Settings.TextColor
    ToggleButton.TextSize = 12
    ToggleButton.Parent = ToggleFrame
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = ToggleButton
    
    local state = default
    
    ToggleButton.MouseButton1Click:Connect(function()
        state = not state
        ToggleButton.Text = state and "ON" or "OFF"
        TweenService:Create(ToggleButton, TweenInfo.new(0.1), {
            BackgroundColor3 = state and Settings.ToggleOnColor or Settings.ToggleOffColor
        }):Play()
        
        if callback then
            callback(state)
        end
    end)
    
    return {
        Set = function(value)
            state = value
            ToggleButton.Text = state and "ON" or "OFF"
            ToggleButton.BackgroundColor3 = state and Settings.ToggleOnColor or Settings.ToggleOffColor
            if callback then
                callback(state)
            end
        end,
        Get = function()
            return state
        end
    }
end

local function CreateSlider(tab, text, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = text .. "SliderFrame"
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Size = UDim2.new(1, -20, 0, 50)
    SliderFrame.Parent = tab
    
    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Name = "SliderLabel"
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Size = UDim2.new(1, 0, 0, 20)
    SliderLabel.Font = Enum.Font.GothamMedium
    SliderLabel.Text = text .. ": " .. default
    SliderLabel.TextColor3 = Settings.TextColor
    SliderLabel.TextSize = 12
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    SliderLabel.Parent = SliderFrame
    
    local SliderTrack = Instance.new("Frame")
    SliderTrack.Name = "SliderTrack"
    SliderTrack.BackgroundColor3 = Settings.WindowColor
    SliderTrack.Position = UDim2.new(0, 0, 0, 25)
    SliderTrack.Size = UDim2.new(1, 0, 0, 5)
    SliderTrack.Parent = SliderFrame
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = SliderTrack
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Name = "SliderFill"
    SliderFill.BackgroundColor3 = Settings.SliderColor
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.Parent = SliderTrack
    
    local UICorner2 = Instance.new("UICorner")
    UICorner2.CornerRadius = UDim.new(1, 0)
    UICorner2.Parent = SliderFill
    
    local SliderButton = Instance.new("TextButton")
    SliderButton.Name = "SliderButton"
    SliderButton.BackgroundColor3 = Settings.AccentColor
    SliderButton.Position = UDim2.new((default - min) / (max - min), -5, 0, -5)
    SliderButton.Size = UDim2.new(0, 10, 0, 15)
    SliderButton.Text = ""
    SliderButton.Parent = SliderTrack
    
    local UICorner3 = Instance.new("UICorner")
    UICorner3.CornerRadius = UDim.new(0, 3)
    UICorner3.Parent = SliderButton
    
    local dragging = false
    local value = default
    
    local function updateSlider(input)
        local x = (input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X
        x = math.clamp(x, 0, 1)
        value = math.floor(min + (max - min) * x)
        
        SliderFill.Size = UDim2.new(x, 0, 1, 0)
        SliderButton.Position = UDim2.new(x, -5, 0, -5)
        SliderLabel.Text = text .. ": " .. value
        
        if callback then
            callback(value)
        end
    end
    
    SliderButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
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
            SliderButton.Position = UDim2.new(x, -5, 0, -5)
            SliderLabel.Text = text .. ": " .. value
            if callback then
                callback(value)
            end
        end,
        Get = function()
            return value
        end
    }
end

-- Функционал меню
local dragging = false
local dragStartPos
local startPos

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = Vector2.new(input.Position.X, input.Position.Y)
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
        local delta = Vector2.new(input.Position.X, input.Position.Y) - dragStartPos
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X * Settings.DragSensitivity, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y * Settings.DragSensitivity
        )
    end
end)

local minimized = false
local originalSize = MainFrame.Size

MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        TweenService:Create(MainFrame, TweenInfo.new(Settings.AnimationSpeed), {
            Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset, 0, 30)
        }):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(Settings.AnimationSpeed), {
            Size = originalSize
        }):Play()
    end
end)

local menuVisible = true

CloseButton.MouseButton1Click:Connect(function()
    menuVisible = false
    TweenService:Create(MainFrame, TweenInfo.new(Settings.AnimationSpeed), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    wait(Settings.AnimationSpeed)
    DeltaMenu.Enabled = false
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Settings.Keybinds.ToggleMenu then
            menuVisible = not menuVisible
            DeltaMenu.Enabled = menuVisible
            if menuVisible then
                MainFrame.Size = UDim2.new(0, 0, 0, 0)
                TweenService:Create(MainFrame, TweenInfo.new(Settings.AnimationSpeed), {
                    Size = originalSize
                }):Play()
            end
        elseif input.KeyCode == Settings.Keybinds.CloseMenu then
            menuVisible = false
            DeltaMenu.Enabled = false
        end
    end
end)

-- Пример использования
local MainTab = CreateTab("Main")
local CombatTab = CreateTab("Combat")
local VisualsTab = CreateTab("Visuals")
local MiscTab = CreateTab("Misc")

-- Пример элементов
CreateButton(MainTab, "Test Button", function()
    print("Button clicked!")
end)

local testToggle = CreateToggle(MainTab, "Test Toggle", false, function(state)
    print("Toggle state:", state)
end)

local testSlider = CreateSlider(MainTab, "Test Slider", 0, 100, 50, function(value)
    print("Slider value:", value)
end)

-- Возвращаем API для внешнего использования
return {
    CreateTab = CreateTab,
    CreateButton = CreateButton,
    CreateToggle = CreateToggle,
    CreateSlider = CreateSlider,
    ToggleMenu = function()
        menuVisible = not menuVisible
        DeltaMenu.Enabled = menuVisible
    end,
    CloseMenu = function()
        menuVisible = false
        DeltaMenu.Enabled = false
    end,
    IsMenuOpen = function()
        return menuVisible
    end,
    GetInstance = function()
        return DeltaMenu
    end
}
