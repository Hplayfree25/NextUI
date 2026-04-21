local tweenSvc = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
return function(Theme)
    local WindowLib = {}
    function WindowLib:Create(titleText)
        local winObj = {
            IsMaximized = false, 
            IsMinimized = false, 
            MaximizeEvent = Instance.new("BindableEvent"),
            OnAuthSuccess = Instance.new("BindableEvent"),
            MemberClass = "Unverified"
        }
        local guiParent = game:GetService("CoreGui")
        if not pcall(function() local _ = guiParent.Name end) then
            guiParent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        end
        for _, gui in pairs(guiParent:GetChildren()) do
            if gui.Name == "Vantix_Universal" then gui:Destroy() end
        end
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "Vantix_Universal"
        screenGui.ResetOnSpawn = false
        screenGui.IgnoreGuiInset = true
        screenGui.Enabled = false
        screenGui.Parent = guiParent
        local introBg = Instance.new("Frame")
        introBg.Size = UDim2.new(1, 0, 1, 0)
        introBg.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
        introBg.BackgroundTransparency = 0
        introBg.BorderSizePixel = 0
        introBg.ZIndex = 100
        introBg.Parent = screenGui
        local introText = Instance.new("TextLabel")
        introText.Size = UDim2.new(1, 0, 0, 80)
        introText.Position = UDim2.new(0, 0, 0.5, 20)
        introText.BackgroundTransparency = 1
        introText.Text = "Vantix UI"
        introText.Font = Enum.Font.GothamBlack
        introText.TextSize = 45
        introText.TextColor3 = Color3.fromRGB(255, 255, 255)
        introText.TextTransparency = 1
        introText.ZIndex = 102
        introText.Parent = introBg
        local glowText = Instance.new("TextLabel")
        glowText.Size = UDim2.new(1, 0, 0, 80)
        glowText.Position = UDim2.new(0, 0, 0.5, 20)
        glowText.BackgroundTransparency = 1
        glowText.Text = "Vantix UI"
        glowText.Font = Enum.Font.GothamBlack
        glowText.TextSize = 45
        Theme:Apply(glowText, {TextColor3 = "Accent"})
        glowText.TextTransparency = 1
        glowText.ZIndex = 101
        glowText.Parent = introBg
        local mainFrm = Instance.new("Frame")
        mainFrm.Size = UDim2.new(0, 550, 0, 380)
        mainFrm.AnchorPoint = Vector2.new(0.5, 0.5)
        mainFrm.Position = UDim2.new(0.5, 0, 1.5, 0)
        Theme:Apply(mainFrm, {BackgroundColor3 = "Background", BackgroundTransparency = "BackgroundTransparency"})
        mainFrm.BorderSizePixel = 0
        mainFrm.ClipsDescendants = false
        mainFrm.Parent = screenGui
        local mainCorner = Instance.new("UICorner")
        Theme:Apply(mainCorner, {CornerRadius = "CornerRadius"})
        mainCorner.Parent = mainFrm
        local uiScale = Instance.new("UIScale")
        uiScale.Scale = 1
        uiScale.Parent = mainFrm
        local topBar = Instance.new("Frame")
        topBar.Size = UDim2.new(1, 0, 0, 45)
        Theme:Apply(topBar, {BackgroundColor3 = "TopBar", BackgroundTransparency = "TopBarTransparency"})
        topBar.BorderSizePixel = 0
        topBar.Parent = mainFrm
        local topBarCorner = Instance.new("UICorner")
        Theme:Apply(topBarCorner, {CornerRadius = "CornerRadius"})
        topBarCorner.Parent = topBar
        local topBarPatch = Instance.new("Frame")
        topBarPatch.Size = UDim2.new(1, 0, 0, 10)
        topBarPatch.Position = UDim2.new(0, 0, 1, -10)
        Theme:Apply(topBarPatch, {BackgroundColor3 = "TopBar", BackgroundTransparency = "TopBarTransparency"})
        topBarPatch.BorderSizePixel = 0
        topBarPatch.Parent = topBar
        local logoBtn = Instance.new("TextLabel")
        logoBtn.Size = UDim2.new(0, 45, 0, 45)
        logoBtn.BackgroundTransparency = 1
        logoBtn.Text = "N"
        logoBtn.Font = Enum.Font.GothamBlack
        logoBtn.TextSize = 22
        Theme:Apply(logoBtn, {TextColor3 = "Accent"})
        logoBtn.Parent = topBar
        local titleLbl = Instance.new("TextLabel")
        titleLbl.Size = UDim2.new(1, -150, 1, 0)
        titleLbl.Position = UDim2.new(0, 40, 0, 0)
        titleLbl.BackgroundTransparency = 1
        titleLbl.Text = titleText
        Theme:Apply(titleLbl, {TextColor3 = "TextMain"})
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Font = Enum.Font.GothamBold
        titleLbl.TextSize = 15
        titleLbl.Parent = topBar
        local ctrlContainer = Instance.new("Frame")
        ctrlContainer.Size = UDim2.new(0, 100, 1, 0)
        ctrlContainer.Position = UDim2.new(1, -105, 0, 0)
        ctrlContainer.BackgroundTransparency = 1
        ctrlContainer.Parent = topBar
        local ctrlLayout = Instance.new("UIListLayout")
        ctrlLayout.FillDirection = Enum.FillDirection.Horizontal
        ctrlLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
        ctrlLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        ctrlLayout.Padding = UDim.new(0, 8)
        ctrlLayout.Parent = ctrlContainer
        local function createMacBtn(color, iconText)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0, 14, 0, 14)
            btn.BackgroundColor3 = color
            btn.Text = ""
            btn.AutoButtonColor = false
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(1, 0)
            corner.Parent = btn
            local icon = Instance.new("TextLabel")
            icon.Size = UDim2.new(1, 0, 1, 0)
            icon.BackgroundTransparency = 1
            icon.Text = iconText
            icon.TextColor3 = Color3.fromRGB(50, 50, 50)
            icon.TextTransparency = 1
            icon.Font = Enum.Font.GothamBold
            icon.TextSize = 10
            icon.Parent = btn
            btn.MouseEnter:Connect(function() tweenSvc:Create(icon, TweenInfo.new(0.2), {TextTransparency = 0.3}):Play() end)
            btn.MouseLeave:Connect(function() tweenSvc:Create(icon, TweenInfo.new(0.2), {TextTransparency = 1}):Play() end)
            return btn
        end
        local minBtn = createMacBtn(Color3.fromRGB(255, 189, 46), "−")
        local maxBtn = createMacBtn(Color3.fromRGB(39, 201, 63), "＋")
        local closeBtn = createMacBtn(Color3.fromRGB(255, 95, 86), "✕")
        minBtn.LayoutOrder = 1
        maxBtn.LayoutOrder = 2
        closeBtn.LayoutOrder = 3
        minBtn.Parent = ctrlContainer
        maxBtn.Parent = ctrlContainer
        closeBtn.Parent = ctrlContainer
        local minLogo = Instance.new("TextButton")
        minLogo.Size = UDim2.new(0, 50, 0, 50)
        minLogo.AnchorPoint = Vector2.new(0.5, 0.5)
        Theme:Apply(minLogo, {BackgroundColor3 = "Background", TextColor3 = "Accent", BackgroundTransparency = "BackgroundTransparency"})
        minLogo.Text = "N"
        minLogo.Font = Enum.Font.GothamBlack
        minLogo.TextSize = 25
        minLogo.Visible = false
        minLogo.AutoButtonColor = false
        minLogo.Parent = screenGui
        local minLogoCorner = Instance.new("UICorner")
        minLogoCorner.CornerRadius = UDim.new(1, 0)
        minLogoCorner.Parent = minLogo
        local minLogoStroke = Instance.new("UIStroke")
        Theme:Apply(minLogoStroke, {Color = "Accent"})
        minLogoStroke.Thickness = 2
        minLogoStroke.Parent = minLogo
        local minLogoScale = Instance.new("UIScale")
        minLogoScale.Scale = 0
        minLogoScale.Parent = minLogo
        local oldSize = UDim2.new(0, 550, 0, 380)
        local oldPos = UDim2.new(0.5, 0, 0.5, 0)
        minBtn.MouseButton1Click:Connect(function()
            if winObj.IsMinimized then return end
            winObj.IsMinimized = true
            local viewport = workspace.CurrentCamera.ViewportSize
            local halfSize = 25
            local centerX = mainFrm.AbsolutePosition.X + (mainFrm.AbsoluteSize.X / 2)
            local centerY = mainFrm.AbsolutePosition.Y + (mainFrm.AbsoluteSize.Y / 2)
            local safeX = math.clamp(centerX, halfSize, viewport.X - halfSize)
            local safeY = math.clamp(centerY, halfSize, viewport.Y - halfSize)
            minLogo.Position = UDim2.new(0, safeX, 0, safeY)
            minLogo.Visible = true
            tweenSvc:Create(uiScale, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0}):Play()
            task.wait(0.2)
            tweenSvc:Create(minLogoScale, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Scale = 1}):Play()
            task.wait(0.2)
            mainFrm.Visible = false
        end)
        local function unminimize()
            local targetSize = winObj.IsMaximized and UDim2.new(1, 0, 1, 0) or oldSize
            local viewport = workspace.CurrentCamera.ViewportSize
            local halfWidth = targetSize.X.Offset / 2
            if targetSize.X.Scale == 1 then halfWidth = viewport.X / 2 end
            local halfHeight = targetSize.Y.Offset / 2
            if targetSize.Y.Scale == 1 then halfHeight = viewport.Y / 2 end
            local safeX = math.clamp(minLogo.AbsolutePosition.X + (minLogo.AbsoluteSize.X / 2), halfWidth, viewport.X - halfWidth)
            local safeY = math.clamp(minLogo.AbsolutePosition.Y + (minLogo.AbsoluteSize.Y / 2), halfHeight, viewport.Y - halfHeight)
            mainFrm.Position = UDim2.new(0, safeX, 0, safeY)
            mainFrm.Visible = true
            tweenSvc:Create(minLogoScale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0}):Play()
            task.wait(0.15)
            tweenSvc:Create(uiScale, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Scale = 1}):Play()
            task.wait(0.15)
            minLogo.Visible = false
            winObj.IsMinimized = false
        end
        maxBtn.MouseButton1Click:Connect(function()
            if winObj.IsMinimized then return end
            winObj.IsMaximized = not winObj.IsMaximized
            if winObj.IsMaximized then
                oldPos = mainFrm.Position
                tweenSvc:Create(mainFrm, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
                tweenSvc:Create(mainCorner, TweenInfo.new(0.3), {CornerRadius = UDim.new(0, 0)}):Play()
                tweenSvc:Create(topBarCorner, TweenInfo.new(0.3), {CornerRadius = UDim.new(0, 0)}):Play()
                topBarPatch.Visible = false
            else
                tweenSvc:Create(mainFrm, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = oldSize, Position = oldPos}):Play()
                tweenSvc:Create(mainCorner, TweenInfo.new(0.3), {CornerRadius = Theme.Current.CornerRadius}):Play()
                tweenSvc:Create(topBarCorner, TweenInfo.new(0.3), {CornerRadius = Theme.Current.CornerRadius}):Play()
                topBarPatch.Visible = true
            end
            winObj.MaximizeEvent:Fire(winObj.IsMaximized)
        end)
        closeBtn.MouseButton1Click:Connect(function()
            tweenSvc:Create(uiScale, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0}):Play()
            task.wait(0.4)
            screenGui:Destroy()
        end)
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
        local contentContainer = Instance.new("Frame")
        contentContainer.Size = UDim2.new(1, -150, 1, -45)
        contentContainer.Position = UDim2.new(0, 150, 0, 45)
        contentContainer.BackgroundTransparency = 1
        contentContainer.Parent = mainFrm
        local dragging = false
        local dragStart, startPos
        topBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = mainFrm.Position
            end
        end)
        topBar.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        uis.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                if dragging and not winObj.IsMaximized then
                    local delta = input.Position - dragStart
                    mainFrm.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                end
            end
        end)
        local minDragging = false
        local minHasDragged = false
        local minDragStart, minStartPos
        minLogo.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                minDragging = true
                minHasDragged = false
                minDragStart = input.Position
                minStartPos = minLogo.Position
            end
        end)
        minLogo.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                minDragging = false
            end
        end)
        uis.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                if minDragging and minDragStart then
                    local delta = input.Position - minDragStart
                    if delta.Magnitude > 5 then
                        minHasDragged = true
                        local viewport = workspace.CurrentCamera.ViewportSize
                        local halfSize = 25
                        local rawX = minStartPos.X.Offset + delta.X
                        local rawY = minStartPos.Y.Offset + delta.Y
                        local safeX = math.clamp(rawX, halfSize, viewport.X - halfSize)
                        local safeY = math.clamp(rawY, halfSize, viewport.Y - halfSize)
                        minLogo.Position = UDim2.new(0, safeX, 0, safeY)
                    end
                end
            end
        end)
        minLogo.MouseButton1Click:Connect(function()
            if not minHasDragged then unminimize() end
        end)
        function winObj:PlayIntro()
            screenGui.Enabled = true
            task.spawn(function()
                -- Cinematic reveal: Slow fade and slide up
                tweenSvc:Create(introText, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0.5, -40), TextSize = 55, TextTransparency = 0}):Play()
                tweenSvc:Create(glowText, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0.5, -40), TextSize = 60, TextTransparency = 0.4}):Play()
                task.wait(1.2)

                -- Pulse effect: Expand slightly with color change
                tweenSvc:Create(introText, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextColor3 = Theme.Current.Accent, TextSize = 65}):Play()
                tweenSvc:Create(glowText, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextSize = 75, TextTransparency = 0.1}):Play()
                task.wait(0.9)

                -- Dramatic collapse inward with rotation
                tweenSvc:Create(introText, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {TextSize = 0, TextTransparency = 1, Rotation = 5}):Play()
                tweenSvc:Create(glowText, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {TextSize = 0, TextTransparency = 1, Rotation = -5}):Play()
                task.wait(0.4)

                -- Screen fade out (dissolving the dark background)
                tweenSvc:Create(introBg, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                task.wait(0.2)

                -- Main window pops up
                tweenSvc:Create(mainFrm, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
                task.wait(0.4)
                introBg:Destroy()
            end)
        end
        winObj.Container = contentContainer
        winObj.TabContainer = tabContainer
        winObj.ScreenGui = screenGui
        return winObj
    end
    return WindowLib
end