const fs = require('fs');
const path = require('path');

const srcDir = path.join(__dirname, 'src');

function readFile(filePath) {
    return fs.readFileSync(path.join(srcDir, filePath), 'utf8');
}

const output = `-- Universal UI Library Bundled (Glassmorphism & Modern Dark)
local UILib = {}

local Theme = (function()
${readFile('themes/dark_glass.lua')}
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
    
    return publicWin
end

-- =======================================================
-- EKSEKUSI TEMPLATE (TESTING DYNAMIC GRID)
-- =======================================================

local myUI = UILib:Init("NextUI")

local mainTab = myUI:AddTab("Main")

mainTab:AddToggle("Auto Farm Mobs", false, function(state)
    print("Toggle State:", state)
end)

mainTab:AddSlider("WalkSpeed Mod", 16, 100, 16, function(value)
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

mainTab:AddDropdown("Select Weapon", {"Sword", "Bow", "Magic"}, function(selected)
    print("Selected:", selected)
end)

-- Simulasi Banyak Tombol untuk melihat efek 2-Grid saat Fullscreen
for i = 1, 10 do
    mainTab:AddButton("Simulated Button " .. i, function()
        print("Clicked Button " .. i)
    end)
end

local settingsTab = myUI:AddTab("Settings")

settingsTab:AddToggle("Anti Lag Mode", true, function(state)
    print("Anti lag:", state)
end)
settingsTab:AddButton("Destroy UI", function()
    print("UI Destroyed")
end)
`;

fs.writeFileSync(path.join(__dirname, 'template.lua'), output);
console.log('Build successful! template.lua updated with dynamic grid system.');