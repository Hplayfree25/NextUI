local tweenSvc = game:GetService("TweenService")
local Theme = {
    Objects = {},
    Current = {
        Background = Color3.fromRGB(18, 18, 24),
        BackgroundTransparency = 0,
        TopBar = Color3.fromRGB(24, 24, 32),
        TopBarTransparency = 0,
        TabUnselected = Color3.fromRGB(24, 24, 32),
        TabSelected = Color3.fromRGB(88, 101, 242),
        ElementBg = Color3.fromRGB(28, 28, 38),
        ElementHover = Color3.fromRGB(38, 38, 50),
        ElementClick = Color3.fromRGB(20, 20, 28),
        TextMain = Color3.fromRGB(255, 255, 255),
        TextDim = Color3.fromRGB(160, 160, 170),
        Accent = Color3.fromRGB(88, 101, 242),
        CornerRadius = UDim.new(0, 8)
    },
    Presets = {
        Dark = {
            Background = Color3.fromRGB(18, 18, 24), BackgroundTransparency = 0,
            TopBar = Color3.fromRGB(24, 24, 32), TopBarTransparency = 0,
            TabUnselected = Color3.fromRGB(24, 24, 32), TabSelected = Color3.fromRGB(88, 101, 242),
            ElementBg = Color3.fromRGB(28, 28, 38), ElementHover = Color3.fromRGB(38, 38, 50), ElementClick = Color3.fromRGB(20, 20, 28),
            TextMain = Color3.fromRGB(255, 255, 255), TextDim = Color3.fromRGB(160, 160, 170), Accent = Color3.fromRGB(88, 101, 242),
            CornerRadius = UDim.new(0, 8)
        },
        Glass = {
            Background = Color3.fromRGB(15, 15, 20), BackgroundTransparency = 0.4,
            TopBar = Color3.fromRGB(20, 20, 25), TopBarTransparency = 0.5,
            TabUnselected = Color3.fromRGB(30, 30, 35), TabSelected = Color3.fromRGB(60, 100, 255),
            ElementBg = Color3.fromRGB(25, 25, 30), ElementHover = Color3.fromRGB(35, 35, 45), ElementClick = Color3.fromRGB(15, 15, 20),
            TextMain = Color3.fromRGB(255, 255, 255), TextDim = Color3.fromRGB(150, 150, 160), Accent = Color3.fromRGB(60, 100, 255),
            CornerRadius = UDim.new(0, 8)
        },
        Light = {
            Background = Color3.fromRGB(240, 240, 245), BackgroundTransparency = 0,
            TopBar = Color3.fromRGB(255, 255, 255), TopBarTransparency = 0,
            TabUnselected = Color3.fromRGB(220, 220, 225), TabSelected = Color3.fromRGB(88, 101, 242),
            ElementBg = Color3.fromRGB(255, 255, 255), ElementHover = Color3.fromRGB(230, 230, 235), ElementClick = Color3.fromRGB(210, 210, 215),
            TextMain = Color3.fromRGB(20, 20, 20), TextDim = Color3.fromRGB(100, 100, 100), Accent = Color3.fromRGB(88, 101, 242),
            CornerRadius = UDim.new(0, 8)
        }
    }
}
function Theme:Apply(obj, props)
    for prop, key in pairs(props) do
        table.insert(self.Objects, {Obj = obj, Prop = prop, Key = key})
        obj[prop] = self.Current[key]
    end
end
function Theme:SetTheme(name)
    local preset = self.Presets[name]
    if preset then
        for k, v in pairs(preset) do
            self.Current[k] = v
        end
        self:UpdateAll()
    end
end
function Theme:SetAccent(color)
    self.Current.Accent = color
    self.Current.TabSelected = color
    self:UpdateAll()
end
function Theme:UpdateAll()
    for _, item in ipairs(self.Objects) do
        if item.Obj and item.Obj.Parent then
            local val = self.Current[item.Key]
            if val ~= nil then
                local s = pcall(function()
                    tweenSvc:Create(item.Obj, TweenInfo.new(0.3), {[item.Prop] = val}):Play()
                end)
                if not s then item.Obj[item.Prop] = val end
            end
        end
    end
end
return Theme