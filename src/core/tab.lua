local tweenSvc = game:GetService("TweenService")
return function(Theme)
    local TabLib = {}
    function TabLib:Create(winObj, tabName)
        local tabObj = {
            winObj = winObj,
            Sections = {}
        }
        
        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(1, 0, 0, 36)
        Theme:Apply(tabBtn, {BackgroundColor3 = "TabUnselected", TextColor3 = "TextDim"})
        tabBtn.BackgroundTransparency = 1
        tabBtn.Text = tabName
        tabBtn.Font = Enum.Font.GothamSemibold
        tabBtn.TextSize = 13
        tabBtn.AutoButtonColor = false
        tabBtn.Parent = winObj.TabContainer
        
        local corner = Instance.new("UICorner")
        Theme:Apply(corner, {CornerRadius = "CornerRadius"})
        corner.Parent = tabBtn
        
        local tabPage = Instance.new("ScrollingFrame")
        tabPage.Size = UDim2.new(1, 0, 1, 0)
        tabPage.BackgroundTransparency = 1
        tabPage.ScrollBarThickness = 2
        tabPage.Visible = false
        tabPage.Parent = winObj.Container
        
        local pagePadding = Instance.new("UIPadding")
        pagePadding.PaddingTop = UDim.new(0, 15)
        pagePadding.PaddingLeft = UDim.new(0, 5)
        pagePadding.PaddingRight = UDim.new(0, 15)
        pagePadding.PaddingBottom = UDim.new(0, 15)
        pagePadding.Parent = tabPage
        
        local pageLayout = Instance.new("UIListLayout")
        pageLayout.Padding = UDim.new(0, 15)
        pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        pageLayout.Parent = tabPage
        
        pageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabPage.CanvasSize = UDim2.new(0, 0, 0, pageLayout.AbsoluteContentSize.Y + 30)
        end)
        
        tabBtn.MouseButton1Click:Connect(function()
            for _, child in pairs(winObj.Container:GetChildren()) do
                if child:IsA("ScrollingFrame") then child.Visible = false end
            end
            for _, child in pairs(winObj.TabContainer:GetChildren()) do
                if child:IsA("TextButton") then
                    tweenSvc:Create(child, TweenInfo.new(0.2), {BackgroundTransparency = 1, TextColor3 = Theme.Current.TextDim}):Play()
                end
            end
            tabPage.Visible = true
            tweenSvc:Create(tabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Current.TabSelected, BackgroundTransparency = 0, TextColor3 = Theme.Current.TextMain}):Play()
        end)
        
        local tabCount = 0
        for _, child in pairs(winObj.TabContainer:GetChildren()) do
            if child:IsA("TextButton") then tabCount = tabCount + 1 end
        end
        if tabCount == 1 then
            tabPage.Visible = true
            tabBtn.BackgroundColor3 = Theme.Current.TabSelected
            tabBtn.BackgroundTransparency = 0
            tabBtn.TextColor3 = Theme.Current.TextMain
        end
        
        tabObj.Page = tabPage
        return tabObj
    end
    return TabLib
end