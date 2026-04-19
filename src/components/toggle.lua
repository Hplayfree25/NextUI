local tweenSvc = game:GetService("TweenService")
return function(Theme)
    return function(tabObj, text, default, callback)
        local toggled = default or false
        local toggleFrm = Instance.new("TextButton")
        toggleFrm.Size = UDim2.new(1, 0, 0, 42)
        Theme:Apply(toggleFrm, {BackgroundColor3 = "ElementBg"})
        toggleFrm.Text = ""
        toggleFrm.AutoButtonColor = false
        local corner = Instance.new("UICorner")
        Theme:Apply(corner, {CornerRadius = "CornerRadius"})
        corner.Parent = toggleFrm
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -60, 1, 0)
        lbl.Position = UDim2.new(0, 15, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        Theme:Apply(lbl, {TextColor3 = "TextDim"})
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Font = Enum.Font.GothamSemibold
        lbl.TextSize = 13
        lbl.Parent = toggleFrm
        local indicatorBg = Instance.new("Frame")
        indicatorBg.Size = UDim2.new(0, 42, 0, 22)
        indicatorBg.Position = UDim2.new(1, -55, 0.5, -11)
        indicatorBg.BackgroundColor3 = toggled and Theme.Current.Accent or Theme.Current.Background
        table.insert(Theme.Objects, {Obj = indicatorBg, Prop = "BackgroundColor3", Key = toggled and "Accent" or "Background"})
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
            tweenSvc:Create(indicator, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = toggled and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)}):Play()
            tweenSvc:Create(indicatorBg, TweenInfo.new(0.2), {BackgroundColor3 = toggled and Theme.Current.Accent or Theme.Current.Background}):Play()
            tweenSvc:Create(lbl, TweenInfo.new(0.2), {TextColor3 = toggled and Theme.Current.TextMain or Theme.Current.TextDim}):Play()
            for k, v in pairs(Theme.Objects) do
                if v.Obj == indicatorBg then v.Key = toggled and "Accent" or "Background" end
            end
            pcall(callback, toggled)
        end
        toggleFrm.MouseButton1Click:Connect(Fire)
        if toggled then lbl.TextColor3 = Theme.Current.TextMain end
        tabObj:AddElement(toggleFrm)
    end
end