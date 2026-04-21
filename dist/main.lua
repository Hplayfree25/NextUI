
local UILib = {}

local Theme = (function()
local Theme = {
    Background = Color3.fromRGB(18, 18, 24), 
    BackgroundTransparency = 0.02,
    
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
}

return Theme
end)()

local WindowConstructor = (function()
local tweenSvc = game:GetService("TweenService")
local uis = game:GetService("UserInputService")

return function(Theme)
    local WindowLib = {}
    
    function WindowLib:Create(titleText)
        local winObj = {}
        
        local guiParent = game:GetService("CoreGui")
        if not pcall(function() local _ = guiParent.Name end) then
            guiParent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        end
        
        
        for _, gui in pairs(guiParent:GetChildren()) do
            if gui.Name == "NextUI_Universal" then
                gui:Destroy()
            end
        end
        
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "NextUI_Universal"
        screenGui.ResetOnSpawn = false
        screenGui.IgnoreGuiInset = true
        screenGui.Parent = guiParent
        
        
        
        
        local introBg = Instance.new("Frame")
        introBg.Size = UDim2.new(1, 0, 1, 0)
        introBg.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
        introBg.ZIndex = 100
        introBg.Parent = screenGui
        
        local introContainer = Instance.new("Frame")
        introContainer.Size = UDim2.new(1, 0, 1, 0)
        introContainer.BackgroundTransparency = 1
        introContainer.ZIndex = 101
        introContainer.Parent = introBg
        
        local introList = Instance.new("UIListLayout")
        introList.HorizontalAlignment = Enum.HorizontalAlignment.Center
        introList.VerticalAlignment = Enum.VerticalAlignment.Center
        introList.SortOrder = Enum.SortOrder.LayoutOrder
        introList.Padding = UDim.new(0, 5)
        introList.Parent = introContainer
        
        local introText = Instance.new("TextLabel")
        introText.Size = UDim2.new(1, 0, 0, 50)
        introText.BackgroundTransparency = 1
        introText.Text = "SVFG"
        introText.Font = Enum.Font.GothamBlack
        introText.TextSize = 45
        introText.TextColor3 = Color3.fromRGB(255, 255, 255)
        introText.TextTransparency = 1
        introText.Parent = introContainer
        
        local introSubText = Instance.new("TextLabel")
        introSubText.Size = UDim2.new(1, 0, 0, 30)
        introSubText.BackgroundTransparency = 1
        introSubText.Text = "NextUI"
        introSubText.Font = Enum.Font.GothamMedium
        introSubText.TextSize = 22
        introSubText.TextColor3 = Theme.Accent
        introSubText.TextTransparency = 1
        introSubText.Parent = introContainer
        
        
        
        
        local mainFrm = Instance.new("CanvasGroup")
        mainFrm.Size = UDim2.new(0, 550, 0, 380)
        mainFrm.Position = UDim2.new(0.5, -275, 0.5, -170) 
        mainFrm.BackgroundColor3 = Theme.Background
        mainFrm.BackgroundTransparency = Theme.BackgroundTransparency
        mainFrm.BorderSizePixel = 0
        mainFrm.GroupTransparency = 1 
        mainFrm.Parent = screenGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = Theme.CornerRadius
        corner.Parent = mainFrm
        
        local topBar = Instance.new("Frame")
        topBar.Size = UDim2.new(1, 0, 0, 45)
        topBar.BackgroundColor3 = Theme.TopBar
        topBar.BackgroundTransparency = Theme.TopBarTransparency
        topBar.BorderSizePixel = 0
        topBar.Parent = mainFrm
        
        local titleLbl = Instance.new("TextLabel")
        titleLbl.Size = UDim2.new(1, -20, 1, 0)
        titleLbl.Position = UDim2.new(0, 20, 0, 0)
        titleLbl.BackgroundTransparency = 1
        titleLbl.Text = titleText
        titleLbl.TextColor3 = Theme.TextMain
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Font = Enum.Font.GothamBold
        titleLbl.TextSize = 15
        titleLbl.Parent = topBar
        
        local separator = Instance.new("Frame")
        separator.Size = UDim2.new(1, 0, 0, 1)
        separator.Position = UDim2.new(0, 0, 1, -1)
        separator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        separator.BackgroundTransparency = 0.92
        separator.BorderSizePixel = 0
        separator.Parent = topBar
        
        local tabContainer = Instance.new("ScrollingFrame")
        tabContainer.Size = UDim2.new(0, 150, 1, -45)
        tabContainer.Position = UDim2.new(0, 0, 0, 45)
        tabContainer.BackgroundTransparency = 1
        tabContainer.ScrollBarThickness = 0
        tabContainer.Parent = mainFrm
        
        local tabListLayout = Instance.new("UIListLayout")
        tabListLayout.Padding = UDim.new(0, 8)
        tabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        tabListLayout.Parent = tabContainer
        
        local tabPadding = Instance.new("UIPadding")
        tabPadding.PaddingTop = UDim.new(0, 15)
        tabPadding.PaddingLeft = UDim.new(0, 12)
        tabPadding.PaddingRight = UDim.new(0, 12)
        tabPadding.Parent = tabContainer
        
        
        local vSeparator = Instance.new("Frame")
        vSeparator.Size = UDim2.new(0, 1, 1, -45)
        vSeparator.Position = UDim2.new(0, 150, 0, 45)
        vSeparator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        vSeparator.BackgroundTransparency = 0.92
        vSeparator.BorderSizePixel = 0
        vSeparator.Parent = mainFrm
        
        local contentContainer = Instance.new("Frame")
        contentContainer.Size = UDim2.new(1, -151, 1, -45)
        contentContainer.Position = UDim2.new(0, 151, 0, 45)
        contentContainer.BackgroundTransparency = 1
        contentContainer.Parent = mainFrm
        
        
        local dragging, dragInput, dragStart, startPos
        local function update(input)
            local delta = input.Position - dragStart
            mainFrm.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
        
        topBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = mainFrm.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        
        topBar.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        
        uis.InputChanged:Connect(function(input)
            if input == dragInput and dragging then update(input) end
        end)
        
        
        task.spawn(function()
            
            tweenSvc:Create(introText, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
            tweenSvc:Create(introText, TweenInfo.new(2.5, Enum.EasingStyle.Linear), {TextSize = 48}):Play()
            task.wait(0.6)
            
            
            tweenSvc:Create(introSubText, TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
            task.wait(1.5)
            
            
            tweenSvc:Create(introText, TweenInfo.new(0.5), {TextTransparency = 1, TextSize = 52}):Play()
            tweenSvc:Create(introSubText, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
            task.wait(0.3)
            
            
            tweenSvc:Create(introBg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(0.5)
            introBg:Destroy()
            
            
            tweenSvc:Create(mainFrm, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                GroupTransparency = 0,
                Position = UDim2.new(0.5, -275, 0.5, -190)
            }):Play()
        end)
        
        winObj.Container = contentContainer
        winObj.TabContainer = tabContainer
        winObj.ScreenGui = screenGui
        
        return winObj
    end
    
    return WindowLib
end
end)()

local TabConstructor = (function()
local tweenSvc = game:GetService("TweenService")

return function(Theme)
    local TabLib = {}
    
    function TabLib:Create(winObj, tabName)
        local tabObj = {}
        
        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(1, 0, 0, 36)
        tabBtn.BackgroundColor3 = Theme.TabUnselected
        tabBtn.Text = tabName
        tabBtn.TextColor3 = Theme.TextDim
        tabBtn.Font = Enum.Font.GothamSemibold
        tabBtn.TextSize = 13
        tabBtn.AutoButtonColor = false
        tabBtn.Parent = winObj.TabContainer
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = Theme.CornerRadius
        corner.Parent = tabBtn
        
        local tabPage = Instance.new("ScrollingFrame")
        tabPage.Size = UDim2.new(1, 0, 1, 0)
        tabPage.BackgroundTransparency = 1
        tabPage.ScrollBarThickness = 2
        tabPage.Visible = false
        tabPage.Parent = winObj.Container
        
        local listLayout = Instance.new("UIListLayout")
        listLayout.Padding = UDim.new(0, 8)
        listLayout.SortOrder = Enum.SortOrder.LayoutOrder
        listLayout.Parent = tabPage
        
        local tabPadding = Instance.new("UIPadding")
        tabPadding.PaddingTop = UDim.new(0, 15)
        tabPadding.PaddingLeft = UDim.new(0, 15)
        tabPadding.PaddingRight = UDim.new(0, 15)
        tabPadding.PaddingBottom = UDim.new(0, 15)
        tabPadding.Parent = tabPage
        
        tabBtn.MouseButton1Click:Connect(function()
            for _, child in pairs(winObj.Container:GetChildren()) do
                if child:IsA("ScrollingFrame") then child.Visible = false end
            end
            for _, child in pairs(winObj.TabContainer:GetChildren()) do
                if child:IsA("TextButton") then
                    tweenSvc:Create(child, TweenInfo.new(0.2), {
                        BackgroundColor3 = Theme.TabUnselected,
                        TextColor3 = Theme.TextDim
                    }):Play()
                end
            end
            
            tabPage.Visible = true
            tweenSvc:Create(tabBtn, TweenInfo.new(0.2), {
                BackgroundColor3 = Theme.TabSelected,
                TextColor3 = Theme.TextMain
            }):Play()
        end)
        
        local tabCount = 0
        for _, child in pairs(winObj.TabContainer:GetChildren()) do
            if child:IsA("TextButton") then tabCount = tabCount + 1 end
        end
        
        if tabCount == 1 then
            tabPage.Visible = true
            tabBtn.BackgroundColor3 = Theme.TabSelected
            tabBtn.TextColor3 = Theme.TextMain
        end
        
        tabObj.Page = tabPage
        return tabObj
    end
    
    return TabLib
end
end)()

local ButtonConstructor = (function()
local tweenSvc = game:GetService("TweenService")

return function(Theme)
    return function(tabObj, text, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 42)
        btn.BackgroundColor3 = Theme.ElementBg
        btn.Text = text
        btn.TextColor3 = Theme.TextDim
        btn.Font = Enum.Font.GothamSemibold
        btn.TextSize = 13
        btn.AutoButtonColor = false
        btn.Parent = tabObj.Page
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = Theme.CornerRadius
        corner.Parent = btn
        
        btn.MouseEnter:Connect(function()
            tweenSvc:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.ElementHover, TextColor3 = Theme.TextMain}):Play()
        end)
        
        btn.MouseLeave:Connect(function()
            tweenSvc:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.ElementBg, TextColor3 = Theme.TextDim}):Play()
        end)
        
        btn.MouseButton1Down:Connect(function()
            tweenSvc:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Theme.ElementClick}):Play()
            tweenSvc:Create(btn.UICorner, TweenInfo.new(0.1), {CornerRadius = UDim.new(0, 12)}):Play()
        end)
        
        btn.MouseButton1Up:Connect(function()
            tweenSvc:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Theme.ElementHover}):Play()
            tweenSvc:Create(btn.UICorner, TweenInfo.new(0.1), {CornerRadius = Theme.CornerRadius}):Play()
        end)

        btn.MouseButton1Click:Connect(function()
            local s, e = pcall(callback)
            if not s then warn("UI Button Error: " .. tostring(e)) end
        end)
    end
end
end)()

local ToggleConstructor = (function()
local tweenSvc = game:GetService("TweenService")

return function(Theme)
    return function(tabObj, text, default, callback)
        local toggled = default or false
        
        local toggleFrm = Instance.new("TextButton")
        toggleFrm.Size = UDim2.new(1, 0, 0, 42)
        toggleFrm.BackgroundColor3 = Theme.ElementBg
        toggleFrm.Text = ""
        toggleFrm.AutoButtonColor = false
        toggleFrm.Parent = tabObj.Page
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = Theme.CornerRadius
        corner.Parent = toggleFrm
        
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -60, 1, 0)
        lbl.Position = UDim2.new(0, 15, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = Theme.TextDim
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Font = Enum.Font.GothamSemibold
        lbl.TextSize = 13
        lbl.Parent = toggleFrm
        
        
        local indicatorBg = Instance.new("Frame")
        indicatorBg.Size = UDim2.new(0, 42, 0, 22)
        indicatorBg.Position = UDim2.new(1, -55, 0.5, -11)
        indicatorBg.BackgroundColor3 = toggled and Theme.Accent or Theme.Background
        indicatorBg.Parent = toggleFrm
        local iCorner = Instance.new("UICorner")
        iCorner.CornerRadius = UDim.new(1, 0)
        iCorner.Parent = indicatorBg
        
        local indicator = Instance.new("Frame")
        indicator.Size = UDim2.new(0, 18, 0, 18)
        indicator.Position = toggled and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
        indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        indicator.Parent = indicatorBg
        local iiCorner = Instance.new("UICorner")
        iiCorner.CornerRadius = UDim.new(1, 0)
        iiCorner.Parent = indicator
        
        local function Fire()
            toggled = not toggled
            tweenSvc:Create(indicator, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = toggled and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
            }):Play()
            tweenSvc:Create(indicatorBg, TweenInfo.new(0.2), {
                BackgroundColor3 = toggled and Theme.Accent or Theme.Background
            }):Play()
            tweenSvc:Create(lbl, TweenInfo.new(0.2), {TextColor3 = toggled and Theme.TextMain or Theme.TextDim}):Play()
            
            local s, e = pcall(callback, toggled)
            if not s then warn("UI Toggle Error: " .. tostring(e)) end
        end
        
        toggleFrm.MouseButton1Click:Connect(Fire)
        
        if toggled then
            lbl.TextColor3 = Theme.TextMain
        end
    end
end
end)()

local SliderConstructor = (function()
local tweenSvc = game:GetService("TweenService")
local uis = game:GetService("UserInputService")

return function(Theme)
    return function(tabObj, text, min, max, default, callback)
        local value = default or min
        
        local sliderFrm = Instance.new("Frame")
        sliderFrm.Size = UDim2.new(1, 0, 0, 55)
        sliderFrm.BackgroundColor3 = Theme.ElementBg
        sliderFrm.Parent = tabObj.Page
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = Theme.CornerRadius
        corner.Parent = sliderFrm
        
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -20, 0, 25)
        lbl.Position = UDim2.new(0, 15, 0, 5)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = Theme.TextDim
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Font = Enum.Font.GothamSemibold
        lbl.TextSize = 13
        lbl.Parent = sliderFrm
        
        local valLbl = Instance.new("TextLabel")
        valLbl.Size = UDim2.new(0, 50, 0, 25)
        valLbl.Position = UDim2.new(1, -65, 0, 5)
        valLbl.BackgroundTransparency = 1
        valLbl.Text = tostring(value)
        valLbl.TextColor3 = Theme.TextMain
        valLbl.TextXAlignment = Enum.TextXAlignment.Right
        valLbl.Font = Enum.Font.GothamSemibold
        valLbl.TextSize = 13
        valLbl.Parent = sliderFrm
        
        local sliderBg = Instance.new("Frame")
        sliderBg.Size = UDim2.new(1, -30, 0, 8)
        sliderBg.Position = UDim2.new(0, 15, 0, 36)
        sliderBg.BackgroundColor3 = Theme.Background
        sliderBg.Parent = sliderFrm
        local bgCorner = Instance.new("UICorner")
        bgCorner.CornerRadius = UDim.new(1, 0)
        bgCorner.Parent = sliderBg
        
        local sliderFill = Instance.new("Frame")
        sliderFill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
        sliderFill.BackgroundColor3 = Theme.Accent
        sliderFill.Parent = sliderBg
        local fillCorner = Instance.new("UICorner")
        fillCorner.CornerRadius = UDim.new(1, 0)
        fillCorner.Parent = sliderFill
        
        
        local thumb = Instance.new("Frame")
        thumb.Size = UDim2.new(0, 14, 0, 14)
        thumb.Position = UDim2.new(1, -7, 0.5, -7)
        thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        thumb.Parent = sliderFill
        local thumbCorner = Instance.new("UICorner")
        thumbCorner.CornerRadius = UDim.new(1, 0)
        thumbCorner.Parent = thumb
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.Position = UDim2.new(0, 0, -1, 0)
        btn.Size = UDim2.new(1, 0, 3, 0) 
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.Parent = sliderBg
        
        local dragging = false
        
        local function update(input)
            local sizeX = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
            value = math.floor(min + ((max - min) * sizeX))
            
            valLbl.Text = tostring(value)
            tweenSvc:Create(sliderFill, TweenInfo.new(0.1), {Size = UDim2.new(sizeX, 0, 1, 0)}):Play()
            
            local s, e = pcall(callback, value)
            if not s then warn("UI Slider Error: " .. tostring(e)) end
        end
        
        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                tweenSvc:Create(thumb, TweenInfo.new(0.1), {Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(1, -9, 0.5, -9)}):Play()
                update(input)
            end
        end)
        
        btn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
                tweenSvc:Create(thumb, TweenInfo.new(0.1), {Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(1, -7, 0.5, -7)}):Play()
            end
        end)
        
        uis.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                update(input)
            end
        end)
    end
end
end)()

local DropdownConstructor = (function()
local tweenSvc = game:GetService("TweenService")

return function(Theme)
    return function(tabObj, text, options, callback)
        local dropdownFrm = Instance.new("Frame")
        dropdownFrm.Size = UDim2.new(1, 0, 0, 42)
        dropdownFrm.BackgroundColor3 = Theme.ElementBg
        dropdownFrm.ClipsDescendants = true
        dropdownFrm.Parent = tabObj.Page
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = Theme.CornerRadius
        corner.Parent = dropdownFrm
        
        local mainBtn = Instance.new("TextButton")
        mainBtn.Size = UDim2.new(1, 0, 0, 42)
        mainBtn.BackgroundTransparency = 1
        mainBtn.Text = ""
        mainBtn.Parent = dropdownFrm
        
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -40, 1, 0)
        lbl.Position = UDim2.new(0, 15, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text .. " : " .. tostring(options[1] or "")
        lbl.TextColor3 = Theme.TextDim
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Font = Enum.Font.GothamSemibold
        lbl.TextSize = 13
        lbl.Parent = mainBtn
        
        local icon = Instance.new("TextLabel")
        icon.Size = UDim2.new(0, 20, 1, 0)
        icon.Position = UDim2.new(1, -30, 0, 0)
        icon.BackgroundTransparency = 1
        icon.Text = "+"
        icon.TextColor3 = Theme.TextDim
        icon.Font = Enum.Font.GothamBold
        icon.TextSize = 14
        icon.Parent = mainBtn
        
        local listFrm = Instance.new("Frame")
        listFrm.Size = UDim2.new(1, -20, 0, 0)
        listFrm.Position = UDim2.new(0, 10, 0, 45)
        listFrm.BackgroundTransparency = 1
        listFrm.Parent = dropdownFrm
        
        local listLayout = Instance.new("UIListLayout")
        listLayout.Padding = UDim.new(0, 4)
        listLayout.SortOrder = Enum.SortOrder.LayoutOrder
        listLayout.Parent = listFrm
        
        local isOpen = false
        
        mainBtn.MouseButton1Click:Connect(function()
            isOpen = not isOpen
            local listSize = listLayout.AbsoluteContentSize.Y
            tweenSvc:Create(dropdownFrm, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, isOpen and (55 + listSize) or 42)}):Play()
            icon.Text = isOpen and "-" or "+"
            tweenSvc:Create(lbl, TweenInfo.new(0.2), {TextColor3 = isOpen and Theme.TextMain or Theme.TextDim}):Play()
        end)
        
        for _, opt in ipairs(options) do
            local optBtn = Instance.new("TextButton")
            optBtn.Size = UDim2.new(1, 0, 0, 30)
            optBtn.BackgroundColor3 = Theme.Background
            optBtn.BackgroundTransparency = 0.5
            optBtn.Text = tostring(opt)
            optBtn.TextColor3 = Theme.TextDim
            optBtn.Font = Enum.Font.Gotham
            optBtn.TextSize = 12
            optBtn.AutoButtonColor = false
            optBtn.Parent = listFrm
            
            local optCorner = Instance.new("UICorner")
            optCorner.CornerRadius = UDim.new(0, 6)
            optCorner.Parent = optBtn
            
            optBtn.MouseEnter:Connect(function()
                tweenSvc:Create(optBtn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.ElementHover, TextColor3 = Theme.TextMain}):Play()
            end)
            
            optBtn.MouseLeave:Connect(function()
                tweenSvc:Create(optBtn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Background, TextColor3 = Theme.TextDim}):Play()
            end)
            
            optBtn.MouseButton1Click:Connect(function()
                lbl.Text = text .. " : " .. tostring(opt)
                isOpen = false
                tweenSvc:Create(dropdownFrm, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 42)}):Play()
                icon.Text = "+"
                tweenSvc:Create(lbl, TweenInfo.new(0.2), {TextColor3 = Theme.TextDim}):Play()
                
                local s, e = pcall(callback, opt)
                if not s then warn("UI Dropdown Error: " .. tostring(e)) end
            end)
        end
    end
end
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
