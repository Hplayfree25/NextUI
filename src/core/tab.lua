local tweenSvc = game:GetService("TweenService")
return function(Theme)
    local TabLib = {}
    function TabLib:Create(winObj, tabName)
        local tabObj = {ElementCount = 0}
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
        local leftCol = Instance.new("Frame")
        leftCol.Size = UDim2.new(1, 0, 1, 0)
        leftCol.BackgroundTransparency = 1
        leftCol.Parent = tabPage
        local leftLayout = Instance.new("UIListLayout")
        leftLayout.Padding = UDim.new(0, 8)
        leftLayout.SortOrder = Enum.SortOrder.LayoutOrder
        leftLayout.Parent = leftCol
        local midCol = Instance.new("Frame")
        midCol.Size = UDim2.new(0, 0, 1, 0)
        midCol.Position = UDim2.new(0.33, 4, 0, 0)
        midCol.BackgroundTransparency = 1
        midCol.Parent = tabPage
        local midLayout = Instance.new("UIListLayout")
        midLayout.Padding = UDim.new(0, 8)
        midLayout.SortOrder = Enum.SortOrder.LayoutOrder
        midLayout.Parent = midCol
        local rightCol = Instance.new("Frame")
        rightCol.Size = UDim2.new(0, 0, 1, 0)
        rightCol.Position = UDim2.new(0.66, 8, 0, 0)
        rightCol.BackgroundTransparency = 1
        rightCol.Parent = tabPage
        local rightLayout = Instance.new("UIListLayout")
        rightLayout.Padding = UDim.new(0, 8)
        rightLayout.SortOrder = Enum.SortOrder.LayoutOrder
        rightLayout.Parent = rightCol
        function tabObj:AddElement(guiObj)
            self.ElementCount = self.ElementCount + 1
            guiObj.LayoutOrder = self.ElementCount
            if winObj.IsMaximized then
                local colMod = self.ElementCount % 3
                if colMod == 1 then guiObj.Parent = leftCol
                elseif colMod == 2 then guiObj.Parent = midCol
                else guiObj.Parent = rightCol end
            else
                guiObj.Parent = leftCol
            end
        end
        winObj.MaximizeEvent.Event:Connect(function(isMax)
            if isMax then
                leftCol.Size = UDim2.new(0.33, -5, 1, 0)
                midCol.Size = UDim2.new(0.33, -5, 1, 0)
                rightCol.Size = UDim2.new(0.33, -5, 1, 0)
                local elements = {}
                for _, el in ipairs(leftCol:GetChildren()) do if el:IsA("GuiObject") then table.insert(elements, el) end end
                for _, el in ipairs(midCol:GetChildren()) do if el:IsA("GuiObject") then table.insert(elements, el) end end
                for _, el in ipairs(rightCol:GetChildren()) do if el:IsA("GuiObject") then table.insert(elements, el) end end
                table.sort(elements, function(a,b) return a.LayoutOrder < b.LayoutOrder end)
                for i, el in ipairs(elements) do
                    local colMod = i % 3
                    if colMod == 1 then el.Parent = leftCol
                    elseif colMod == 2 then el.Parent = midCol
                    else el.Parent = rightCol end
                end
            else
                leftCol.Size = UDim2.new(1, 0, 1, 0)
                midCol.Size = UDim2.new(0, 0, 1, 0)
                rightCol.Size = UDim2.new(0, 0, 1, 0)
                local elements = {}
                for _, el in ipairs(leftCol:GetChildren()) do if el:IsA("GuiObject") then table.insert(elements, el) end end
                for _, el in ipairs(midCol:GetChildren()) do if el:IsA("GuiObject") then table.insert(elements, el) end end
                for _, el in ipairs(rightCol:GetChildren()) do if el:IsA("GuiObject") then table.insert(elements, el) end end
                table.sort(elements, function(a,b) return a.LayoutOrder < b.LayoutOrder end)
                for _, el in ipairs(elements) do el.Parent = leftCol end
            end
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