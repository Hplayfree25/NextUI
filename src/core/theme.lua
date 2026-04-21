local tweenSvc = game:GetService("TweenService")
local httpSvc = game:GetService("HttpService")
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
        Dark = {Background = Color3.fromRGB(18, 18, 24), BackgroundTransparency = 0, TopBar = Color3.fromRGB(24, 24, 32), TopBarTransparency = 0, TabUnselected = Color3.fromRGB(24, 24, 32), ElementBg = Color3.fromRGB(28, 28, 38), ElementHover = Color3.fromRGB(38, 38, 50), ElementClick = Color3.fromRGB(20, 20, 28), TextMain = Color3.fromRGB(255, 255, 255), TextDim = Color3.fromRGB(160, 160, 170), CornerRadius = UDim.new(0, 8)},
        Glass = {Background = Color3.fromRGB(15, 15, 20), BackgroundTransparency = 0.5, TopBar = Color3.fromRGB(20, 20, 25), TopBarTransparency = 0.6, TabUnselected = Color3.fromRGB(30, 30, 35), ElementBg = Color3.fromRGB(25, 25, 30), ElementHover = Color3.fromRGB(35, 35, 45), ElementClick = Color3.fromRGB(15, 15, 20), TextMain = Color3.fromRGB(255, 255, 255), TextDim = Color3.fromRGB(150, 150, 160), CornerRadius = UDim.new(0, 0)},
        Light = {Background = Color3.fromRGB(240, 240, 245), BackgroundTransparency = 0, TopBar = Color3.fromRGB(255, 255, 255), TopBarTransparency = 0, TabUnselected = Color3.fromRGB(220, 220, 225), ElementBg = Color3.fromRGB(255, 255, 255), ElementHover = Color3.fromRGB(230, 230, 235), ElementClick = Color3.fromRGB(210, 210, 215), TextMain = Color3.fromRGB(20, 20, 20), TextDim = Color3.fromRGB(100, 100, 100), CornerRadius = UDim.new(0, 8)}
    },
    ConfigName = "Vantix_Settings.json"
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
        self:Save()
    end
end
function Theme:SetCustom(key, value)
    if self.Current[key] ~= nil then
        self.Current[key] = value
        if key == "Accent" then
            self.Current.TabSelected = value
        end
        self:UpdateAll()
        self:Save()
    end
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
function Theme:Save()
    local env = getfenv()
    local write_file = env.writefile
    pcall(function()
        if not write_file and env.getgenv then
            write_file = env.getgenv().writefile
        end
    end)
    if write_file then
        local data = {}
        for k, v in pairs(self.Current) do
            if typeof(v) == "Color3" then
                data[k] = {v.R, v.G, v.B}
            elseif typeof(v) == "UDim" then
                data[k] = v.Offset
            else
                data[k] = v
            end
        end
        pcall(function()
            write_file(self.ConfigName, httpSvc:JSONEncode(data))
        end)
    end
end
function Theme:Load()
    local env = getfenv()
    local read_file = env.readfile
    local is_file = env.isfile
    pcall(function()
        if not read_file and env.getgenv then
            read_file = env.getgenv().readfile
            is_file = env.getgenv().isfile
        end
    end)
    if read_file and is_file and is_file(self.ConfigName) then
        pcall(function()
            local data = httpSvc:JSONDecode(read_file(self.ConfigName))
            for k, v in pairs(data) do
                if self.Current[k] ~= nil then
                    if typeof(self.Current[k]) == "Color3" then
                        self.Current[k] = Color3.new(v[1], v[2], v[3])
                    elseif typeof(self.Current[k]) == "UDim" then
                        self.Current[k] = UDim.new(0, v)
                    else
                        self.Current[k] = v
                    end
                end
            end
            if self.Current.Accent then
                self.Current.TabSelected = self.Current.Accent
            end
        end)
    end
end
return Theme