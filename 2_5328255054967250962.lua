--[[
    ⚡ AURA VISUALS (AV) ULTIMATE EDITION
    💎 Style: Purple Neon / Minimalist
    📱 Executor: Delta / Mobile Optimized
]]

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Удаление старого UI
if CoreGui:FindFirstChild("AV_MasterUI") then CoreGui.AV_MasterUI:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AV_MasterUI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local ThemeColor = Color3.fromRGB(168, 85, 247) -- Наш основной фиолетовый

-- ==================== [ ПЛАВАЮЩАЯ КНОПКА AV ] ====================
local DragButton = Instance.new("Frame")
DragButton.Size = UDim2.new(0, 50, 0, 50)
DragButton.Position = UDim2.new(0, 10, 0.5, 0)
DragButton.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
DragButton.Active = true
DragButton.Draggable = true
DragButton.Parent = ScreenGui
Instance.new("UICorner", DragButton).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", DragButton).Color = ThemeColor

local AvText = Instance.new("TextButton")
AvText.Size = UDim2.new(1, 0, 1, 0)
AvText.BackgroundTransparency = 1
AvText.Text = "AV"
AvText.TextColor3 = ThemeColor
AvText.TextSize = 18
AvText.Font = Enum.Font.GothamBold
AvText.Parent = DragButton

-- ==================== [ ГЛАВНОЕ МЕНЮ ] ====================
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 7, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = ThemeColor
MainStroke.Thickness = 2

-- Сайдбар (Вкладки)
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 130, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 12, 22)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

local TabContainer = Instance.new("ScrollingFrame")
TabContainer.Size = UDim2.new(1, 0, 1, -50)
TabContainer.Position = UDim2.new(0, 0, 0, 40)
TabContainer.BackgroundTransparency = 1
TabContainer.ScrollBarThickness = 0
TabContainer.Parent = Sidebar

local UIList = Instance.new("UIListLayout", TabContainer)
UIList.Padding = UDim.new(0, 5)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Область контента
local Pages = Instance.new("Frame")
Pages.Size = UDim2.new(1, -140, 1, -20)
Pages.Position = UDim2.new(0, 135, 0, 10)
Pages.BackgroundTransparency = 1
Pages.Parent = MainFrame

-- Функции открытия/закрытия
AvText.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- ==================== [ СИСТЕМА ВКЛАДОК ] ====================
local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 2
    Page.CanvasSize = UDim2.new(0,0,0,1000)
    Page.Parent = Pages
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 8)
    
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(0, 110, 0, 35)
    TabBtn.BackgroundColor3 = Color3.fromRGB(25, 20, 35)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.TextSize = 12
    TabBtn.Parent = TabContainer
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages:GetChildren()) do p.Visible = false end
        Page.Visible = true
        for _, b in pairs(TabContainer:GetChildren()) do 
            if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(25, 20, 35) end
        end
        TabBtn.BackgroundColor3 = ThemeColor
    end)
    
    return Page
end

local PagePlayer = CreatePage("👤 PLAYER")
local PageWorld = CreatePage("🌌 WORLD")
local PageVisuals = CreatePage("✨ COSMETICS")
local PageSettings = CreatePage("⚙️ SETTINGS")

PagePlayer.Visible = true -- Первая страница активна

-- ==================== [ ФУНКЦИИ КОНСТРУКТОРА UI ] ====================
local function AddToggle(parent, text, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -10, 0, 40)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
    Frame.Parent = parent
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -50, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255,255,255)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.Parent = Frame
    
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 34, 0, 20)
    Btn.Position = UDim2.new(1, -44, 0.5, -10)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 35, 55)
    Btn.Text = ""
    Btn.Parent = Frame
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)
    
    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 14, 0, 14)
    Circle.Position = UDim2.new(0, 3, 0.5, -7)
    Circle.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Circle.Parent = Btn
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)
    
    local state = false
    Btn.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = state and ThemeColor or Color3.fromRGB(40, 35, 55)}):Play()
        Circle:TweenPosition(state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7), "Out", "Quad", 0.2, true)
        callback(state)
    end)
end

-- ==================== [ WORLD: КОСМОС И ЧЕРНАЯ ДЫРА ] ====================
AddToggle(PageWorld, "🌌 Cosmic Night (Космос)", function(v)
    if v then
        Lighting.ClockTime = 0
        local Sky = Instance.new("Sky", Lighting)
        Sky.Name = "AuraSky"
        Sky.SkyboxBk = "rbxassetid://159454299"
        Sky.SkyboxDn = "rbxassetid://159454296"
        Sky.SkyboxFt = "rbxassetid://159454293"
        Sky.SkyboxLf = "rbxassetid://159454286"
        Sky.SkyboxRt = "rbxassetid://159454300"
        Sky.SkyboxUp = "rbxassetid://159454288"
        Sky.SunTextureId = "rbxassetid://60024407"
    else
        if Lighting:FindFirstChild("AuraSky") then Lighting.AuraSky:Destroy() end
        Lighting.ClockTime = 14
    end
end)

AddToggle(PageWorld, "🌑 TON 618 (Черная дыра)", function(v)
    if v then
        local Part = Instance.new("Part", workspace)
        Part.Name = "TON618"
        Part.Shape = "Ball"
        Part.Size = Vector3.new(500, 500, 500)
        Part.Position = Vector3.new(0, 1000, 0)
        Part.Anchored = true
        Part.CanCollide = false
        Part.Color = Color3.fromRGB(0, 0, 0)
        Part.Material = Enum.Material.Neon
        
        local Particle = Instance.new("ParticleEmitter", Part)
        Particle.Texture = "rbxassetid://258128463"
        Particle.Size = NumberSequence.new(50)
        Particle.Rate = 200
        Particle.Speed = NumberRange.new(50, 100)
        Particle.Color = ColorSequence.new(ThemeColor)
    else
        if workspace:FindFirstChild("TON618") then workspace.TON618:Destroy() end
    end
end)

AddToggle(PageWorld, "❄️ Snow Weather (Снег)", function(v)
    if v then
        local Snow = Instance.new("ParticleEmitter", LocalPlayer.Character.Head)
        Snow.Name = "AuraSnow"
        Snow.Texture = "rbxassetid://242278549"
        Snow.Rate = 100
        Snow.Speed = NumberRange.new(10, 20)
        Snow.Size = NumberSequence.new(0.5)
        Snow.EmissionDirection = "Bottom"
    else
        if LocalPlayer.Character.Head:FindFirstChild("AuraSnow") then LocalPlayer.Character.Head.AuraSnow:Destroy() end
    end
end)

-- ==================== [ PLAYER: ФУНКЦИИ ] ====================
AddToggle(PagePlayer, "🚀 Fly (Полет)", function(v)
    local bv = Instance.new("BodyVelocity")
    if v then
        bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        bv.Velocity = Vector3.new(0,0,0)
        bv.Parent = LocalPlayer.Character.HumanoidRootPart
        task.spawn(function()
            while v and task.wait() do
                bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 100
            end
        end)
    else
        for _, x in pairs(LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
            if x:IsA("BodyVelocity") then x:Destroy() end
        end
    end
end)

AddToggle(PagePlayer, "👻 Noclip (Сквозь стены)", function(v)
    RunService.Stepped:Connect(function()
        if v then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
end)

AddToggle(PagePlayer, "🌈 Rainbow Body (Радужное тело)", function(v)
    task.spawn(function()
        while v and task.wait() do
            local hue = tick() % 5 / 5
            local color = Color3.fromHSV(hue, 1, 1)
            for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then part.Color = color end
            end
        end
    end)
end)

-- ==================== [ COSMETICS ] ====================
AddToggle(PageVisuals, "😇 Holy Halo (Нимб)", function(v)
    if v then
        local p = Instance.new("Part", LocalPlayer.Character)
        p.Name = "AuraHalo"
        p.Size = Vector3.new(1, 0.1, 1)
        p.CanCollide = false
        p.Material = "Neon"
        p.Color = ThemeColor
        local w = Instance.new("Weld", p)
        w.Part0 = p
        w.Part1 = LocalPlayer.Character.Head
        w.C0 = CFrame.new(0, -1, 0)
        Instance.new("SpecialMesh", p).MeshType = "Torus"
    else
        if LocalPlayer.Character:FindFirstChild("AuraHalo") then LocalPlayer.Character.AuraHalo:Destroy() end
    end
end)

-- Уведомление в консоль
print("⚡ Aura Visuals (AV) Loaded! Theme: Purple Neon.")