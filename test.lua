-- Delta Injector UI (Standalone Version)
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Основные цвета
local mainColor = Color3.fromRGB(25, 25, 35)
local accentColor = Color3.fromRGB(0, 170, 255)
local textColor = Color3.fromRGB(255, 255, 255)

-- Создание основного GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 500)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = mainColor
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Эффект скругления углов
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Тень
local UIStroke = Instance.new("UIStroke")
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Color = accentColor
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Заголовок
local TitleFrame = Instance.new("Frame")
TitleFrame.Name = "TitleFrame"
TitleFrame.Size = UDim2.new(1, 0, 0, 40)
TitleFrame.Position = UDim2.new(0, 0, 0, 0)
TitleFrame.BackgroundColor3 = accentColor
TitleFrame.BorderSizePixel = 0
TitleFrame.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, -40, 1, 0)
TitleLabel.Position = UDim2.new(0, 40, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "DELTA INJECTOR v2.5"
TitleLabel.TextColor3 = textColor
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleFrame

-- Иконка
local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Size = UDim2.new(0, 30, 0, 30)
Logo.Position = UDim2.new(0, 5, 0, 5)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://7072718362" -- Можно заменить на другую иконку
Logo.Parent = TitleFrame

-- Кнопка закрытия
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundTransparency = 1
CloseButton.TextColor3 = textColor
CloseButton.Text = "X"
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleFrame

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Вкладки
local Tabs = {"Главная", "Скрипты", "Настройки", "Инфо"}
local TabButtons = {}
local TabFrames = {}

local TabListFrame = Instance.new("Frame")
TabListFrame.Name = "TabListFrame"
TabListFrame.Size = UDim2.new(1, 0, 0, 40)
TabListFrame.Position = UDim2.new(0, 0, 0, 40)
TabListFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TabListFrame.BorderSizePixel = 0
TabListFrame.Parent = MainFrame

local TabContentFrame = Instance.new("Frame")
TabContentFrame.Name = "TabContentFrame"
TabContentFrame.Size = UDim2.new(1, -20, 1, -100)
TabContentFrame.Position = UDim2.new(0, 10, 0, 90)
TabContentFrame.BackgroundTransparency = 1
TabContentFrame.Parent = MainFrame

-- Создание вкладок
for i, tabName in ipairs(Tabs) do
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabName.."Tab"
    TabButton.Size = UDim2.new(0, 80, 1, 0)
    TabButton.Position = UDim2.new(0, (i-1)*85, 0, 0)
    TabButton.BackgroundColor3 = i == 1 and accentColor or Color3.fromRGB(45, 45, 55)
    TabButton.AutoButtonColor = false
    TabButton.Text = tabName
    TabButton.TextColor3 = textColor
    TabButton.TextSize = 14
    TabButton.Font = Enum.Font.Gotham
    TabButton.Parent = TabListFrame
    
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Name = tabName.."Frame"
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.Position = UDim2.new(0, 0, 0, 0)
    TabFrame.BackgroundTransparency = 1
    TabFrame.Visible = i == 1
    TabFrame.ScrollBarThickness = 3
    TabFrame.ScrollBarImageColor3 = accentColor
    TabFrame.Parent = TabContentFrame
    
    TabButtons[tabName] = TabButton
    TabFrames[tabName] = TabFrame
    
    TabButton.MouseButton1Click:Connect(function()
        for name, frame in pairs(TabFrames) do
            frame.Visible = false
        end
        TabFrame.Visible = true
        
        for name, button in pairs(TabButtons) do
            button.BackgroundColor3 = (name == tabName) and accentColor or Color3.fromRGB(45, 45, 55)
        end
    end)
end

-- Функция для создания кнопок
local function CreateButton(parent, text, callback)
    local Button = Instance.new("TextButton")
    Button.Name = text.."Button"
    Button.Size = UDim2.new(1, 0, 0, 40)
    Button.Position = UDim2.new(0, 0, 0, #parent:GetChildren() * 45)
    Button.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    Button.AutoButtonColor = true
    Button.Text = text
    Button.TextColor3 = textColor
    Button.TextSize = 14
    Button.Font = Enum.Font.Gotham
    Button.Parent = parent
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = Button
    
    local UIStroke = Instance.new("UIStroke")
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Color = accentColor
    UIStroke.Thickness = 1
    UIStroke.Parent = Button
    
    Button.MouseButton1Click:Connect(callback)
    
    return Button
end

-- Добавление элементов на вкладки
-- Вкладка "Главная"
local HomeFrame = TabFrames["Главная"]
CreateButton(HomeFrame, "Ввести скрипт", function()
    print("Скрипт введен")
    -- Здесь код для инжекта
end)

CreateButton(HomeFrame, "Очистить окружение", function()
    print("Окружение очищено")
    -- Здесь код для очистки
end)

-- Вкладка "Скрипты"
local ScriptsFrame = TabFrames["Скрипты"]
CreateButton(ScriptsFrame, "Dark Dex", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/.../darkdex.lua"))()
end)

CreateButton(ScriptsFrame, "Infinite Yield", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/.../infiniteyield.lua"))()
end)

-- Вкладка "Настройки"
local SettingsFrame = TabFrames["Настройки"]
CreateButton(SettingsFrame, "Темная тема", function()
    -- Код для смены темы
end)

-- Вкладка "Инфо"
local InfoFrame = TabFrames["Инфо"]
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Name = "InfoLabel"
InfoLabel.Size = UDim2.new(1, 0, 0, 100)
InfoLabel.Position = UDim2.new(0, 0, 0, 0)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "Delta Injector v2.5\nРазработчик: Delta Team\nДата: "..os.date("%d.%m.%Y")
InfoLabel.TextColor3 = textColor
InfoLabel.TextSize = 14
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextYAlignment = Enum.TextYAlignment.Top
InfoLabel.Parent = InfoFrame

-- Перетаскивание окна
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleFrame.InputBegan:Connect(function(input)
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

TitleFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
