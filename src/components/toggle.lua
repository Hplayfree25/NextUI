local tweenSvc = game:GetService("TweenService")

return function(Theme)
    return function(tabObj, text, default, callback)
        local toggled = default or false
        
        local toggleFrm = Instance.new("TextButton")
        toggleFrm.Size = UDim2.new(1, 0, 0, 42)
        toggleFrm.BackgroundColor3 = Theme.ElementBg
        toggleFrm.Text = ""
        toggleFrm.AutoButtonColor = false
        
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
        
        tabObj:AddElement(toggleFrm)
    end
end