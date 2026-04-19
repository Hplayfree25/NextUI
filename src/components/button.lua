local tweenSvc = game:GetService("TweenService")
return function(Theme)
    return function(tabObj, text, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 42)
        Theme:Apply(btn, {BackgroundColor3 = "ElementBg", TextColor3 = "TextDim"})
        btn.Text = text
        btn.Font = Enum.Font.GothamSemibold
        btn.TextSize = 13
        btn.AutoButtonColor = false
        local corner = Instance.new("UICorner")
        Theme:Apply(corner, {CornerRadius = "CornerRadius"})
        corner.Parent = btn
        btn.MouseEnter:Connect(function()
            tweenSvc:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Current.ElementHover, TextColor3 = Theme.Current.TextMain}):Play()
        end)
        btn.MouseLeave:Connect(function()
            tweenSvc:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Current.ElementBg, TextColor3 = Theme.Current.TextDim}):Play()
        end)
        btn.MouseButton1Down:Connect(function()
            tweenSvc:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Current.ElementClick}):Play()
            tweenSvc:Create(corner, TweenInfo.new(0.1), {CornerRadius = UDim.new(0, 12)}):Play()
        end)
        btn.MouseButton1Up:Connect(function()
            tweenSvc:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Current.ElementHover}):Play()
            tweenSvc:Create(corner, TweenInfo.new(0.1), {CornerRadius = Theme.Current.CornerRadius}):Play()
        end)
        btn.MouseButton1Click:Connect(function() pcall(callback) end)
        tabObj:AddElement(btn)
    end
end