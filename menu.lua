-- Delta Injector UI
-- Использует библиотеку Rayfield для красивого интерфейса

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
    Name = "Delta Injector | Premium",
    LoadingTitle = "Delta Injector",
    LoadingSubtitle = "by Delta Team",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "DeltaConfig",
        FileName = "DeltaConfig"
    },
    Discord = {
        Enabled = true,
        Invite = "discord.gg/delta", -- Замените на реальный инвайт
        RememberJoins = true
    },
    KeySystem = true, -- Включить систему ключей (по желанию)
    KeySettings = {
        Title = "Delta Injector",
        Subtitle = "Key System",
        Note = "Получите ключ в нашем дискорде",
        FileName = "DeltaKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"DELTA-1234-5678-9012"} -- Пример ключа
    }
})

-- Вкладка "Главная"
local MainTab = Window:CreateTab("Главная", 4483362458) -- Иконка можно поменять
local MainSection = MainTab:CreateSection("Основные функции")

local InjectButton = MainTab:CreateButton({
    Name = "Ввести скрипт",
    Callback = function()
        Rayfield:Notify({
            Title = "Ввод скрипта",
            Content = "Скрипт успешно введен!",
            Duration = 6.5,
            Image = 4483362458,
            Actions = {
                Ignore = {
                    Name = "Ок",
                    Callback = function()
                        print("Пользователь подтвердил уведомление")
                    end
                },
            },
        })
        -- Здесь код для инжекта скрипта
    end,
})

local ClearButton = MainTab:CreateButton({
    Name = "Очистить окружение",
    Callback = function()
        -- Код для очистки
        Rayfield:Notify({
            Title = "Очистка",
            Content = "Окружение успешно очищено!",
            Duration = 6.5,
            Image = 4483362458,
        })
    end,
})

-- Вкладка "Скрипты"
local ScriptsTab = Window:CreateTab("Скрипты", 4483362458)
local PopularSection = ScriptsTab:CreateSection("Популярные скрипты")

local DarkDexButton = ScriptsTab:CreateButton({
    Name = "Dark Dex",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/.../darkdex.lua"))() -- Вставьте реальную ссылку
    end,
})

local InfiniteYieldButton = ScriptsTab:CreateButton({
    Name = "Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/.../infiniteyield.lua"))() -- Вставьте реальную ссылку
    end,
})

-- Вкладка "Настройки"
local SettingsTab = Window:CreateTab("Настройки", 4483362458)
local UISection = SettingsTab:CreateSection("Интерфейс")

local ToggleUI = SettingsTab:CreateToggle({
    Name = "Темная тема",
    CurrentValue = true,
    Flag = "DarkTheme",
    Callback = function(Value)
        -- Код для смены темы
    end,
})

local Slider = SettingsTab:CreateSlider({
    Name = "Прозрачность UI",
    Range = {0, 100},
    Increment = 5,
    Suffix = "%",
    CurrentValue = 50,
    Flag = "UItransparency",
    Callback = function(Value)
        -- Код для изменения прозрачности
    end,
})

-- Вкладка "Информация"
local InfoTab = Window:CreateTab("Информация", 4483362458)
local AboutSection = InfoTab:CreateSection("О Delta Injector")

InfoTab:CreateLabel("Версия: 2.5.1 Premium")
InfoTab:CreateLabel("Разработчик: Delta Team")
InfoTab:CreateLabel("Дата сборки: " .. os.date("%d.%m.%Y"))

local DiscordButton = InfoTab:CreateButton({
    Name = "Присоединиться к Discord",
    Callback = function()
        setclipboard("discord.gg/delta") -- Замените на реальный инвайт
        Rayfield:Notify({
            Title = "Discord",
            Content = "Ссылка скопирована в буфер обмена!",
            Duration = 6.5,
            Image = 4483362458,
        })
    end,
})

Rayfield:LoadConfiguration() -- Загрузить сохраненные настройки
