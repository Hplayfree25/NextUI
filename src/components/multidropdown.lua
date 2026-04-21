local tweenSvc = game:GetService("TweenService")
return function(Theme)
    return function(tabObj, text, options, defaultSelected, callback)
        local selected = {}
        if type(defaultSelected) == "table" then
            for _, v in ipairs(defaultSelected) do selected[v] = true end
        end
        local dropdownFrm = Instance.new("Frame")
        dropdownFrm.Size = UDim2.new(1, 0, 0, 42)
        Theme:Apply(dropdownFrm, {BackgroundColor3 = "ElementBg"})
        dropdownFrm.ClipsDescendants = true
        local corner = Instance.new("UICorner")
        Theme:Apply(corner, {CornerRadius = "CornerRadius"})
        corner.Parent = dropdownFrm
        local mainBtn = Instance.new("TextButton")
        mainBtn.Size = UDim2.new(1, 0, 0, 42)
        mainBtn.BackgroundTransparency = 1
        mainBtn.Text = ""
        mainBtn.Parent = dropdownFrm
        local function getSelectedStr()
            local str = ""
            for k, v in pairs(selected) do
                if v then str = str .. k .. ", " end
            end
            if str == "" then return "None" end
            return string.sub(str, 1, -3)
        end
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -40, 1, 0)
        lbl.Position = UDim2.new(0, 15, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text .. " : " .. getSelectedStr()
        Theme:Apply(lbl, {TextColor3 = "TextDim"})
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Font = Enum.Font.GothamSemibold
        lbl.TextSize = 13
        lbl.Parent = mainBtn
        local icon = Instance.new("TextLabel")
        icon.Size = UDim2.new(0, 20, 1, 0)
        icon.Position = UDim2.new(1, -30, 0, 0)
        icon.BackgroundTransparency = 1
        icon.Text = "+"
        Theme:Apply(icon, {TextColor3 = "TextDim"})
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
            tweenSvc:Create(lbl, TweenInfo.new(0.2), {TextColor3 = isOpen and Theme.Current.TextMain or Theme.Current.TextDim}):Play()
        end)
        for _, opt in ipairs(options) do
            local optBtn = Instance.new("TextButton")
            optBtn.Size = UDim2.new(1, 0, 0, 30)
            Theme:Apply(optBtn, {BackgroundColor3 = "Background"})
            optBtn.BackgroundTransparency = 0.5
            optBtn.Text = tostring(opt)
            optBtn.TextColor3 = selected[opt] and Theme.Current.Accent or Theme.Current.TextDim
            optBtn.Font = Enum.Font.Gotham
            optBtn.TextSize = 12
            optBtn.AutoButtonColor = false
            optBtn.Parent = listFrm
            table.insert(Theme.Objects, {Obj = optBtn, Prop = "TextColor3", Key = selected[opt] and "Accent" or "TextDim"})
            local optCorner = Instance.new("UICorner")
            optCorner.CornerRadius = UDim.new(0, 6)
            optCorner.Parent = optBtn
            optBtn.MouseEnter:Connect(function()
                if not selected[opt] then
                    tweenSvc:Create(optBtn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Current.ElementHover, TextColor3 = Theme.Current.TextMain}):Play()
                end
            end)
            optBtn.MouseLeave:Connect(function()
                if not selected[opt] then
                    tweenSvc:Create(optBtn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Current.Background, TextColor3 = Theme.Current.TextDim}):Play()
                end
            end)
            optBtn.MouseButton1Click:Connect(function()
                selected[opt] = not selected[opt]
                local activeColor = selected[opt] and Theme.Current.Accent or Theme.Current.TextMain
                local activeKey = selected[opt] and "Accent" or "TextMain"
                tweenSvc:Create(optBtn, TweenInfo.new(0.2), {TextColor3 = activeColor}):Play()
                for _, v in pairs(Theme.Objects) do
                    if v.Obj == optBtn and v.Prop == "TextColor3" then v.Key = activeKey end
                end
                lbl.Text = text .. " : " .. getSelectedStr()
                local ret = {}
                for k, v in pairs(selected) do if v then table.insert(ret, k) end end
                pcall(callback, ret)
            end)
        end
        tabObj:AddElement(dropdownFrm)
    end
end