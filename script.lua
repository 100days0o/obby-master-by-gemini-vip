-- MUTAGEN Universal Troller v1.9.5 - VOID PROTECTION UPDATE
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui") or Player:WaitForChild("PlayerGui")

if CoreGui:FindFirstChild("DarkkHub") then CoreGui.DarkkHub:Destroy() end

-- Cấu hình hệ thống nâng cao
_G.InfJump = false
_G.GodMode = false
_G.InfLife = false
_G.Noclip = false
_G.KillAura = false
_G.FlyActive = false
_G.FlySpeed = 50
_G.CurrentLang = "VI" -- Mặc định chuyển sang tiếng Việt cho bạn dễ dùng

-- Các biến trạng thái của chức năng mới
_G.AntiFling = false
_G.AntiAnchor = false
_G.AutoHeal = false
_G.ShieldMode = false
_G.LoopTripAll = false
_G.SpinBot = false

local SelectedTargetName = ""
local MenuMinimized = false
local LoopBehindActive = false 

-- SCREEN GUI CHÍNH
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DarkkHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- KHUNG CHÍNH CHUẨN MUTAGEN
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 490, 0, 290)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(0, 230, 0) 
MainStroke.Thickness = 1.5

-- THANH TIÊU ĐỀ
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 26)
TitleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TitleBar.BorderSizePixel = 0

local StarIconTitle = Instance.new("TextLabel", TitleBar)
StarIconTitle.Size = UDim2.new(0, 25, 1, 0)
StarIconTitle.Position = UDim2.new(0, 8, 0, 0)
StarIconTitle.BackgroundTransparency = 1
StarIconTitle.Text = "★"
StarIconTitle.TextColor3 = Color3.fromRGB(0, 230, 0)
StarIconTitle.Font = Enum.Font.Code
StarIconTitle.TextSize = 14

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Size = UDim2.new(0.7, 0, 1, 0)
TitleText.Position = UDim2.new(0, 28, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "MUTAGEN Universal Troller v1.9.5"
TitleText.TextColor3 = Color3.fromRGB(0, 230, 0)
TitleText.Font = Enum.Font.Code
TitleText.TextSize = 12
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local MinimizeBtn = Instance.new("TextButton", TitleBar)
MinimizeBtn.Size = UDim2.new(0, 30, 0, 26)
MinimizeBtn.Position = UDim2.new(1, -30, 0, 0)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Text = "▼"
MinimizeBtn.TextColor3 = Color3.fromRGB(0, 230, 0)
MinimizeBtn.Font = Enum.Font.Code
MinimizeBtn.TextSize = 11

-- PHẦN THÂN GIAO DIỆN
local ContentBody = Instance.new("Frame", MainFrame)
ContentBody.Size = UDim2.new(1, 0, 1, -26)
ContentBody.Position = UDim2.new(0, 0, 0, 26)
ContentBody.BackgroundTransparency = 1

-- SIDEBAR DANH MỤC TRÁI
local Sidebar = Instance.new("Frame", ContentBody)
Sidebar.Size = UDim2.new(0, 115, 1, -6)
Sidebar.Position = UDim2.new(0, 4, 0, 3)
Sidebar.BackgroundColor3 = Color3.fromRGB(8, 8, 8)

local SideStroke = Instance.new("UIStroke", Sidebar)
SideStroke.Color = Color3.fromRGB(0, 230, 0)
SideStroke.Thickness = 1

local SideLayout = Instance.new("UIListLayout", Sidebar)
SideLayout.Padding = UDim.new(0, 2)

-- CONTAINER CHỨA TRANG PHẢI
local Container = Instance.new("Frame", ContentBody)
Container.Size = UDim2.new(1, -128, 1, -6)
Container.Position = UDim2.new(0, 123, 0, 3)
Container.BackgroundTransparency = 1

local Pages = {}
local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame", Container)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.CanvasSize = UDim2.new(0, 0, 0, 580)
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Color3.fromRGB(0, 230, 0)
    Page.Visible = false
    
    local PageLayout = Instance.new("UIListLayout", Page)
    PageLayout.Padding = UDim.new(0, 6)
    PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    Pages[name] = Page
    return Page
end

-- KHỞI TẠO CÁC TRANG
local CreditsPage = CreatePage("Credits")
local AllPlayersPage = CreatePage("AllPlayers")
local TargetPage = CreatePage("Target")
local CharacterPage = CreatePage("Character")
local ProtectionPage = CreatePage("Protection")
local SettingsPage = CreatePage("Settings")

-- BỘ TỪ ĐIỂN ĐA NGÔN NGỮ
local Localization = {
    EN = {
        Credits = "Credits", AllPlayers = "All Players", Target = "Target", Character = "Character", Protection = "Protection 🛡️", Settings = "Settings ⚙️",
        Toggles = "Toggles", Advanced = "Advanced Controls", Combat = "Combat or smth", NoTarget = "No target selected",
        InfJump = "Infinite Jump 🚀", Noclip = "Noclip Mode", Fly = "Fly Mode (Bay)", Respawn = "Instant Respawn",
        GodMode = "God Mode ⚡", InfLife = "Infinite Life ❤️", KillAura = "Kill Aura Loop", ChatSpam = "Chat Spam All", ESP = "Server ESP Visuals",
        LangBtn = "Language: English", HelpText = "Click button to switch language",
        AntiFling = "Anti-Fling (Chống văng)", AntiAnchor = "Anti-Anchor (Chống kẹt)", AutoHeal = "Auto-Heal (Tự hồi máu)", Shield = "Shield Mode (Hào quang đẩy)",
        SitMode = "Sit Mode (Ép ngồi)", AntiRagdoll = "Anti-Ragdoll (Đứng vững)", SpinBot = "Spin Bot (Xoay chống ngắm)",
        NakedAll = "Naked All (Xóa đồ)", HeadlessAll = "Headless All (Ẩn đầu)", LoopTrip = "Loop Trip All (Làm ngã)", BringAll = "Bring All (Kéo tất cả)",
        GiveToolsBtn = "Get Mutagen Troller Tools 🎒"
    },
    VI = {
        Credits = "Giới thiệu", AllPlayers = "Mọi người chơi", Target = "Mục tiêu", Character = "Bản thân", Protection = "Bảo vệ 🛡️", Settings = "Cài đặt ⚙️",
        Toggles = "Bật/Tắt chức năng", Advanced = "Điều khiển nâng cao", Combat = "Chế độ Tấn công", NoTarget = "Chưa chọn mục tiêu",
        InfJump = "Nhảy vô hạn 🚀", Noclip = "Đi xuyên tường", Fly = "Chế độ bay tự do", Respawn = "Hồi sinh nhanh chóng",
        GodMode = "Chế độ Bất tử ⚡", InfLife = "Vô hạn máu ❤️", KillAura = "Vòng lặp tự đánh", ChatSpam = "Spam chat toàn Server", ESP = "Bật định vị người chơi",
        LangBtn = "Ngôn ngữ: Tiếng Việt", HelpText = "Bấm nút để thay đổi ngôn ngữ",
        AntiFling = "Chống đẩy văng", AntiAnchor = "Chống server đóng băng", AutoHeal = "Tự động hồi máu nhanh", Shield = "Lá chắn đẩy thực thể",
        SitMode = "Ép nhân vật ngồi", AntiRagdoll = "Bật chống té ngã", SpinBot = "Xoay người né tâm bắn",
        NakedAll = "Lột đồ toàn server", HeadlessAll = "Ẩn đầu toàn server", LoopTrip = "Làm ngã mọi người liên tục", BringAll = "Dịch chuyển tất cả lại đây",
        GiveToolsBtn = "Nhận bộ Công cụ Troller 🎒"
    }
}

local TabButtons = {}
local function CreateTabButton(textKey, pageName)
    local TBtn = Instance.new("TextButton", Sidebar)
    TBtn.Size = UDim2.new(1, 0, 0, 24)
    TBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    TBtn.BorderSizePixel = 0
    TBtn.Text = Localization[_G.CurrentLang][textKey]
    TBtn.TextColor3 = Color3.fromRGB(0, 230, 0)
    TBtn.Font = Enum.Font.Code
    TBtn.TextSize = 10
    
    TBtn.MouseButton1Click:Connect(function()
        for k, p in pairs(Pages) do p.Visible = (k == pageName) end
        for _, b in pairs(Sidebar:GetChildren()) do
            if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(12, 12, 12) end
        end
        TBtn.BackgroundColor3 = Color3.fromRGB(20, 35, 20)
    end)
    TabButtons[pageName] = {Button = TBtn, Key = textKey}
end

CreateTabButton("Credits", "Credits")
CreateTabButton("AllPlayers", "AllPlayers")
CreateTabButton("Target", "Target")
CreateTabButton("Character", "Character")
CreateTabButton("Protection", "Protection")
CreateTabButton("Settings", "Settings")

Pages["Target"].Visible = true 

MinimizeBtn.MouseButton1Click:Connect(function()
    MenuMinimized = not MenuMinimized
    if MenuMinimized then
        ContentBody.Visible = false
        MainFrame:TweenSize(UDim2.new(0, 490, 0, 26), "Out", "Quad", 0.12, true)
        MinimizeBtn.Text = "▲"
    else
        MainFrame:TweenSize(UDim2.new(0, 490, 0, 290), "Out", "Quad", 0.12, true)
        task.wait(0.08)
        ContentBody.Visible = true
        MinimizeBtn.Text = "▼"
    end
end)

------------------------------------------------------------------
-- HÀM TIỆN ÍCH CHO TOGGLE VÀ BUTTON
------------------------------------------------------------------
local ElementsToUpdate = {}

local function AddToggle(parent, textKey, default, callback)
    local State = default
    local Tgl = Instance.new("TextButton", parent)
    Tgl.Size = UDim2.new(1, -10, 0, 26)
    Tgl.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    
    local function updateText()
        local coreText = Localization[_G.CurrentLang][textKey] or textKey
        Tgl.Text = "  " .. coreText .. " -> " .. (State and "ON" or "OFF")
    end
    updateText()
    
    Tgl.TextColor3 = Color3.fromRGB(0, 230, 0)
    Tgl.Font = Enum.Font.Code
    Tgl.TextSize = 11
    Tgl.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UIStroke", Tgl).Color = Color3.fromRGB(30, 30, 30)
    
    Tgl.MouseButton1Click:Connect(function()
        State = not State
        updateText()
        callback(State)
    end)
    
    table.insert(ElementsToUpdate, {Type = "Toggle", Element = Tgl, Key = textKey, GetState = function() return State end})
end

local function AddButton(parent, textKey, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1, -10, 0, 26)
    Btn.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Btn.Text = "  " .. (Localization[_G.CurrentLang][textKey] or textKey)
    Btn.TextColor3 = Color3.fromRGB(0, 230, 0)
    Btn.Font = Enum.Font.Code
    Btn.TextSize = 11
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UIStroke", Btn).Color = Color3.fromRGB(30, 30, 30)
    Btn.MouseButton1Click:Connect(callback)
    
    table.insert(ElementsToUpdate, {Type = "Button", Element = Btn, Key = textKey})
end

local function CreateGridButton(parent, text, sizeX, posX, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(sizeX, -4, 1, 0)
    btn.Position = UDim2.new(posX, 0, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(0, 230, 0)
    btn.Font = Enum.Font.Code
    btn.TextSize = 10
    Instance.new("UIStroke", btn).Color = Color3.fromRGB(30, 30, 30)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function CreateSectionLabel(parent, textKey, color)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Size = UDim2.new(1, -10, 0, 15)
    lbl.BackgroundTransparency = 1
    lbl.Text = Localization[_G.CurrentLang][textKey] or textKey
    lbl.TextColor3 = color
    lbl.Font = Enum.Font.Code
    lbl.TextSize = 11
    table.insert(ElementsToUpdate, {Type = "Label", Element = lbl, Key = textKey})
    return lbl
end

------------------------------------------------------------------
-- ⚡ HỆ THỐNG CẤP PHÁT TOOLS (CÓ RAYCAST AN TOÀN CHỐNG VOID)
------------------------------------------------------------------
local function SupplyMutagenTools()
    local backpack = Player:WaitForChild("Backpack")
    
    -- 1. Chạy nhanh Tool
    if not backpack:FindFirstChild("⚡ Speed Tool") and not (Player.Character and Player.Character:FindFirstChild("⚡ Speed Tool")) then
        local Tool = Instance.new("Tool")
        Tool.Name = "⚡ Speed Tool"
        Tool.RequiresHandle = false
        Tool.Equipped:Connect(function()
            local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = 120 end
        end)
        Tool.Unequipped:Connect(function()
            local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = 16 end
        end)
        Tool.Parent = backpack
    end

    -- 2. Nhảy cao Tool
    if not backpack:FindFirstChild("🦘 Jump Tool") and not (Player.Character and Player.Character:FindFirstChild("🦘 Jump Tool")) then
        local Tool = Instance.new("Tool")
        Tool.Name = "🦘 Jump Tool"
        Tool.RequiresHandle = false
        Tool.Equipped:Connect(function()
            local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
            if hum then 
                hum.UseJumpPower = true
                hum.JumpPower = 160 
            end
        end)
        Tool.Unequipped:Connect(function()
            local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
            if hum then 
                hum.UseJumpPower = true
                hum.JumpPower = 50 
            end
        end)
        Tool.Parent = backpack
    end

    -- 3. Teleport Tool (ĐÃ THÊM: Quét khối đỡ chân chống nhảy xuống Void)
    if not backpack:FindFirstChild("📍 Teleport Tool") and not (Player.Character and Player.Character:FindFirstChild("📍 Teleport Tool")) then
        local Tool = Instance.new("Tool")
        Tool.Name = "📍 Teleport Tool"
        Tool.RequiresHandle = false
        Tool.Activated:Connect(function()
            local mouse = Player:GetMouse()
            local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
            if hrp and mouse.Hit then
                local targetPos = mouse.Hit.Position
                
                -- Tạo cấu hình Raycast lọc bỏ bản thân người chơi để không quét nhầm vào cơ thể mình
                local raycastParams = RaycastParams.new()
                raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                raycastParams.FilterDescendantsInstances = {Player.Character}
                raycastParams.IgnoreWater = true
                
                -- Bắn một tia từ vị trí click chuột hướng thẳng xuống dưới 40 block để check sàn nhà
                local rayOrigin = targetPos + Vector3.new(0, 5, 0)
                local rayDirection = Vector3.new(0, -45, 0)
                local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
                
                -- Nếu tia chạm trúng một block cứng (Sàn, Part, Địa hình) thì mới thực hiện dịch chuyển an toàn
                if raycastResult and raycastResult.Instance then
                    hrp.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
                else
                    -- Không tìm thấy block đỡ chân (Phía dưới là khoảng không/Void) -> Cảnh báo
                    local bill = Instance.new("BillboardGui")
                    bill.Size = UDim2.new(0, 150, 0, 30)
                    bill.AlwaysOnTop = true
                    
                    local lbl = Instance.new("TextLabel", bill)
                    lbl.Size = UDim2.new(1, 0, 1, 0)
                    lbl.BackgroundTransparency = 1
                    lbl.Text = "⚠️ VOID DETECTED! TP BLOCKED"
                    lbl.TextColor3 = Color3.fromRGB(255, 0, 0)
                    lbl.Font = Enum.Font.Code
                    lbl.TextSize = 10
                    
                    if Player.Character and Player.Character:FindFirstChild("Head") then
                        bill.Parent = Player.Character.Head
                        bill.Adornee = Player.Character.Head
                        bill.StudsOffset = Vector3.new(0, 3, 0)
                        task.delay(1.5, function() bill:Destroy() end)
                    end
                end
            end
        end)
        Tool.Parent = backpack
    end

    -- 4. Building Tools (F3X)
    if not backpack:FindFirstChild("Building Tools") and not (Player.Character and Player.Character:FindFirstChild("Building Tools")) then
        task.spawn(function()
            local f3x = game:GetObjects("rbxassetid://142273772")[1]
            if f3x then
                f3x.Parent = backpack
            end
        end)
    end
end

-- Tự động cấp lại tool khi nhân vật hồi sinh
Player.CharacterAdded:Connect(function()
    task.wait(0.5)
    SupplyMutagenTools()
end)
SupplyMutagenTools()

------------------------------------------------------------------
-- 🟢 TAB 1: TARGET 
------------------------------------------------------------------
local SearchFrame = Instance.new("Frame", TargetPage)
SearchFrame.Size = UDim2.new(1, -10, 0, 28)
SearchFrame.BackgroundTransparency = 1

local TextBox = Instance.new("TextBox", SearchFrame)
TextBox.Size = UDim2.new(0.7, -4, 1, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TextBox.Text = ""
TextBox.PlaceholderText = "Enter player name"
TextBox.TextColor3 = Color3.fromRGB(0, 230, 0)
TextBox.Font = Enum.Font.Code
TextBox.TextSize = 11
Instance.new("UIStroke", TextBox).Color = Color3.fromRGB(30, 30, 30)

local ClickTargetBtn = Instance.new("TextButton", SearchFrame)
ClickTargetBtn.Size = UDim2.new(0.3, 0, 1, 0)
ClickTargetBtn.Position = UDim2.new(0.7, 0, 0, 0)
ClickTargetBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ClickTargetBtn.Text = "Click Target"
ClickTargetBtn.TextColor3 = Color3.fromRGB(0, 230, 0)
ClickTargetBtn.Font = Enum.Font.Code
ClickTargetBtn.TextSize = 11
Instance.new("UIStroke", ClickTargetBtn).Color = Color3.fromRGB(0, 180, 0)

local InfoLabel = Instance.new("TextLabel", TargetPage)
InfoLabel.Size = UDim2.new(1, -10, 0, 18)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = Localization[_G.CurrentLang]["NoTarget"]
InfoLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
InfoLabel.Font = Enum.Font.Code
InfoLabel.TextSize = 11

local ProfileFrame = Instance.new("Frame", TargetPage)
ProfileFrame.Size = UDim2.new(1, -10, 0, 85)
ProfileFrame.BackgroundTransparency = 1

local VictimBox = Instance.new("Frame", ProfileFrame)
VictimBox.Size = UDim2.new(0, 75, 0, 85)
VictimBox.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Instance.new("UIStroke", VictimBox).Color = Color3.fromRGB(30, 30, 30)

local SkullText = Instance.new("TextLabel", VictimBox)
SkullText.Size = UDim2.new(1, 0, 0, 14)
SkullText.BackgroundTransparency = 1
SkullText.Text = "Victim"
SkullText.TextColor3 = Color3.fromRGB(0, 230, 0)
SkullText.Font = Enum.Font.Code
SkullText.TextSize = 10

local MemeImage = Instance.new("ImageLabel", VictimBox)
MemeImage.Size = UDim2.new(0, 65, 0, 52)
MemeImage.Position = UDim2.new(0, 5, 0, 15)
MemeImage.Image = "rbxassetid://15622142270"
MemeImage.BorderSizePixel = 0

local RussianLabel = Instance.new("TextLabel", VictimBox)
RussianLabel.Size = UDim2.new(1, 0, 0, 14)
RussianLabel.Position = UDim2.new(0, 0, 1, -14)
RussianLabel.BackgroundTransparency = 1
RussianLabel.Text = "Сейчас же"
RussianLabel.TextColor3 = Color3.fromRGB(200, 0, 0)
RussianLabel.Font = Enum.Font.Code
RussianLabel.TextSize = 9

local InfoRightFrame = Instance.new("Frame", ProfileFrame)
InfoRightFrame.Size = UDim2.new(1, -85, 1, 0)
InfoRightFrame.Position = UDim2.new(0, 85, 0, 0)
InfoRightFrame.BackgroundTransparency = 1

local TitleRight = Instance.new("TextLabel", InfoRightFrame)
TitleRight.Size = UDim2.new(1, 0, 0, 15)
TitleRight.BackgroundTransparency = 1
TitleRight.Text = "Target Info"
TitleRight.TextColor3 = Color3.fromRGB(0, 230, 0)
TitleRight.Font = Enum.Font.Code
TitleRight.TextSize = 11
TitleRight.TextXAlignment = Enum.TextXAlignment.Left

local DescRight = Instance.new("TextLabel", InfoRightFrame)
DescRight.Size = UDim2.new(1, 0, 1, -15)
DescRight.Position = UDim2.new(0, 0, 0, 15)
DescRight.BackgroundTransparency = 1
DescRight.Text = "ID: N/A\nJoined: N/A\nAccount Age: N/A"
DescRight.TextColor3 = Color3.fromRGB(0, 180, 0)
DescRight.Font = Enum.Font.Code
DescRight.TextSize = 10
DescRight.TextXAlignment = Enum.TextXAlignment.Left

TextBox:GetPropertyChangedSignal("Text"):Connect(function()
    local currentText = string.lower(TextBox.Text)
    if currentText ~= "" and not string.find(currentText, "selected:") then
        local found = false
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= Player then
                if string.sub(string.lower(p.Name), 1, string.len(currentText)) == currentText or 
                   string.sub(string.lower(p.DisplayNam
