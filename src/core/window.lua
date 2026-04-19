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
        
        -- Hapus GUI lama jika ada (Auto-Refresh)
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
        
        -- ==========================================
        -- INTRO CINEMATIC SEQUENCE
        -- ==========================================
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
        
        -- ==========================================
        -- MAIN WINDOW (CANVAS GROUP UNTUK FADE)
        -- ==========================================
        local mainFrm = Instance.new("CanvasGroup")
        mainFrm.Size = UDim2.new(0, 550, 0, 380)
        mainFrm.Position = UDim2.new(0.5, -275, 0.5, -170) -- Mulai agak ke bawah
        mainFrm.BackgroundColor3 = Theme.Background
        mainFrm.BackgroundTransparency = Theme.BackgroundTransparency
        mainFrm.BorderSizePixel = 0
        mainFrm.GroupTransparency = 1 -- Sembunyikan awal
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
        
        -- Garis vertikal tab
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
        
        -- Sistem Drag
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
        
        -- JALANKAN ANIMASI INTRO
        task.spawn(function()
            -- 1. Fade In SVFG & Scale
            tweenSvc:Create(introText, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
            tweenSvc:Create(introText, TweenInfo.new(2.5, Enum.EasingStyle.Linear), {TextSize = 48}):Play()
            task.wait(0.6)
            
            -- 2. Fade In NextUI
            tweenSvc:Create(introSubText, TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
            task.wait(1.5)
            
            -- 3. Fade Out Text
            tweenSvc:Create(introText, TweenInfo.new(0.5), {TextTransparency = 1, TextSize = 52}):Play()
            tweenSvc:Create(introSubText, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
            task.wait(0.3)
            
            -- 4. Fade Out Bg
            tweenSvc:Create(introBg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(0.5)
            introBg:Destroy()
            
            -- 5. Animasi Main UI Muncul (Fade + Slide Up)
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