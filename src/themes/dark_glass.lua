local Theme = {
    Background = Color3.fromRGB(18, 18, 24), -- Slack-like modern dark
    BackgroundTransparency = 0, -- Diubah ke 0 agar tidak transparan/buggy
    
    TopBar = Color3.fromRGB(24, 24, 32),
    TopBarTransparency = 0,
    
    TabUnselected = Color3.fromRGB(24, 24, 32),
    TabSelected = Color3.fromRGB(88, 101, 242), -- Blurple
    
    ElementBg = Color3.fromRGB(28, 28, 38),
    ElementHover = Color3.fromRGB(38, 38, 50),
    ElementClick = Color3.fromRGB(20, 20, 28),

    TextMain = Color3.fromRGB(255, 255, 255),
    TextDim = Color3.fromRGB(160, 160, 170),
    
    Accent = Color3.fromRGB(88, 101, 242),
    
    CornerRadius = UDim.new(0, 8)
}

return Theme