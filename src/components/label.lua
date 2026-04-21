return function(Theme)
    return function(tabObj, text)
        local lblFrm = Instance.new("Frame")
        lblFrm.Size = UDim2.new(1, 0, 0, 20)
        lblFrm.BackgroundTransparency = 1
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -20, 1, 0)
        lbl.Position = UDim2.new(0, 10, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        Theme:Apply(lbl, {TextColor3 = "TextDim"})
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Font = Enum.Font.Gotham
        lbl.TextSize = 13
        lbl.Parent = lblFrm
        tabObj:AddElement(lblFrm)
        
        local publicLbl = {}
        function publicLbl:SetText(newText)
            lbl.Text = newText
        end
        return publicLbl
    end
end