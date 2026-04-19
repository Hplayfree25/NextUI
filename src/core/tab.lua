local tweenSvc = game:GetService("TweenService")

return function(Theme)
    local TabLib = {}
    
    function TabLib:Create(winObj, tabName)
        local tabObj = {}
        
        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(1, 0, 0, 36)
        tabBtn.BackgroundColor3 = Theme.TabUnselected
        tabBtn.Text = tabName
        tabBtn.TextColor3 = Theme.TextDim
        tabBtn.Font = Enum.Font.GothamSemibold
        tabBtn.TextSize = 13
        tabBtn.AutoButtonColor = false
        tabBtn.Parent = winObj.TabContainer
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = Theme.CornerRadius
        corner.Parent = tabBtn
        
        local tabPage = Instance.new("ScrollingFrame")
        tabPage.Size = UDim2.new(1, 0, 1, 0)
        tabPage.BackgroundTransparency = 1
        tabPage.ScrollBarThickness = 2
        tabPage.Visible = false
        tabPage.Parent = winObj.Container
        
        local listLayout = Instance.new("UIListLayout")
        listLayout.Padding = UDim.new(0, 8)
        listLayout.SortOrder = Enum.SortOrder.LayoutOrder
        listLayout.Parent = tabPage
        
        local tabPadding = Instance.new("UIPadding")
        tabPadding.PaddingTop = UDim.new(0, 15)
        tabPadding.PaddingLeft = UDim.new(0, 15)
        tabPadding.PaddingRight = UDim.new(0, 15)
        tabPadding.PaddingBottom = UDim.new(0, 15)
        tabPadding.Parent = tabPage
        
        tabBtn.MouseButton1Click:Connect(function()
            for _, child in pairs(winObj.Container:GetChildren()) do
                if child:IsA("ScrollingFrame") then child.Visible = false end
            end
            for _, child in pairs(winObj.TabContainer:GetChildren()) do
                if child:IsA("TextButton") then
                    tweenSvc:Create(child, TweenInfo.new(0.2), {
                        BackgroundColor3 = Theme.TabUnselected,
                        TextColor3 = Theme.TextDim
                    }):Play()
                end
            end
            
            tabPage.Visible = true
            tweenSvc:Create(tabBtn, TweenInfo.new(0.2), {
                BackgroundColor3 = Theme.TabSelected,
                TextColor3 = Theme.TextMain
            }):Play()
        end)
        
        local tabCount = 0
        for _, child in pairs(winObj.TabContainer:GetChildren()) do
            if child:IsA("TextButton") then tabCount = tabCount + 1 end
        end
        
        if tabCount == 1 then
            tabPage.Visible = true
            tabBtn.BackgroundColor3 = Theme.TabSelected
            tabBtn.TextColor3 = Theme.TextMain
        end
        
        tabObj.Page = tabPage
        return tabObj
    end
    
    return TabLib
end