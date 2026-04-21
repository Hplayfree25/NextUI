local tweenSvc = game:GetService("TweenService")
local httpSvc = game:GetService("HttpService")

return function(Theme)
    local AuthLib = {}
    
    function AuthLib:Create(winObj, config)
        local keySettings = config.KeySettings or {}
        
        local authGui = Instance.new("ScreenGui")
        authGui.Name = "Vantix_Auth"
        authGui.ResetOnSpawn = false
        authGui.IgnoreGuiInset = true
        
        local guiParent = game:GetService("CoreGui")
        if not pcall(function() local _ = guiParent.Name end) then
            guiParent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        end
        
        -- Remove old auth
        for _, gui in pairs(guiParent:GetChildren()) do
            if gui.Name == "Vantix_Auth" then gui:Destroy() end
        end
        authGui.Parent = guiParent
        
        local env = getfenv()
        local read_file = env.readfile or (env.getgenv and env.getgenv().readfile)
        local is_file = env.isfile or (env.getgenv and env.getgenv().isfile)
        local write_file = env.writefile or (env.getgenv and env.getgenv().writefile)
        local set_clipboard = env.setclipboard or (env.getgenv and env.getgenv().setclipboard)
        
        local keyFileName = (config.Title or "Vantix") .. "_Key.txt"
        keyFileName = string.gsub(keyFileName, " ", "_")
        local savedKey = ""
        
        if keySettings.SaveKey and read_file and is_file and is_file(keyFileName) then
            pcall(function() savedKey = read_file(keyFileName) end)
        end
        
        -- UI Elements
        local bgOverlay = Instance.new("Frame")
        bgOverlay.Size = UDim2.new(1, 0, 1, 0)
        bgOverlay.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
        bgOverlay.BackgroundTransparency = 0.3
        bgOverlay.Parent = authGui
        
        local authFrm = Instance.new("Frame")
        authFrm.Size = UDim2.new(0, 360, 0, 220)
        authFrm.Position = UDim2.new(0.5, 0, 0.5, 0)
        authFrm.AnchorPoint = Vector2.new(0.5, 0.5)
        Theme:Apply(authFrm, {BackgroundColor3 = "Background", BackgroundTransparency = "BackgroundTransparency"})
        authFrm.BorderSizePixel = 0
        authFrm.Parent = bgOverlay
        
        local corner = Instance.new("UICorner")
        Theme:Apply(corner, {CornerRadius = "CornerRadius"})
        corner.Parent = authFrm
        
        local uiScale = Instance.new("UIScale")
        uiScale.Scale = 0
        uiScale.Parent = authFrm
        
        local titleLbl = Instance.new("TextLabel")
        titleLbl.Size = UDim2.new(1, 0, 0, 40)
        titleLbl.Position = UDim2.new(0, 0, 0, 10)
        titleLbl.BackgroundTransparency = 1
        titleLbl.Text = keySettings.Title or "Authentication"
        Theme:Apply(titleLbl, {TextColor3 = "TextMain"})
        titleLbl.Font = Enum.Font.GothamBold
        titleLbl.TextSize = 18
        titleLbl.Parent = authFrm
        
        local subLbl = Instance.new("TextLabel")
        subLbl.Size = UDim2.new(1, 0, 0, 20)
        subLbl.Position = UDim2.new(0, 0, 0, 40)
        subLbl.BackgroundTransparency = 1
        subLbl.Text = keySettings.Subtitle or "Please enter your key to continue"
        Theme:Apply(subLbl, {TextColor3 = "TextDim"})
        subLbl.Font = Enum.Font.Gotham
        subLbl.TextSize = 12
        subLbl.Parent = authFrm
        
        local keyBoxFrm = Instance.new("Frame")
        keyBoxFrm.Size = UDim2.new(1, -40, 0, 40)
        keyBoxFrm.Position = UDim2.new(0, 20, 0, 75)
        Theme:Apply(keyBoxFrm, {BackgroundColor3 = "ElementBg"})
        keyBoxFrm.Parent = authFrm
        
        local boxCorner = Instance.new("UICorner")
        Theme:Apply(boxCorner, {CornerRadius = "CornerRadius"})
        boxCorner.Parent = keyBoxFrm
        
        local keyBox = Instance.new("TextBox")
        keyBox.Size = UDim2.new(1, -20, 1, 0)
        keyBox.Position = UDim2.new(0, 10, 0, 0)
        keyBox.BackgroundTransparency = 1
        keyBox.Text = savedKey
        keyBox.PlaceholderText = "Enter Key Here..."
        Theme:Apply(keyBox, {TextColor3 = "TextMain"})
        keyBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 110)
        keyBox.Font = Enum.Font.GothamSemibold
        keyBox.TextSize = 13
        keyBox.ClearTextOnFocus = false
        keyBox.Parent = keyBoxFrm
        
        local btnContainer = Instance.new("Frame")
        btnContainer.Size = UDim2.new(1, -40, 0, 40)
        btnContainer.Position = UDim2.new(0, 20, 0, 130)
        btnContainer.BackgroundTransparency = 1
        btnContainer.Parent = authFrm
        
        local getBtn = Instance.new("TextButton")
        getBtn.Size = UDim2.new(0.48, 0, 1, 0)
        getBtn.Position = UDim2.new(0, 0, 0, 0)
        Theme:Apply(getBtn, {BackgroundColor3 = "ElementBg", TextColor3 = "TextMain"})
        getBtn.Text = "Get Key"
        getBtn.Font = Enum.Font.GothamBold
        getBtn.TextSize = 13
        getBtn.AutoButtonColor = false
        getBtn.Parent = btnContainer
        local getCorner = Instance.new("UICorner")
        Theme:Apply(getCorner, {CornerRadius = "CornerRadius"})
        getCorner.Parent = getBtn
        
        local checkBtn = Instance.new("TextButton")
        checkBtn.Size = UDim2.new(0.48, 0, 1, 0)
        checkBtn.Position = UDim2.new(0.52, 0, 0, 0)
        Theme:Apply(checkBtn, {BackgroundColor3 = "Accent", TextColor3 = "TextMain"})
        checkBtn.Text = "Check Key"
        checkBtn.Font = Enum.Font.GothamBold
        checkBtn.TextSize = 13
        checkBtn.AutoButtonColor = false
        checkBtn.Parent = btnContainer
        local checkCorner = Instance.new("UICorner")
        Theme:Apply(checkCorner, {CornerRadius = "CornerRadius"})
        checkCorner.Parent = checkBtn
        
        local function verifyKey(inputKey)
            if keySettings.GrabKeyFromSite then
                if type(keySettings.Key) == "table" then
                    for className, url in pairs(keySettings.Key) do
                        local s, r = pcall(function() return game:HttpGet(url) end)
                        if s and r and string.find(r, inputKey) then
                            return true, type(className) == "string" and className or "Member"
                        end
                    end
                else
                    local s, r = pcall(function() return game:HttpGet(keySettings.Key) end)
                    if s and r and string.find(r, inputKey) then
                        return true, "Member"
                    end
                end
            else
                if type(keySettings.Key) == "table" then
                    local isArray = true
                    for k, _ in pairs(keySettings.Key) do
                        if type(k) ~= "number" then isArray = false break end
                    end
                    
                    if isArray then
                        for _, k in ipairs(keySettings.Key) do
                            if inputKey == k then return true, "Member" end
                        end
                    else
                        for className, keys in pairs(keySettings.Key) do
                            if type(keys) == "table" then
                                for _, k in ipairs(keys) do
                                    if inputKey == k then return true, className end
                                end
                            elseif type(keys) == "string" then
                                if inputKey == keys then return true, className end
                            end
                        end
                    end
                elseif type(keySettings.Key) == "string" then
                    if inputKey == keySettings.Key then return true, "Member" end
                end
            end
            return false, "None"
        end

        local isChecking = false
        
        checkBtn.MouseButton1Click:Connect(function()
            if isChecking then return end
            local input = keyBox.Text
            local origColor = checkBtn.BackgroundColor3
            local origText = checkBtn.Text
            
            if input == "" then
                isChecking = true
                checkBtn.Text = "Empty Key!"
                tweenSvc:Create(checkBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(231, 76, 60)}):Play()
                task.wait(1)
                checkBtn.Text = origText
                tweenSvc:Create(checkBtn, TweenInfo.new(0.3), {BackgroundColor3 = origColor}):Play()
                isChecking = false
                return
            end
            
            isChecking = true
            checkBtn.Text = "Checking..."
            task.wait(0.6) -- Simulated Loading
            
            local isValid, className = verifyKey(input)
            
            if isValid then
                checkBtn.Text = "Verified!"
                tweenSvc:Create(checkBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(46, 204, 113)}):Play()
                if keySettings.SaveKey and write_file then
                    pcall(function() write_file(keyFileName, input) end)
                end
                
                winObj.MemberClass = className
                if winObj.OnAuthSuccess then
                    winObj.OnAuthSuccess:Fire(className)
                end
                
                -- Close Auth and open Main UI
                task.wait(0.8)
                tweenSvc:Create(uiScale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0}):Play()
                tweenSvc:Create(bgOverlay, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
                task.wait(0.5)
                authGui:Destroy()
                winObj:PlayIntro()
            else
                checkBtn.Text = "Invalid Key!"
                tweenSvc:Create(checkBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(231, 76, 60)}):Play()
                task.wait(1.5)
                checkBtn.Text = origText
                tweenSvc:Create(checkBtn, TweenInfo.new(0.3), {BackgroundColor3 = origColor}):Play()
                isChecking = false
            end
        end)
        
        getBtn.MouseButton1Click:Connect(function()
            if set_clipboard and keySettings.Discord then
                set_clipboard(keySettings.Discord)
                local origText = getBtn.Text
                getBtn.Text = "Copied Link!"
                task.wait(1.5)
                getBtn.Text = origText
            end
        end)
        
        -- Animations
        tweenSvc:Create(uiScale, TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Scale = 1}):Play()
    end
    
    return AuthLib
end