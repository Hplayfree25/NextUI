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