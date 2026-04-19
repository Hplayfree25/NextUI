const fs = require('fs');
const path = require('path');

const srcDir = path.join(__dirname, 'src');
const distDir = path.join(__dirname, 'dist');

if (!fs.existsSync(distDir)) {
    fs.mkdirSync(distDir);
}

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

return UILib
`;

fs.writeFileSync(path.join(distDir, 'main.lua'), output);
console.log('Build successful! File output telah tersimpan di dist/main.lua');
