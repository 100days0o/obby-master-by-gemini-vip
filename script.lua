-- Hệ thống chống AFK (VIP Premium) - Tối ưu hóa bộ nhớ
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

pcall(function()
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new(0,0))
    end)
end)

-- Khởi tạo Hệ thống Ngôn ngữ mặc định (1: Tiếng Việt, 2: English)
local CurrentLang = 1

-- Bảng từ điển dịch thuật cao cấp
local Localization = {
    ["LoadingTitle"] = {"Đang tải Universe MASTER ULTRA VIP...", "Loading Universe MASTER ULTRA VIP..."},
    ["TabMove"] = {"Di Chuyển VIP", "VIP Movement"},
    ["TabObby"] = {"Bá Chủ Obby", "Obby God Mode"},
    ["TabProtect"] = {"Phòng Thủ Tối Thượng", "Ultimate Defense"},
    ["TabVisual"] = {"Hiệu Ứng & Quan Sát", "Visuals & World"},
    ["TabMisc"] = {"Tiện Ích Tối Cao", "Supreme Utilities"},
    ["TabLang"] = {"Ngôn Ngữ / Language", "Language / Ngôn Ngữ"},
    
    ["WalkSpeed"] = {"Tốc độ chạy (WalkSpeed)", "WalkSpeed"},
    ["JumpPower"] = {"Độ cao nhảy (JumpPower)", "JumpPower"},
    ["InfJump"] = {"Nhảy vô hạn Mobile (Infinity Jump)", "Infinite Jump (Mobile Friendly)"},
    ["FlyHack"] = {"Chế độ Bay Mobile (Fly Hack Mobile)", "Fly Hack (Mobile Version)"},
    
    ["AutoWin"] = {"Phá đảo ngay lập tức (Instant Win)", "Instant Win Obby"},
    ["SpeedRun"] = {"Chế độ Phá Đảo Tốc Độ (Speed Run Mode)", "Speed Run Mode (Safe Tween)"},
    ["AutoFarm"] = {"Tự động cày màn (Auto Farm Stage)", "Auto Farm Stages"},
    ["ClearTraps"] = {"Vô hiệu hóa toàn bộ bẫy", "Disable All Traps"},
    ["InstantInteract"] = {"Tương tác không chờ (Instant Interact)", "Instant Interact"},
    
    ["GodMode"] = {"Bất tử hoàn toàn (God Mode)", "God Mode"},
    ["InfLife"] = {"Vô hạn mạng sống (Inf Life)", "Infinite Lives"},
    ["AutoDodge"] = {"Tự động né bẫy/quái (Auto Dodge)", "Auto Dodge Hazards"},
    ["Magnet"] = {"Hút mọi vật phẩm/Xu (Item Magnet)", "Item Magnet"},
    ["ESPMonster"] = {"Định vị Quái Vật (ESP Monster)", "ESP Monster (Red)"},
    ["KillAura"] = {"Tự động chém quái khi cầm kiếm (Kill Aura)", "Kill Aura (Sword Required)"},
    ["SavePos"] = {"Lưu vị trí hiện tại", "Save Position"},
    ["TPPos"] = {"Dịch chuyển về vị trí đã lưu", "Teleport to Saved Position"},
    
    ["ESP"] = {"Nhìn xuyên người chơi (ESP Player)", "ESP (Player Wallhack)"},
    ["Noclip"] = {"Đi xuyên tường (Noclip)", "Noclip"},
    ["Fullbright"] = {"Bật Kính nhìn đêm (Fullbright)", "Fullbright (No Shadows)"},
    ["NoFog"] = {"Xóa bỏ sương mù (No Fog)", "Remove Fog"},
    
    ["BTools"] = {"Nhận Công cụ phá Map (F3X BTools VIP)", "Get F3X BTools VIP"},
    ["TPTool"] = {"Nhận Dụng cụ Dịch Chuyển (TP Tool)", "Get Teleport Tool"},
    ["SpeedCoil"] = {"Nhận Vòng Tốc Độ (Speed Coil Tool)", "Get Speed Coil Tool"},
    ["GravCoil"] = {"Nhận Vòng Trọng Lực (Gravity Coil Tool)", "Get Gravity Coil Tool"},
    ["ServerHop"] = {"Chuyển Server siêu tốc", "Server Hop"},
    ["ResetChar"] = {"Tự tử (Reset)", "Reset Character"},
    
    ["NotifyTitle"] = {"ĐÃ KÍCH HOẠT ULTRA VIP!", "ULTRA VIP ACTIVATED!"},
    ["NotifyContent"] = {"Bạn đang sở hữu đặc quyền tối cao của Hub. Hãy tận hưởng!", "You now hold the supreme privileges of the Hub. Enjoy!"}
}

local function GetText(key)
    return Localization[key] and Localization[key][CurrentLang] or key
end

-- Khởi tạo Rayfield GUI (Tải nhanh từ CDN ưu tiên)
local Rayfield = nil
pcall(function() Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))() end)
if not Rayfield then
    Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
end

local Window = Rayfield:CreateWindow({
    Name = "🌌 Universe Master Hub [ULTRA VIP] 2026",
    LoadingTitle = GetText("LoadingTitle"),
    LoadingSubtitle = "Supreme Multi-tool Subscription",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false
})

-- Khởi tạo các Tab chức năng
local TabMovement = Window:CreateTab(GetText("TabMove"), "move")
local TabObbyEscape = Window:CreateTab(GetText("TabObby"), "trophy")
local TabCombatVisual = Window:CreateTab(GetText("TabProtect"), "shield")
local TabVisuals = Window:CreateTab(GetText("TabVisual"), "eye")
local TabMisc = Window:CreateTab(GetText("TabMisc"), "star")
local TabLanguage = Window:CreateTab(GetText("TabLang"), "globe")

local function GetCharacterElements()
    local char = LocalPlayer.Character
    if not char then return nil, nil, nil end
    return char, char:FindFirstChildOfClass("Humanoid"), char:FindFirstChild("HumanoidRootPart")
end

---------------------------------------------------------
-- TAB 1: DI CHUYỂN VIP (TỐI ƯU MOBILE)
---------------------------------------------------------
TabMovement:CreateSlider({
    Name = GetText("WalkSpeed"),
    Range = {16, 500},
    Increment = 1,
    Suffix = "Studs",
    CurrentValue = 16,
    Callback = function(v) _G.CustomSpeed = v end,
})

TabMovement:CreateSlider({
    Name = GetText("JumpPower"),
    Range = {50, 1000},
    Increment = 1,
    Suffix = "Height",
    CurrentValue = 50,
    Callback = function(v) _G.CustomJump = v end,
})

TabMovement:CreateToggle({
    Name = GetText("InfJump"),
    CurrentValue = false,
    Callback = function(v) _G.InfJump = v end,
})

-- Xử lý vòng lặp thuộc tính nhân vật (Gộp chung để chạy siêu tốc)
task.spawn(function()
    RunService.Heartbeat:Connect(function()
        local _, hum, hrp = GetCharacterElements()
        if hum then
            if _G.CustomSpeed then hum.WalkSpeed = _G.CustomSpeed end
            if _G.CustomJump then hum.JumpPower = _G.CustomJump end
        end
    end)
end)

-- Nhảy vô hạn tối ưu phản hồi nhanh
game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfJump then
        local _, hum, _ = GetCharacterElements()
        if hum then hum:ChangeState("Jumping") end
    end
end)

-- HỆ THỐNG BAY MOBILE ĐỘC QUYỀN
local Flying = false
local FlySpeed = 50
local FlyUp = false
local FlyDown = false
local ScreenGui = nil

local function CreateMobileFlyButtons()
    if ScreenGui then ScreenGui:Destroy() end
    
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MobileFlyGui"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game:GetService("CoreGui") or PlayerGui
    
    local UpBtn = Instance.new("TextButton")
    UpBtn.Name = "FlyUpButton"
    UpBtn.Size = UDim2.new(0, 65, 0, 65)
    UpBtn.Position = UDim2.new(0.85, 0, 0.55, -70)
    UpBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    UpBtn.Text = "▲"
    UpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    UpBtn.TextSize = 30
    UpBtn.Font = Enum.Font.SourceSansBold
    UpBtn.BackgroundTransparency = 0.3
    Instance.new("UICorner", UpBtn).CornerRadius = UDim.new(0, 12)
    UpBtn.Parent = ScreenGui
    
    local DownBtn = Instance.new("TextButton")
    DownBtn.Name = "FlyDownButton"
    DownBtn.Size = UDim2.new(0, 65, 0, 65)
    DownBtn.Position = UDim2.new(0.85, 0, 0.55, 10)
    DownBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    DownBtn.Text = "▼"
    DownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    DownBtn.TextSize = 30
    DownBtn.Font = Enum.Font.SourceSansBold
    DownBtn.BackgroundTransparency = 0.3
    Instance.new("UICorner", DownBtn).CornerRadius = UDim.new(0, 12)
    DownBtn.Parent = ScreenGui
    
    UpBtn.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then FlyUp = true end end)
    UpBtn.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then FlyUp = false end end)
    DownBtn.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then FlyDown = true end end)
    DownBtn.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then FlyDown = false end end)
end

TabMovement:CreateToggle({
    Name = GetText("FlyHack"),
    CurrentValue = false,
    Callback = function(v)
        Flying = v
        local _, _, hrp = GetCharacterElements()
        if not hrp then return end
        
        if Flying then
            CreateMobileFlyButtons()
            if hrp:FindFirstChild("VIPFly") then hrp.VIPFly:Destroy() end
            if hrp:FindFirstChild("VIPGyro") then hrp.VIPGyro:Destroy() end
            
            local bv = Instance.new("BodyVelocity", hrp)
            bv.Name = "VIPFly"
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            
            local bg = Instance.new("BodyGyro", hrp)
            bg.Name = "VIPGyro"
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            
            task.spawn(function()
                local camera = workspace.CurrentCamera
                while Flying and task.wait() do
                    local _, hum, cHrp = GetCharacterElements()
                    if not cHrp or not cHrp:FindFirstChild("VIPFly") then break end
                    
                    cHrp.VIPGyro.cframe = camera.CFrame
                    local moveDirection = hum and hum.MoveDirection or Vector3.new(0,0,0)
                    local velocityVector = moveDirection * FlySpeed
                    
                    local verticalSpeed = 0
                    if FlyUp then verticalSpeed = FlySpeed end
                    if FlyDown then verticalSpeed = -FlySpeed end
                    
                    cHrp.VIPFly.velocity = Vector3.new(velocityVector.X, verticalSpeed == 0 and velocityVector.Y or verticalSpeed, velocityVector.Z)
                    if moveDirection.Magnitude == 0 and verticalSpeed == 0 then
                        cHrp.VIPFly.velocity = Vector3.new(0, 0, 0)
                    end
                end
            end)
        else
            Flying = false
            FlyUp = false
            FlyDown = false
            if ScreenGui then ScreenGui:Destroy() ScreenGui = nil end
            if hrp:FindFirstChild("VIPFly") then hrp.VIPFly:Destroy() end
            if hrp:FindFirstChild("VIPGyro") then hrp.VIPGyro:Destroy() end
        end
    end,
})

---------------------------------------------------------
-- TAB 2: BÁ CHỦ OBBY (TỐI ƯU HÓA TÌM KIẾM NHANH)
---------------------------------------------------------
TabObbyEscape:CreateButton({
    Name = GetText("AutoWin"),
    Callback = function()
        local _, _, hrp = GetCharacterElements()
        if hrp then
            for _, v in pairs(workspace:GetChildren()) do
                if v:IsA("BasePart") and (string.find(v.Name, "Win") or string.find(v.Name, "End") or string.find(v.Name, "Finish")) then
                    hrp.CFrame = v.CFrame
                    return
                end
            end
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and (string.find(v.Name, "Win") or string.find(v.Name, "End") or string.find(v.Name, "Finish")) then
                    hrp.CFrame = v.CFrame
                    break
                end
            end
        end
    end,
})

TabObbyEscape:CreateButton({
    Name = GetText("SpeedRun"),
    Callback = function()
        local _, _, hrp = GetCharacterElements()
        if not hrp then return end
        
        task.spawn(function()
            local allParts = workspace:GetDescendants()
            for i = 1, 500 do
                for _, v in pairs(allParts) do
                    if v:IsA("BasePart") and (v.Name == tostring(i) or v.Name == "Checkpoint " .. tostring(i)) then
                        local tween = TweenService:Create(hrp, TweenInfo.new(0.08, Enum.EasingStyle.Linear), {CFrame = v.CFrame + Vector3.new(0,3,0)})
                        tween:Play()
                        tween.Completed:Wait()
                        break
                    end
                end
            end
        end)
    end,
})

TabObbyEscape:CreateToggle({
    Name = GetText("AutoFarm"),
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        if not Value then return end
        task.spawn(function()
            local allParts = workspace:GetDescendants()
            while _G.AutoFarm do
                local _, _, hrp = GetCharacterElements()
                if hrp then
                    for i = 1, 500 do
                        if not _G.AutoFarm then break end
                        for _, v in pairs(allParts) do
                            if v:IsA("BasePart") and (v.Name == tostring(i) or v.Name == "Checkpoint " .. tostring(i)) then
                                hrp.CFrame = v.CFrame + Vector3.new(0, 3, 0)
                                task.wait(0.15)
                                break
                            end
                        end
                    end
                end
                task.wait(0.5)
            end
        end)
    end,
})

TabObbyEscape:CreateButton({
    Name = GetText("ClearTraps"),
    Callback = function()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                local lowerName = string.lower(v.Name)
                if string.find(lowerName, "kill") or string.find(lowerName, "lava") or string.find(lowerName, "dead") then
                    v.CanTouch = false
                    v.Transparency = 0.6
                    v.Color = Color3.fromRGB(170, 0, 255)
                end
            end
        end
    end,
})

TabObbyEscape:CreateToggle({
    Name = GetText("InstantInteract"),
    CurrentValue = false,
    Callback = function(v) _G.Instant = v end,
})

task.spawn(function()
    while task.wait(0.1) do
        if _G.Instant then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") then v.HoldDuration = 0 end
            end
        end
    end
end)

---------------------------------------------------------
-- TAB 3: PHÒNG THỦ TỐI THƯỢNG
---------------------------------------------------------
TabCombatVisual:CreateToggle({
    Name = GetText("GodMode"),
    CurrentValue = false,
    Callback = function(v) _G.GodMode = v end,
})

TabCombatVisual:CreateToggle({
    Name = GetText("InfLife"),
    CurrentValue = false,
    Callback = function(v) _G.InfLife = v end,
})

TabCombatVisual:CreateToggle({
    Name = GetText("AutoDodge"),
    CurrentValue = false,
    Callback = function(v) _G.AutoDodge = v end,
})

TabCombatVisual:CreateToggle({
    Name = GetText("Magnet"),
    CurrentValue = false,
    Callback = function(v) _G.Magnet = v end,
})

TabCombatVisual:CreateToggle({
    Name = GetText("ESPMonster"),
    CurrentValue = false,
    Callback = function(Value)
        _G.ESPMonster = Value
        if not Value then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Highlight") and v.Name == "MonsterESP" then v:Destroy() end
            end
        end
    end,
})

TabCombatVisual:CreateToggle({
    Name = GetText("KillAura"),
    CurrentValue = false,
    Callback = function(Value) _G.KillAura = Value end
})

task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            local char, _, hrp = GetCharacterElements()
            if not char or not hrp then return end

            if _G.ESPMonster then
                for _, model in pairs(workspace:GetChildren()) do
                    if model:IsA("Model") and model ~= char and not Players:GetPlayerFromCharacter(model) then
                        local lowerName = string.lower(model.Name)
                        if string.find(lowerName, "monster") or string.find(lowerName, "zombie") or string.find(lowerName, "bot") or model:FindFirstChild("Zombie") or model:FindFirstChild("Monster") then
                            if not model:FindFirstChild("MonsterESP") then
                                local hl = Instance.new("Highlight")
                                hl.Name = "MonsterESP"
                                hl.FillColor = Color3.fromRGB(255, 0, 0)
                                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                                hl.FillTransparency = 0.5
                                hl.Parent = model
                            end
                        end
                    end
                end
            end

            if _G.KillAura then
                local tool = char:FindFirstChildOfClass("Tool")
                if tool then
                    local lowerTool = string.lower(tool.Name)
                    if string.find(lowerTool, "sword") or string.find(lowerTool, "kiếm") or string.find(lowerTool, "weapon") or tool:FindFirstChildOfClass("TouchTransmitter") then
                        for _, enemy in pairs(workspace:GetChildren()) do
                            if enemy:IsA("Model") and enemy ~= char and not Players:GetPlayerFromCharacter(enemy) then
                                local enemyHrp = enemy:FindFirstChild("HumanoidRootPart") or enemy:FindFirstChild("Torso")
                                local enemyHum = enemy:FindFirstChildOfClass("Humanoid")
                                if enemyHrp and enemyHum and enemyHum.Health > 0 then
                                    if (hrp.Position - enemyHrp.Position).Magnitude <= 18 then
                                        tool:Activate()
                                        local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildOfClass("BasePart")
                                        if handle then
                                            firetouchinterest(enemyHrp, handle, 0)
                                            firetouchinterest(enemyHrp, handle, 1)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

local savedCFrame = nil
TabCombatVisual:CreateButton({
    Name = GetText("SavePos"),
    Callback = function()
        local _, _, hrp = GetCharacterElements()
        if hrp then savedCFrame = hrp.CFrame Rayfield:Notify({Title = "Success", Content = "Saved Position!", Duration = 2}) end
    end,
})

TabCombatVisual:CreateButton({
    Name = GetText("TPPos"),
    Callback = function()
        local _, _, hrp = GetCharacterElements()
        if savedCFrame and hrp then hrp.CFrame = savedCFrame end
    end,
})

---------------------------------------------------------
-- TAB 4: HIỆU ỨNG & QUAN SÁT
---------------------------------------------------------
TabVisuals:CreateToggle({
    Name = GetText("ESP"),
    CurrentValue = false,
    Callback = function(Value)
        _G.ESP = Value
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local h = p.Character:FindFirstChildOfClass("Highlight")
                if Value then 
                    if not h then Instance.new("Highlight", p.Character) end 
                else 
                    if h and h.Name ~= "MonsterESP" then h:Destroy() end 
                end
            end
        end
    end,
})

-- SỬA LẠI NOCLIP: Chạy mượt tuyệt đối qua Stepped ngăn kẹt tường/văng game
TabVisuals:CreateToggle({
    Name = GetText("Noclip"),
    CurrentValue = false,
    Callback = function(v) _G.Noclip = v end
})

RunService.Stepped:Connect(function()
    if _G.Noclip then
        local char, _, _ = GetCharacterElements()
        if char then
            for _, child in pairs(char:GetChildren()) do
                if child:IsA("BasePart") and child.CanCollide == true then
       
