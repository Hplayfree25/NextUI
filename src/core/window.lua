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
        
        -- ==========================================
        -- INTRO CINEMATIC SEQUENCE (NO BACKGROUND, MODERN)
        -- ==========================================
        local introBg = Instance.new("Frame")
        introBg.Size = UDim2.new(1, 0, 1, 0)
        introBg.Position = UDim2.new(0, 0, 0, 0)
        introBg.BackgroundTransparency = 1 -- Transparan 100%
        introBg.BorderSizePixel = 0
        introBg.ZIndex = 100
        introBg.Parent = screenGui
        
        -- Teks utama
        local introText = Instance.new("TextLabel")
        introText.Size = UDim2.new(1, 0, 0, 80)
        introText.Position = UDim2.new(0, 0, 0.6, 0) -- Mulai dari bawah
        introText.BackgroundTransparency = 1
        introText.Text = "NextUI"
        introText.Font = Enum.Font.GothamBlack
        introText.TextSize = 5 -- Mulai sangat kecil
        introText.TextColor3 = Color3.fromRGB(255, 255, 255)
        introText.TextTransparency = 1 -- Transparan
        introText.ZIndex = 102
        introText.Parent = introBg
        
        -- Teks bayangan (Glow effect)
        local glowText = Instance.new("TextLabel")
        glowText.Size = UDim2.new(1, 0, 0, 80)
        glowText.Position = UDim2.new(0, 0, 0.6, 0)
        glowText.BackgroundTransparency = 1
        glowText.Text = "NextUI"
        glowText.Font = Enum.Font.GothamBlack
        glowText.TextSize = 5
        glowText.TextColor3 = Theme.Accent -- Warna Blurple
        glowText.TextTransparency = 1
        glowText.ZIndex = 101
        glowText.Parent = introBg
        
        -- ==========================================
        -- MAIN WINDOW
        -- ==========================================
        local mainFrm = Instance.new("Frame")
        mainFrm.Size = UDim2.new(0, 550, 0, 380)
        mainFrm.Position = UDim2.new(0.5, -275, 1, 100) -- Mulai dari luar bawah layar
        mainFrm.BackgroundColor3 = Theme.Background
        mainFrm.BorderSizePixel = 0
        mainFrm.ClipsDescendants = true
        mainFrm.Parent = screenGui
        
        local mainCorner = Instance.new("UICorner")
        mainCorner.CornerRadius = Theme.CornerRadius
        mainCorner.Parent = mainFrm
        
        local topBar = Instance.new("Frame")
        topBar.Size = UDim2.new(1, 0, 0, 45)
        topBar.BackgroundColor3 = Theme.TopBar
        topBar.BorderSizePixel = 0
        topBar.Parent = mainFrm
        
        local titleLbl = Instance.new("TextLabel")
        titleLbl.Size = UDim2.new(1, -120, 1, 0)
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
        
        -- ==========================================
        -- WINDOW CONTROLS (Min, Max, Close)
        -- ==========================================
        local ctrlContainer = Instance.new("Frame")
        ctrlContainer.Size = UDim2.new(0, 90, 1, 0)
        ctrlContainer.Position = UDim2.new(1, -95, 0, 0)
        ctrlContainer.BackgroundTransparency = 1
        ctrlContainer.Parent = topBar
        
        local ctrlLayout = Instance.new("UIListLayout")
        ctrlLayout.FillDirection = Enum.FillDirection.Horizontal
        ctrlLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
        ctrlLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        ctrlLayout.Padding = UDim.new(0, 8)
        ctrlLayout.Parent = ctrlContainer
        
        local function createCtrlBtn(txt, hoverColor)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0, 24, 0, 24)
            btn.BackgroundColor3 = Theme.Background
            btn.Text = txt
            btn.TextColor3 = Theme.TextDim
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 12
            btn.AutoButtonColor = false
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(1, 0)
            corner.Parent = btn
            
            btn.MouseEnter:Connect(function()
                tweenSvc:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor, TextColor3 = Color3.fromRGB(255,255,255)}):Play()
            end)
            btn.MouseLeave:Connect(function()
                tweenSvc:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Background, TextColor3 = Theme.TextDim}):Play()
            end)
            return btn
        end
        
        local minBtn = createCtrlBtn("-", Color3.fromRGB(200, 150, 50))
        local maxBtn = createCtrlBtn("□", Color3.fromRGB(50, 200, 100))
        local closeBtn = createCtrlBtn("X", Color3.fromRGB(220, 50, 50))
        
        minBtn.Parent = ctrlContainer
        maxBtn.Parent = ctrlContainer
        closeBtn.Parent = ctrlContainer
        
        local isMinimized = false
        local isMaximized = false
        local oldSize = UDim2.new(0, 550, 0, 380)
        local oldPos = UDim2.new(0.5, -275, 0.5, -190)
        
        minBtn.MouseButton1Click:Connect(function()
            isMinimized = not isMinimized
            if isMinimized then
                tweenSvc:Create(mainFrm, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, mainFrm.Size.X.Offset, 0, 45)}):Play()
            else
                local targetSize = isMaximized and UDim2.new(1, 0, 1, 0) or oldSize
                tweenSvc:Create(mainFrm, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = targetSize}):Play()
            end
        end)
        
        maxBtn.MouseButton1Click:Connect(function()
            if isMinimized then return end
            isMaximized = not isMaximized
            if isMaximized then
                oldPos = mainFrm.Position
                tweenSvc:Create(mainFrm, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = UDim2.new(1, 0, 1, 0),
                    Position = UDim2.new(0, 0, 0, 0)
                }):Play()
                mainCorner.CornerRadius = UDim.new(0, 0)
            else
                tweenSvc:Create(mainFrm, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = oldSize,
                    Position = oldPos
                }):Play()
                mainCorner.CornerRadius = Theme.CornerRadius
            end
        end)
        
        closeBtn.MouseButton1Click:Connect(function()
            tweenSvc:Create(mainFrm, TweenInfo.new(0.3), {Size = UDim2.new(0, 550, 0, 0), Position = UDim2.new(0.5, -275, 0.5, 0)}):Play()
            task.wait(0.3)
            screenGui:Destroy()
        end)

        -- ==========================================
        -- CONTENT LAYOUT
        -- ==========================================
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
        
        -- ==========================================
        -- DRAG SYSTEM
        -- ==========================================
        local dragging, dragInput, dragStart, startPos
        local function update(input)
            if isMaximized then return end
            local delta = input.Position - dragStart
            mainFrm.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            oldPos = mainFrm.Position
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
        
        -- ==========================================
        -- JALANKAN ANIMASI INTRO & MUNCUL
        -- ==========================================
        task.spawn(function()
            -- 1. Animasi Slide Up + Elastic Membesar (Bounce)
            tweenSvc:Create(introText, TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                Position = UDim2.new(0, 0, 0.5, -40),
                TextSize = 75,
                TextTransparency = 0
            }):Play()
            
            tweenSvc:Create(glowText, TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                Position = UDim2.new(0, 0, 0.5, -40),
                TextSize = 80,
                TextTransparency = 0.6
            }):Play()
            
            task.wait(1.5)
            
            -- 2. Pulse / Berkedip berubah warna
            tweenSvc:Create(introText, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                TextColor3 = Theme.Accent,
                TextSize = 85
            }):Play()
            tweenSvc:Create(glowText, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                TextSize = 95,
                TextTransparency = 0.8
            }):Play()
            
            task.wait(0.4)
            
            -- 3. Mengecil tajam (Back) dan menghilang ke atas
            tweenSvc:Create(introText, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Position = UDim2.new(0, 0, 0.4, -100),
                TextSize = 0,
                TextTransparency = 1
            }):Play()
            tweenSvc:Create(glowText, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Position = UDim2.new(0, 0, 0.4, -100),
                TextSize = 0,
                TextTransparency = 1
            }):Play()
            
            task.wait(0.7)
            introBg:Destroy()
            
            -- 4. Luncurkan UI Utama dari bawah ke tengah
            tweenSvc:Create(mainFrm, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
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