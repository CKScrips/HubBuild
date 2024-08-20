

UserInputService.InputBegan:Connect(function(Input, GPE)
    if Input.KeyCode == Enum.KeyCode.LeftShift and Sp then
        VG.IsA(Player.Character, "Humanoid").WalkSpeed = 25
    end
end)
UserInputService.InputEnded:Connect(function(Input, GPE)
    if Input.KeyCode == Enum.KeyCode.LeftShift and Sp then
        VG.IsA(Player.Character, "Humanoid").WalkSpeed = 16
    end
end)

for i,v in next, getgc(true) do
    if type(v) == "table" then
        if rawget(v, "Emotes") then
            Emotes = v.Emotes
        end
    end
end
local New = {}
for i,v in next, Emotes do
    if not table.find(New, i) and not rawget(v, "Type") then
        table.insert(New, i)
    end
end


local GetRole = function(Role, True)
    local Target = nil
    local Table = game:GetService("ReplicatedStorage").Remotes.Extras.GetPlayerData:InvokeServer()
    for i,v in next, Table do
        if v.Role == Role and not True then
            Target = i
        elseif True and v.Role == "Innocent" and i == Player.Name then
            Target = i
        end
    end
    return Target
end
local KillAll = function(v)
    if GetRole("Murderer", false) == Player.Name then
        if VG.GetTool("Knife") then
            VG.GetTool("Knife")
        elseif VG.FFD(Player.PlayerGui, "CashBag").Visible then
            VG.Teleport(Vector3.new(0,90000000000,0))
            Player.Character.Knife.Stab:FireServer("Slash")
            firetouchinterest(v.Character.HumanoidRootPart, Player.Character.Knife.Handle, 1)
            firetouchinterest(v.Character.HumanoidRootPart, Player.Character.Knife.Handle, 0)
        end
    end
end

local ShootMurderer = function(v)
    if (GetRole("Sheriff", false) == Player.Name or GetRole("Hero", false) == Player.Name) and VG.FFD(Player.PlayerGui, "CashBag").Visible then
        if GetRole("Murderer", false) == v.Name then
            VG.GetTool("Gun")
            VG.Teleport(Player.Character:GetModelCFrame().Position + Vector3.new(0,0,5))
            Player.Character.Gun.KnifeServer.ShootGun:InvokeServer(1, VG.GetPosition(v.Character), "AH")
            VG.Teleport(Vector3.new(0,500000,0))
        end
    end
end
local CollectCoin = function()
    if GetRole("Innocent", true) == Player.Name then
        local Map = VG.FFD(Workspace, "CoinContainer")
        if Map then
            if VG.FFD(Player.PlayerGui, "CoinBags") and VG.FFD(Player.PlayerGui, "CoinBags").Visible then
                for i, v in next, Map:GetChildren() do
                    if v.Name == "Coin_Server" then
                        VG.Teleport(v.Position)
                        wait(1)
                        VG.Teleport(Vector3.new(0,500000,0))
                        wait(3)
                    end
                end
            end
        end
    end
end

local Trade = function(Player)
    ReplicatedStorage.Trade.SendRequest:InvokeServer(Player)
end

local ForceTrade = function(Player)
    Trade(Player)
    ReplicatedStorage.Trade.AcceptRequest:FireServer()
end

local Trap = function(CFrame)
    ReplicatedStorage.TrapSystem.PlaceTrap:InvokeServer(CFrame)
end
local Version = {}
local Rules = {
    ["Murderer"] = Color3.new(255,0,0),
    ["Innocent"] = Color3.new(0,255,0),
    ["Hero"] = Color3.new(255, 255, 0),
    ["Sheriff"] = Color3.new(0, 0, 255),
}

local Help = function(v)
    local H = Instance.new("Highlight")
    H.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    H.FillColor = Color3.new(0,255,0)
    Version[v] = H
    H.Parent = v.Character
    local function Help2(v)
        H.Adornee = v
    end

    v.CharacterAdded:Connect(Help2)
    do
        if v.Character then
            Help2(v.Character)
        end
    end
end

local Update = function(v)
    local H = Version[v]
    if v.Name == GetRole("Murderer") then
        H.FillColor = Rules["Murderer"]
    end
    if v.Name == GetRole("Hero") then
        H.FillColor = Rules["Hero"]
    end
    if v.Name == GetRole("Sheriff") then
        H.FillColor = Rules["Sheriff"]
    end
    if v.Name == GetRole("Innocent") then
        H.FillColor = Rules["Innocent"]
    end
end

local Rules = {
    ["Murderer"] = Color3.new(255,0,0),
    ["Innocent"] = Color3.new(0,255,0),
    ["Hero"] = Color3.new(255, 255, 0),
    ["Sheriff"] = Color3.new(0, 0, 255),
}
spawn(function()
    while wait() do
        pcall(function()
            for i, v in next, Players:GetPlayers() do
                if v ~= Player then
                    local h = v.Character:FindFirstChildWhichIsA("Highlight")
                    if not h and ESP then
                        Help(v)
                    end
                    if h and ESP then
                        Update(v)
                    end
                    if h and not ESP then
                        h:Destroy()
                    end
                end
            end
        end)
    end
end)

spawn(function()
    while wait() do
        pcall(function()
            if Num then 
                CollectCoin()
            end
            if Kill then
                for i,v in next, Players:GetPlayers() do
                    if v ~= Player then
                        KillAll(v)
                    end
                end
            end
        end)
    end
end)

Stepped:Connect(function()
    if Num then VG.NoClip() end
    if d2 then
        for i,v in next, Players:GetPlayers() do
            if v ~= Player then
                ShootMurderer(v)
            end
        end
    end

    if S1 then
        VG.Teleport(Workspace:FindFirstChild("GunDrop").Position)
    end
    if Trap1 then
        Trap(CFrame.new(Players[hacker].Character:GetModelCFrame().Position))
    end
    if TradeFor then
        Trade(Players[Person])
    end
    if ForceTrades then
        ForceTrade(Players[Person])
    end
end)
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "V.G Hub: Game " .. MarketplaceService:GetProductInfo(game.PlaceId).Name,
    SubTitle = "by DekuDimz",
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
        Title = "V.G Hub Loaded",
        Content = "Congrats your using V.G Hub " .. Verison,
        SubContent = "", -- Optional
        Duration = 10 -- Set to nil to make the notification not disappear
    })

    local Toggle = Tabs.Main:AddToggle("Sprint", {Title = "Toggle Sprint", Default = false})
    Toggle:OnChanged(function()
        Sp = Options.Sprint.Value
    end)
    Options.Sprint:SetValue(false)
    Tabs.Main:AddButton({Title = "Blurt Roles",Description = "Says Roles of Murderer and Sheriff if you are either will pick random player to say is that role you are currently",Callback = function()
        if GetRole("Murderer", false) ~= Player.Name then
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(GetRole("Murderer", false) .. " is the Murderer","normalchat")
        elseif GetRole("Murderer", false) == Player.Name then
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(tostring(Players:GetPlayers()[math.random(1, #Players:GetPlayers())]) .. " is the Murderer","normalchat")
        end
        if GetRole("Sheriff", false) ~= Player.Name then
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(GetRole("Sheriff", false) .. " is the Sheriff","normalchat")
        elseif GetRole("Sheriff", false) == Player.Name then
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(tostring(Players:GetPlayers()[math.random(1, #Players:GetPlayers())]) .. " is the Sheriff","normalchat")
        end
    end})
    local Toggle = Tabs.Main:AddToggle("Shot", {Title = "Shoot Murderer", Default = false})
    Toggle:OnChanged(function()
        d2 = Options.Shot.Value
    end)
    Options.Shot:SetValue(false)

    local Toggle = Tabs.Main:AddToggle("Shot2", {Title = "Kill All", Default = false})
    Toggle:OnChanged(function()
        Kill = Options.Shot2.Value
    end)
    Options.Shot2:SetValue(false)

    local Toggle = Tabs.Main:AddToggle("Lol", {Title = "Auto Collect Coins", Default = false})
    Toggle:OnChanged(function()
        Num = Options.Lol.Value
    end)
    Options.Lol:SetValue(false)

    local Toggle = Tabs.Main:AddToggle("FuckOff", {Title = "Force Trade User", Default = false})
    Toggle:OnChanged(function()
        ForceTrades = Options.FuckOff.Value
    end)
    Options.FuckOff:SetValue(false)

    local Toggle = Tabs.Main:AddToggle("asjkdhj", {Title = "Auto Grab Gun", Default = false})
    Toggle:OnChanged(function()
        S1 = Options.asjkdhj.Value
    end)
    Options.asjkdhj:SetValue(false)

    local Toggle = Tabs.Main:AddToggle("Rough", {Title = "Auto Trap Player", Default = false})
    Toggle:OnChanged(function()
        Trap1 = Options.Rough.Value
    end)
    Options.Rough:SetValue(false)
   
    local Toggle = Tabs.Main:AddToggle("You", {Title = "Auto Request Trade User", Default = false})
    Toggle:OnChanged(function()
        Trap1 = Options.You.Value
    end)
    Options.You:SetValue(false)

    local Dropdown = Tabs.Main:AddDropdown("Players", {
        Title = "Players",
        Values = AllPlayers,
        Multi = false,
        Default = 1,
    })

    Dropdown:SetValue("DekuDimz")

    Dropdown:OnChanged(function(Value)
        Person = Value
    end)



    Tabs.Main:AddButton({Title = "Play Emote",Description = "Plays a selected Emote ",Callback = function()
        ReplicatedStorage.Remotes.Misc.PlayEmote:Fire(Key or "floss")
    end})

    local Dropdown = Tabs.Main:AddDropdown("Dropdown", {
        Title = "Emotes",
        Values = New,
        Multi = false,
        Default = 1,
    })

    Dropdown:SetValue("Floss")

    Dropdown:OnChanged(function(Value)
        Key = Value
    end)

    local Keybind = Tabs.Main:AddKeybind("Keybind", {Title = "Emote Keybind",Mode = "Toggle",Default = "B",
        Callback = function()
            ReplicatedStorage.Remotes.Misc.PlayEmote:Fire(Key or "floss")
        end,
        ChangedCallback = function()
            ReplicatedStorage.Remotes.Misc.PlayEmote:Fire(Key or "floss")
        end
    })
    Keybind:OnClick(function()
        print("Keybind clicked:", Keybind:GetState())
    end)

    Keybind:OnChanged(function()
        print("Keybind changed:", Keybind.Value)
    end)


    local Toggle = Tabs.Main:AddToggle("ESP1", {Title = "Enable ESP", Default = false})
    Toggle:OnChanged(function()
        ESP = Options.ESP1.Value
    end)
    Options.ESP1:SetValue(false)
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
    Title = "V.G Hub",
    Content = "The script has been loaded.",
    Duration = 8
})

SaveManager:LoadAutoloadConfig()
