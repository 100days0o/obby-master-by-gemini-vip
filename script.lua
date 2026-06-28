-- ====================================================
-- OBBY MASTER SCRIPT V1 - DARKK HUB - VIP EDITION (ULTIMATE SCANNER)
-- ====================================================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Các từ khóa đích đến (được mở rộng để quét kỹ nhất có thể)
local FinishKeywords = {"finish", "end", "win", "victory", "goal", "stageclear", "obbyend", "winner"}

-- Hàm quét kỹ (Deep-Scan)
local function DeepScanTeleport()
    local targetPart = nil
    
    -- Quét toàn bộ Descendants của Workspace
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            local name = v.Name:lower()
            -- Kiểm tra từ khóa
            for _, keyword in pairs(FinishKeywords) do
                if name:find(keyword) then
                    -- Kiểm tra thêm: Nếu nó là một vật thể có kích thước lớn 
                    -- hoặc có TouchInterest (thường là điểm chạm đích)
                    if v:FindFirstChild("TouchInterest") or v.Size.Magnitude > 2 then
                        targetPart = v
                        break
                    end
                end
            end
        end
        if targetPart then break end
    end

    -- Thực hiện Teleport an toàn
    if targetPart then
        local HRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if HRP then
            HRP.CFrame = targetPart.CFrame + Vector3.new(0, 3, 0) -- Teleport trên bề mặt đích 3 stud
            Rayfield:Notify({Title="Success", Content="Đã tìm thấy đích và teleport!", Duration=3})
        end
    else
        Rayfield:Notify({Title="Error", Content="Không tìm thấy đích (vật thể đích quá lạ).", Duration=3})
    end
end

-- ====================================================
-- CẬP NHẬT TAB OBBY VỚI CƠ CHẾ QUÉT MỚI
-- ====================================================
local ObbyTab = Window:CreateTab("Obby", 4483362458)

ObbyTab:CreateButton({
    Name = "Teleport to Finish (Deep Scan)", 
    Callback = function() 
        DeepScanTeleport() 
    end
})

ObbyTab:CreateButton({
    Name = "Auto Checkpoint Touch (Scan All)", 
    Callback = function()
        for _, v in pairs(workspace:GetDescendants()) do 
            if v:IsA("SpawnLocation") or v.Name:lower():find("checkpoint") then 
                LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 2, 0)
                task.wait(0.2) -- Đợi load
            end 
        end
    end
})
