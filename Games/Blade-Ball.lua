loadstring(game:HttpGet("https://raw.githubusercontent.com/CkMScripts/HubBuild/main/Extras/Global.lua"))()
VG.DisableConnection(Error)
VG.DisableConnection(Idled)
local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(...)
    local Args = {...}
    if tostring(Self) == "" and Self.ClassName == "RemoteEvent" and getnamecallmethod() == "FireServer" then
        return
    end
    return OldNameCall(...)
end)
local Balls = VG.FFD(Workspace, "Balls")
print(Balls)
for i,v in next, getgc() do
    if type(v) == "function" then
        if debug.getinfo(v).name == "parry" then
            Parry = v
        end
    end
end
IsReal = function()
    local Re
    for i,v in next, Balls:GetChildren() do
        if v:GetAttribute("realBall") and v:GetAttribute("target") == Player.Name and not v.Anchored then
            Re = v
        end
    end
    return Re
end
Baller = function()
    local Real = nil
    for i,v in next, Balls:GetChildren() do
        if v:GetAttribute("realBall") then
            Real = v
        end
    end
    return Real
end
GetPlayerC = function()
    local Max, Target, Players = math.huge, nil, Players
    for i,v in next, Players:GetPlayers() do
        if v ~= Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local Mag = VG.Mag(Player.Character:GetModelCFrame(), v.Character:GetModelCFrame())
            if Mag <= Max then
                Target = v
            end
        end
    end
    return Target
end
Meth = function()
    if Method == "KeyPress" then
        keypress(0x46)
        keyrelease(0x46)
    elseif Method == "Remote" then
        ReplicatedStorage.Remotes.ParryButtonPress:Fire()
    elseif Method == "Function" then
        Parry()
    end
end
Hit = function()
    local Ball, Clash = IsReal(), true
    if Ball then
        local M = VG.Mag(Ball.CFrame, Player.Character.HumanoidRootPart.CFrame)
        local M2 = Ball.Velocity.Magnitude
        local M3 = M2 * (game.Stats.Network.ServerStatsItem["Data Ping"]:GetValue() / 1000)
        M2 -= M3
        print(M / M2)
        if Hate and not Loser then
            Player.Character.HumanoidRootPart.CFrame = CFrame.lookAt(Player.Character.HumanoidRootPart.CFrame.Position, Vector3.new(Ball.Position.X, Player.Character.HumanoidRootPart.CFrame.Position.Y, Ball.Position.Z))
        end
        if (M / M2 < 0.19 or M / M2 > 9e9 and M < 11.25) and not Clash then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(Ball.CFrame.Position + Vector3.new(math.random(1,5),0,math.random(1,5)))
        end
        if M / M2 <= 0.5 then

            Meth()
            if VG.Mag(GetPlayerC().Character:GetModelCFrame(), Player.Character:GetModelCFrame()) <= 7 then
                for i=1, 5 do
                    Clash = false
                    Hit()
                end
            end
        end
    end
end
JustHit = function()
    local Ball = IsReal()
    if Ball then
        local Old = Player.Character.HumanoidRootPart.CFrame
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(Ball.Position + Vector3.new(10,-0,10))
        Meth()
        wait()
        Player.Character.HumanoidRootPart.CFrame = Old
    end
end
FreezeHit = function()
    local Old = Player.Character.HumanoidRootPart.CFrame
    local Ball = IsReal()
    if Ball then
        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Freeze"):FireServer()
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(Ball.Position + Vector3.new(0,-10,0))
        wait()
        Meth()
        Player.Character.HumanoidRootPart.CFrame = Old
    end
end

PreSimulation:Connect(function()
    if lookAtBall then
        Workspace.CurrentCamera.CFrame = CFrame.lookAt(Workspace.CurrentCamera.CFrame.Position, Baller().CFrame.Position)
    end
    if Sword then
        ReplicatedStorage.Remote.RemoteFunction:InvokeServer("PromptPurchaseCrate", Workspace.Spawn.Crates.NormalSwordCrate)
    end
    if Explode then
        ReplicatedStorage.Remote.RemoteFunction:InvokeServer("PromptPurchaseCrate",Workspace.Spawn.Crates.NormalExplosionCrate)
    end
    if Sprint then
        Player.Character.Humanoid.WalkSpeed = 70
    end
    if Hate then
        if MethodHit:find("Legit") then
            Hit()
        end
    end
    if Loser then
        local Ball = Baller()
        JustHit()
        if Ball and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character.Parent.Name == "Alive" then
            for i=1, 50 do
                VG.NoClip()
                Player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(Ball.Position.X, Workspace.Map:FindFirstChild('BALLSPAWN',true).Position.Y + -10, Ball.Position.Z))
            end
        end
    end
end)
spawn(function()
    while wait() and Hate do
        pcall(function()
            if MethodHit:find("Blatant") then
                JustHit()
            elseif MethodHit:find("Insane") then
                FreezeHit()
            end
        end)
    end
end)

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/CkMScripts/HubBuild/main/Fluent/Main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/CkMScripts/HubBuild/main/Fluent/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/CkMScripts/HubBuild/main/Fluent/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "CkM Hub: Game " .. MarketplaceService:GetProductInfo(game.PlaceId).Name,
    SubTitle = "by CkMScripts",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.Delete -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

do
    Fluent:Notify({
        Title = "CkM Hub Loaded",
        Content = "Congrats your using CkM Hub " .. Verison,
        SubContent = "", -- Optional
        Duration = 10 -- Set to nil to make the notification not disappear
    })

    local Toggle = Tabs.Main:AddToggle("Parry", {Title = "Auto Parry", Default = false})
    Toggle:OnChanged(function()
        Hate = Options.Parry.Value
    end)
    local Dropdown = Tabs.Main:AddDropdown("LOL", {Title = "Parry Method",Values = {"KeyPress", "Remote", "Function"},Multi = false,Default = 1,})

    Dropdown:OnChanged(function(Value)
        Method = Value
    end)
    
    local Dropdown = Tabs.Main:AddDropdown("Players", {Title = "Farm Method",Values = {"Legit (Sucks)", "Blatant (hacker mode)", "Insane (need Freeze Ability)"},Multi = false,Default = 1,})
    Dropdown:OnChanged(function(Value)
        MethodHit  = Value
    end)
    local Toggle = Tabs.Main:AddToggle("Autofarm", {Title = "AutoFarm", Default = false})
    Toggle:OnChanged(function()
        Loser = Options.Autofarm.Value
    end)
    local Toggle = Tabs.Main:AddToggle("Sprint", {Title = "Auto Sprint", Default = false})
    Toggle:OnChanged(function()
        Sprint = Options.Sprint.Value
    end)
    local Toggle = Tabs.Main:AddToggle("Explode", {Title = "Auto Open Explode", Default = false})
    Toggle:OnChanged(function()
        Explode = Options.Explode.Value
    end)
    local Toggle = Tabs.Main:AddToggle("Explode", {Title = "Auto Open Explode", Default = false})
    Toggle:OnChanged(function()
        Explode = Options.Explode.Value
    end)
    local Toggle = Tabs.Main:AddToggle("Sword", {Title = "Auto Open Sword", Default = false})
    Toggle:OnChanged(function()
        Sword = Options.Sword.Value
    end)
    local Toggle = Tabs.Main:AddToggle("lookAtBall", {Title = "Auto Look At Ball", Default = false})
    Toggle:OnChanged(function()
        lookAtBall = Options.lookAtBall.Value
    end)
end
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "CkM Hub",
    Content = "The script has been loaded.",
    Duration = 8
})

SaveManager:LoadAutoloadConfig()
