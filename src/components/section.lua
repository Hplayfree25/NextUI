return function(Theme)
    return function(tabObj, text)
        local secObj = {ElementCount = 0}
        
        local secContainer = Instance.new("Frame")
        secContainer.Size = UDim2.new(1, 0, 0, 0)
        secContainer.BackgroundTransparency = 1
        secContainer.Parent = tabObj.Page
        
        local secLayout = Instance.new("UIListLayout")
        secLayout.Padding = UDim.new(0, 8)
        secLayout.SortOrder = Enum.SortOrder.LayoutOrder
        secLayout.Parent = secContainer
        
        secLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            secContainer.Size = UDim2.new(1, 0, 0, secLayout.AbsoluteContentSize.Y)
        end)
        
        local titleFrm = Instance.new("Frame")
        titleFrm.Size = UDim2.new(1, 0, 0, 30)
        titleFrm.BackgroundTransparency = 1
        titleFrm.LayoutOrder = 0
        titleFrm.Parent = secContainer
        
        if text == "" then
            titleFrm.Visible = false
        else
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, -10, 1, -5)
            lbl.Position = UDim2.new(0, 5, 0, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = text
            Theme:Apply(lbl, {TextColor3 = "Accent"})
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Font = Enum.Font.GothamBlack
            lbl.TextSize = 14
            lbl.Parent = titleFrm
            
            local line = Instance.new("Frame")
            line.Size = UDim2.new(1, -10, 0, 2)
            line.Position = UDim2.new(0, 5, 1, -2)
            Theme:Apply(line, {BackgroundColor3 = "Accent"})
            line.BorderSizePixel = 0
            line.BackgroundTransparency = 0.5
            line.Parent = titleFrm
        end
        
        local elContainer = Instance.new("Frame")
        elContainer.Size = UDim2.new(1, 0, 0, 0)
        elContainer.BackgroundTransparency = 1
        elContainer.LayoutOrder = 1
        elContainer.Parent = secContainer
        
        local leftCol = Instance.new("Frame")
        leftCol.Size = UDim2.new(1, 0, 1, 0)
        leftCol.BackgroundTransparency = 1
        leftCol.Parent = elContainer
        local leftLayout = Instance.new("UIListLayout")
        leftLayout.Padding = UDim.new(0, 8)
        leftLayout.SortOrder = Enum.SortOrder.LayoutOrder
        leftLayout.Parent = leftCol
        
        local midCol = Instance.new("Frame")
        midCol.Size = UDim2.new(0, 0, 1, 0)
        midCol.Position = UDim2.new(0.33, 4, 0, 0)
        midCol.BackgroundTransparency = 1
        midCol.Parent = elContainer
        local midLayout = Instance.new("UIListLayout")
        midLayout.Padding = UDim.new(0, 8)
        midLayout.SortOrder = Enum.SortOrder.LayoutOrder
        midLayout.Parent = midCol
        
        local rightCol = Instance.new("Frame")
        rightCol.Size = UDim2.new(0, 0, 1, 0)
        rightCol.Position = UDim2.new(0.66, 8, 0, 0)
        rightCol.BackgroundTransparency = 1
        rightCol.Parent = elContainer
        local rightLayout = Instance.new("UIListLayout")
        rightLayout.Padding = UDim.new(0, 8)
        rightLayout.SortOrder = Enum.SortOrder.LayoutOrder
        rightLayout.Parent = rightCol
        
        local function updateSize()
            local m = math.max(leftLayout.AbsoluteContentSize.Y, midLayout.AbsoluteContentSize.Y, rightLayout.AbsoluteContentSize.Y)
            elContainer.Size = UDim2.new(1, 0, 0, m)
        end
        leftLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)
        midLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)
        rightLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)
        
        function secObj:AddElement(guiObj)
            self.ElementCount = self.ElementCount + 1
            guiObj.LayoutOrder = self.ElementCount
            if tabObj.winObj.IsMaximized then
                local colMod = self.ElementCount % 3
                if colMod == 1 then guiObj.Parent = leftCol
                elseif colMod == 2 then guiObj.Parent = midCol
                else guiObj.Parent = rightCol end
            else
                guiObj.Parent = leftCol
            end
        end
        
        tabObj.winObj.MaximizeEvent.Event:Connect(function(isMax)
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
        
        return secObj
    end
end