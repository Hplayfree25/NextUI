local tweenSvc = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
return function(Theme)
    return function(tabObj, text, min, max, default, callback)
        local value = default or min
        local sliderFrm = Instance.new("Frame")
        sliderFrm.Size = UDim2.new(1, 0, 0, 42)
        Theme:Apply(sliderFrm, {BackgroundColor3 = "ElementBg"})
        local corner = Instance.new("UICorner")
        Theme:Apply(corner, {CornerRadius = "CornerRadius"})
        corner.Parent = sliderFrm
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -60, 0, 20)
        lbl.Position = UDim2.new(0, 15, 0, 6)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        Theme:Apply(lbl, {TextColor3 = "TextDim"})
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Font = Enum.Font.GothamSemibold
        lbl.TextSize = 13
        lbl.Parent = sliderFrm
        local valLbl = Instance.new("TextLabel")
        valLbl.Size = UDim2.new(0, 40, 0, 20)
        valLbl.Position = UDim2.new(1, -55, 0, 6)
        valLbl.BackgroundTransparency = 1
        valLbl.Text = tostring(value)
        Theme:Apply(valLbl, {TextColor3 = "TextMain"})
        valLbl.TextXAlignment = Enum.TextXAlignment.Right
        valLbl.Font = Enum.Font.GothamSemibold
        valLbl.TextSize = 13
        valLbl.Parent = sliderFrm
        local sliderBg = Instance.new("Frame")
        sliderBg.Size = UDim2.new(1, -30, 0, 4)
        sliderBg.Position = UDim2.new(0, 15, 1, -12)
        Theme:Apply(sliderBg, {BackgroundColor3 = "Background"})
        sliderBg.Parent = sliderFrm
        local bgCorner = Instance.new("UICorner")
        bgCorner.CornerRadius = UDim.new(1, 0)
        bgCorner.Parent = sliderBg
        local sliderFill = Instance.new("Frame")
        sliderFill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
        Theme:Apply(sliderFill, {BackgroundColor3 = "Accent"})
        sliderFill.Parent = sliderBg
        local fillCorner = Instance.new("UICorner")
        fillCorner.CornerRadius = UDim.new(1, 0)
        fillCorner.Parent = sliderFill
        local thumb = Instance.new("Frame")
        thumb.Size = UDim2.new(0, 12, 0, 12)
        thumb.Position = UDim2.new(1, -6, 0.5, -6)
        thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        thumb.Parent = sliderFill
        local thumbCorner = Instance.new("UICorner")
        thumbCorner.CornerRadius = UDim.new(1, 0)
        thumbCorner.Parent = thumb
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 3, 0)
        btn.Position = UDim2.new(0, 0, -1, 0)
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.Parent = sliderBg
        local dragging = false
        local function update(input)
            local sizeX = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
            value = math.floor(min + ((max - min) * sizeX))
            valLbl.Text = tostring(value)
            tweenSvc:Create(sliderFill, TweenInfo.new(0.1), {Size = UDim2.new(sizeX, 0, 1, 0)}):Play()
            pcall(callback, value)
        end
        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                tweenSvc:Create(thumb, TweenInfo.new(0.1), {Size = UDim2.new(0, 16, 0, 16), Position = UDim2.new(1, -8, 0.5, -8)}):Play()
                update(input)
            end
        end)
        btn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
                tweenSvc:Create(thumb, TweenInfo.new(0.1), {Size = UDim2.new(0, 12, 0, 12), Position = UDim2.new(1, -6, 0.5, -6)}):Play()
            end
        end)
        uis.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                update(input)
            end
        end)
        tabObj:AddElement(sliderFrm)
    end
end