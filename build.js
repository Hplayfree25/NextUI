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

local TabConstructor = (function()
${readFile('core/tab.lua')}
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

function UILib:Init(title)
    local WindowLib = WindowConstructor(Theme)
    local TabLib = TabConstructor(Theme)
    local win = WindowLib:Create(title)
    local publicWin = {}
    function publicWin:AddTab(name)
        local tab = TabLib:Create(win, name)
        local publicTab = {}
        function publicTab:AddButton(text, callback)
            ButtonConstructor(Theme)(tab, text, callback)
        end
        function publicTab:AddToggle(text, default, callback)
            ToggleConstructor(Theme)(tab, text, default, callback)
        end
        function publicTab:AddSlider(text, min, max, default, callback)
            SliderConstructor(Theme)(tab, text, min, max, default, callback)
        end
        function publicTab:AddDropdown(text, options, callback)
            DropdownConstructor(Theme)(tab, text, options, callback)
        end
        return publicTab
    end
    function publicWin:BuildSettingsTab()
        local sTab = self:AddTab("UI Settings")
        sTab:AddDropdown("Theme Preset", {"Dark", "Glass", "Light"}, function(sel)
            Theme:SetTheme(sel)
        end)
        sTab:AddDropdown("Accent Color", {"Blurple", "Red", "Green", "Pink", "Gold"}, function(sel)
            if sel == "Blurple" then Theme:SetAccent(Color3.fromRGB(88, 101, 242))
            elseif sel == "Red" then Theme:SetAccent(Color3.fromRGB(235, 64, 52))
            elseif sel == "Green" then Theme:SetAccent(Color3.fromRGB(87, 242, 135))
            elseif sel == "Pink" then Theme:SetAccent(Color3.fromRGB(235, 69, 158))
            elseif sel == "Gold" then Theme:SetAccent(Color3.fromRGB(241, 196, 15)) end
        end)
    end
    return publicWin
end

local myUI = UILib:Init("NextUI")
local mainTab = myUI:AddTab("Main")

mainTab:AddToggle("Auto Farm Mobs", false, function(state)
end)

mainTab:AddSlider("WalkSpeed Mod", 16, 100, 16, function(value)
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

mainTab:AddDropdown("Select Weapon", {"Sword", "Bow", "Magic"}, function(selected)
end)

for i = 1, 10 do
    mainTab:AddButton("Simulated Button " .. i, function()
    end)
end

myUI:BuildSettingsTab()
`;
fs.writeFileSync(path.join(__dirname, 'template.lua'), output);
