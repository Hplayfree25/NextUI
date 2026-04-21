const fs = require('fs');
const path = require('path');
const srcDir = path.join(__dirname, 'src');
function readFile(filePath) {
    return fs.readFileSync(path.join(srcDir, filePath), 'utf8');
}
const output = `local UILib = {}

local Theme = (function()
${readFile('core/theme.lua')}
end)()

local WindowConstructor = (function()
${readFile('core/window.lua')}
end)()

local AuthConstructor = (function()
${readFile('core/auth.lua')}
end)()

local TabConstructor = (function()
${readFile('core/tab.lua')}
end)()

local SectionConstructor = (function()
${readFile('components/section.lua')}
end)()

local LabelConstructor = (function()
${readFile('components/label.lua')}
end)()

local ButtonConstructor = (function()
${readFile('components/button.lua')}
end)()

local ToggleConstructor = (function()
${readFile('components/toggle.lua')}
end)()

local SliderConstructor = (function()
${readFile('components/slider.lua')}
end)()

local DropdownConstructor = (function()
${readFile('components/dropdown.lua')}
end)()

local MultiDropdownConstructor = (function()
${readFile('components/multidropdown.lua')}
end)()

function UILib:Init(config)
    if type(config) == "string" then
        config = {Title = config}
    end

    Theme:Load()
    local WindowLib = WindowConstructor(Theme)
    local AuthLib = AuthConstructor(Theme)
    local TabLib = TabConstructor(Theme)

    local win = WindowLib:Create(config.Title or "NextUI")

    if config.KeySystem then
        AuthLib:Create(win, config)
    else
        win:PlayIntro()
    end

    local publicWin = {}

    function publicWin:AddTab(name)
        local tab = TabLib:Create(win, name)
        local publicTab = {}

        function publicTab:AddSection(secTitle)
            local sec = SectionConstructor(Theme)(tab, secTitle)
            local publicSec = {}

            function publicSec:AddLabel(text)
                LabelConstructor(Theme)(sec, text)
            end
            function publicSec:AddButton(text, callback)
                ButtonConstructor(Theme)(sec, text, callback)
            end
            function publicSec:AddToggle(text, default, callback)
                ToggleConstructor(Theme)(sec, text, default, callback)
            end
            function publicSec:AddSlider(text, min, max, default, callback)
                SliderConstructor(Theme)(sec, text, min, max, default, callback)
            end
            function publicSec:AddDropdown(text, options, callback)
                DropdownConstructor(Theme)(sec, text, options, callback)
            end
            function publicSec:AddMultiDropdown(text, options, defaultSelected, callback)
                MultiDropdownConstructor(Theme)(sec, text, options, defaultSelected, callback)
            end

            return publicSec
        end
        return publicTab
    end

    local function buildCreditsTab()
        local sTab = publicWin:AddTab("Credits")
        local infoSec = sTab:AddSection("Information")
        infoSec:AddLabel("Script Author: " .. tostring(config.Author or "Unknown"))
        infoSec:AddLabel("Script Version: " .. tostring(config.Version or "1.0.0"))
        infoSec:AddLabel("UI Library: NextUI by MizaeDev")

        if config.KeySystem then
            local statusLbl = infoSec:AddLabel("Member Status: Unverified")
            win.OnAuthSuccess.Event:Connect(function(className)
                statusLbl:SetText("Member Status: " .. tostring(className))
            end)
        end

        local themeSec = sTab:AddSection("Theme Settings")
        themeSec:AddDropdown("Theme Preset", {"Dark", "Glass", "Light"}, function(sel)
            Theme:SetTheme(sel)
        end)
        themeSec:AddDropdown("Accent Color", {"Blurple", "Red", "Green", "Pink", "Gold", "Cyan", "Orange"}, function(sel)
            if sel == "Blurple" then Theme:SetCustom("Accent", Color3.fromRGB(88, 101, 242))
            elseif sel == "Red" then Theme:SetCustom("Accent", Color3.fromRGB(235, 64, 52))
            elseif sel == "Green" then Theme:SetCustom("Accent", Color3.fromRGB(87, 242, 135))
            elseif sel == "Pink" then Theme:SetCustom("Accent", Color3.fromRGB(235, 69, 158))
            elseif sel == "Gold" then Theme:SetCustom("Accent", Color3.fromRGB(241, 196, 15))
            elseif sel == "Cyan" then Theme:SetCustom("Accent", Color3.fromRGB(0, 255, 255))
            elseif sel == "Orange" then Theme:SetCustom("Accent", Color3.fromRGB(255, 128, 0)) end
        end)
    end

    buildCreditsTab()
    return publicWin
    end

    local UI = UILib:Init({
    Title = "Universal Hub",
    Author = "YourName Here",
    Version = "V2.1.0",
    KeySystem = true,
    KeySettings = {
        Title = "NextUI Login",
        Subtitle = "Join discord to get the key",
        -- Multiple Membership Classes
        Key = {
            Free = {"Free123", "TrialKey"},
            Premium = {"Premium123", "VipKey"},
            Developer = "Dev123"
        },
        SaveKey = true,
        GrabKeyFromSite = false,
        Discord = "https://discord.gg/"
    }
    })
local mainTab = UI:AddTab("Main")
local farmSec = mainTab:AddSection("Farming")
farmSec:AddToggle("Auto Farm Mobs", false, function(state)
end)
farmSec:AddDropdown("Select Weapon", {"Sword", "Bow", "Magic"}, function(selected)
end)
farmSec:AddMultiDropdown("Target Mobs", {"Zombie", "Skeleton", "Boss", "Bandit"}, {"Zombie"}, function(selected)
end)

local playerSec = mainTab:AddSection("Player")
playerSec:AddSlider("WalkSpeed Mod", 16, 100, 16, function(value)
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)
playerSec:AddButton("Reset Character", function()
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character:BreakJoints()
    end
end)

local testTab = UI:AddTab("Testing Grid")
local gridSec = testTab:AddSection("Grid Simulation")
for i = 1, 15 do
    gridSec:AddButton("Test Button " .. i, function()
    end)
end
`;
fs.writeFileSync(path.join(__dirname, 'template.lua'), output);
