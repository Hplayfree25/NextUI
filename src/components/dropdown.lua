local tweenSvc = game:GetService("TweenService")

return function(Theme)
    return function(tabObj, text, options, callback)
        local dropdownFrm = Instance.new("Frame")
        dropdownFrm.Size = UDim2.new(1, 0, 0, 42)
        dropdownFrm.BackgroundColor3 = Theme.ElementBg
        dropdownFrm.ClipsDescendants = true
        
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
        
        tabObj:AddElement(dropdownFrm)
    end
end