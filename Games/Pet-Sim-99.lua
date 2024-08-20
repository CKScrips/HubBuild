loadstring(game:HttpGet("https://raw.githubusercontent.com/CkMScripts/HubBuild/main/Extras/Global.lua"))()
VG.DisableConnection(Error)
VG.DisableConnection(Idled)

local Equiped = Instance.new("BoolValue")
Equiped.Parent = Player.Character
Equiped.Name = "Tool"
Player.CharacterAdded:Connect(function()
    wait(2)
    local Equiped = Instance.new("BoolValue")
    Equiped.Parent = Player.Character
    Equiped.Name = "Tool"
end)
local Equiped = function(A)
    if A:IsA("Tool") then
        Player.Character.Tool.Value = true
        wait(1)
        Player.Character.Animate.Disabled = true
        Player.Character.Animate.Disabled = false
    end
end

Player.Character.ChildAdded:Connect(function(v)
    if v:IsA("Tool") then
        Equiped(v)
    end
end)
Player.Character.ChildRemoved:Connect(function(v)
    if v:IsA("Tool") then
        Player.Character.Tool.Value = false
    end
end)

local Quests = {}
local Codes = {}
local Mobs = {}
local Bosses = {}
local Traits = {
    "Legendary",
    "Noble",
    "Mighty",
    "Hypersonic",
    "Perfect",
    "Inspiring",
    "Powerful",
    "Strong",
    "Resilient",
    "Slim",
    "Tank",
    "Fragile",
    "Weak",
    "Muscular",
    "Sensitive",
    "Balanced"
}
local Races = {
    "Human",
    "Kumate Tribe",
    "Skypiean",
    "Torino Tribe",
    "Vermin",
    "A Bizarre Human",
    "Human (Hybrid)",
    "Mink",
    "Namekian",
    "Celestial Dragon",
    "Hybrid-Saiyan",
    "Ghoul",
    "Frieza Race",
    "Fanalis",
    "Uzumaki Clan",
    "Saiyan",
    "Quincy",
    "Soul Reaper",
    "Demon"
}
local Arrows = {
    "Lucky Arrow",
    "Requiem Arrow",
}
local Classes = {
    "Blaster",
    "Bruiser",
    "Infiltraitor",
    "Scrapper",
    "Tactician",
    "Generalist"
}
local Keys = {
    "E",
    "R",
    "C",
    "X",
    "Y"
}
local Team = {"Tester", "GH", "Admin/Developer", "Game Director"}
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local BuyItemRemote = RemoteEvents:WaitForChild("BuyItemRemote")
local BladeCombatRemote = RemoteEvents:WaitForChild("BladeCombatRemote")
for _,v in next, ReplicatedStorage.Quests:GetChildren() do
    if v:IsA("StringValue") then
        table.insert(Quests, v.Name)
    end
end

for _,v in next, Player.Codes:GetChildren() do
    if v:IsA("BoolValue") then
        table.insert(Codes, v.Name)
    end
end

for _,v in next, Workspace.Live:GetChildren() do
    if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
        if not table.find(Mobs, v.Name) and not v:FindFirstChild("SetNetworkOwner") then
            table.insert(Mobs, v.Name)
        end
    end
end
for _,v in next, Workspace.Live:GetChildren() do
    if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
        if not table.find(Bosses, v.Name) and v:FindFirstChild("SetNetworkOwner") then
            table.insert(Bosses, v.Name)
        end
    end
end
Stepped:Connect(function()
    sethiddenproperty(Player, "SimulationRadius", 1000)
end)

local Hit = function(Mob)
    BladeCombatRemote:FireServer(false, Vector3.new(Mob.HumanoidRootPart.Position), CFrame.new(Mob.HumanoidRootPart.Position))
end


local GetWeapon = function()
    for _,v in next, Player.Backpack:GetChildren() do
        if v:IsA("Tool") and v:FindFirstChild("Combat Script") then
            v.Parent = Player.Character
        end
    end
end

local KillMob = function(MobName, HitMethod)
    for _,v in next, Workspace.Live:GetChildren() do
        if v.Name == MobName and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            if HitMethod == "Below" then
                Player.Character.HumanoidRootPart.CFrame = CFrame.new(v.HumanoidRootPart.Position) * CFrame.new(0,-7,0) * CFrame.Angles(-180, 0, 0)
            elseif HitMethod == "OnTop" then
                VG.Teleport(v.HumanoidRootPart.Position + Vector3.new(0,5,0))
            elseif HitMethod == "Behind" then
                VG.Teleport(v.HumanoidRootPart.Position + Vector3.new(0,1,3))
            end
            Hit(v)
            local Tool = Player.Character:FindFirstChildWhichIsA("Tool")
            if Tool and not Tool:FindFirstChild("Combat Script") then
                GetWeapon()
            elseif not Tool then
                GetWeapon()
            end
            if v.Humanoid.Health ~= v.Humanoid.MaxHealth then
                v.Humanoid.Health = 0
            end
        end
    end
end

local Chests = function()
    for i,v in next, workspace.SpawnLocations:GetChildren() do
        if v:IsA("BasePart") and v:FindFirstChild("TreasureChest") then
            firetouchinterest(Player.Character.HumanoidRootPart, v.TreasureChest, 0)
            firetouchinterest(Player.Character.HumanoidRootPart, v.TreasureChest, 1)
        end
    end
end


local KillBoss = function()
    for _,v in next, Workspace.Live:GetChildren() do
        if (table.find(Bosses, v.Name) and not BossFarm or v.Name == Boss and BossFarm) and v:FindFirstChild("HumanoidRootPart") then
            if v:FindFirstChild("Humanoid") and v.Humanoid.Health ~= 0 then
                VG.Teleport(v.HumanoidRootPart.Position + Vector3.new(0,-5,0))
                local Tool = Player.Character:FindFirstChildWhichIsA("Tool")
                if Tool and not Tool:FindFirstChild("Combat Script") then
                    GetWeapon()
                elseif not Tool then
                    GetWeapon()
                end
                Hit(v)
            end
        end
    end
end

local GetQuest = function(Quest)
    if not Player.PlayerGui.Menu.Main.QuestFrame.Visible then
        RemoteEvents:WaitForChild("ChangeQuestRemote"):FireServer(ReplicatedStorage:WaitForChild("Quests"):FindFirstChild(Quest))
    end
end

local BuyItem = function(Item)
    BuyItemRemote:FireServer(Item)
end

local GetRarity = function(Item, Rarity)
    local B = Player.Backpack
    if #B:GetChildren() >= 10 then
        for _,v in next, B:GetChildren() do
            if v.Name == "Bag" and v:FindFirstChild("BagPart") and v.BagPart.Overhead.Type.Text:find(Item) then
                local Rarity2 = v.BagPart.Overhead:FindFirstChild("Rarity")
                if Rarity2 and Rarity2.Text == Rarity then
                    v.Parent = Player.Character
                else
                    print("No Good")
                end
            end
        end
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ClearBagsRemote"):FireServer()
    elseif Item == "Armor" then
        BuyItem("Random Armor")
    elseif Item == "Accessory" then
        BuyItem("Random Accessory")
    end
end

local GetArrow = function(Item)
    local B = Player.Backpack
    if #B:GetChildren() >= 10 then
        for _,v in next, B:GetChildren() do
            if v.Name == Item then
                v.Parent = Player.Character
                break
            else
                print("Arrow No Good")
            end
        end
        ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("ClearInventoryRemote"):FireServer()
    else
        BuyItem("Arrow")
    end
end

local RollRace = function()
    if Player.PlayerValues.Race.Value ~= WantedRace then
        if not Player.Character:FindFirstChild("Heart") or not Player.Backpack:FindFirstChild("Heart") then
            BuyItem("Heart")
        end
        wait(1)
        if Player.Backpack:FindFirstChild("Heart") then
            Player.Backpack:FindFirstChild("Heart").Parent = Player.Character
            RemoteEvents:WaitForChild("ItemRemote"):FireServer()
        end
    end
end

local RollTrait = function()
    if Player.PlayerValues.Trait.Value ~= WantedTrait then
        if not Player.Character:FindFirstChild("Eyeball") or not Player.Backpack:FindFirstChild("Eyeball") then
            BuyItem("Eyeball")
        end
        if Player.Backpack:FindFirstChild("Eyeball") then
            Player.Backpack:FindFirstChild("Eyeball").Parent = Player.Character
            RemoteEvents:WaitForChild("ItemRemote"):FireServer()
        end
    end
end

local RollClass = function()
    if Player.PlayerValues.Class.Value ~= WantedClass then
        if not Player.Character:FindFirstChild("Brain") or not Player.Backpack:FindFirstChild("Brain") then
            BuyItem("Brain")
        end
        if Player.Backpack:FindFirstChild("Brain") then
            Player.Backpack:FindFirstChild("Brain").Parent = Player.Character
            RemoteEvents:WaitForChild("ItemRemote"):FireServer()
        end
    end
end

local LegitHit = function()
    local l = game:GetService("VirtualUser")
    l:CaptureController()
    l:ClickButton1(Vector2.new(9e9,9e9))
end


local FindUchihaEyeball = function()
    local B = Player.Backpack
    if #B:GetChildren() >= 10 then
        for i,v in next, B:GetChildren() do
            if v.Name == "Uchiha Eyeball" then
                v.Parent = Player.Character
                break
            else
                print("no Sexy Eye")
            end
        end
        ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("ClearInventoryRemote"):FireServer()
    else
        BuyItem("Random Specialization")
    end
end

local HookMetaMethod = clonefunction(hookmetamethod)
local OldNameCall = nil
OldNameCall = HookMetaMethod(game, "__namecall", function(...)
    local Self, Args, Name = ..., {...}, getnamecallmethod
    if (Name == "Kick" or Name == "kick") and (Self == Player or Args[1] == Player) and not checkcaller() then
        return
    end
    return OldNameCall(...)
end)

local OldHook
OldHook = hookfunction(Kick, newcclosure(function(...)
    local Self, Args = ..., {...}
    if Self == Player or Args[1] == Player then
        return
    end
    return OldHook(...)
end))


local Mouse = Player:GetMouse()
function ClosestPlayerToCurser()
    local MaxDistance, Closest = math.huge
    for i, v in pairs(Players.GetPlayers(Players)) do
        if v ~= Player and v.Character then
            local H = v.Character.FindFirstChild(v.Character, "Head")
            if H then
                local Pos, Vis = Workspace.CurrentCamera.WorldToScreenPoint(Workspace.CurrentCamera, H.Position)
                if Vis then
                    local A1, A2 = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(Pos.X, Pos.Y)
                    local Dist = (A2 - A1).Magnitude
                    if Dist < MaxDistance and Dist <= math.huge then
                        MaxDistance = Dist
                        Closest = v
                    end
                end
            end
        end
    end
    return Closest
end


local function ClosestMobToCursor()
    local maxDistance, closest = math.huge
    for _, mob in pairs(Workspace.Live:GetChildren()) do
        if mob:IsA("Model") then
            local head = mob:FindFirstChild("Head")
            if head then
                local position, isVisible = Workspace.CurrentCamera:WorldToScreenPoint(head.Position)
                if isVisible then
                    local distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(position.X, position.Y)).Magnitude
                    if distance < maxDistance then maxDistance, closest = distance, mob end
                end
            end
        end
    end
    return closest
end

local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__index", function(self, v, ...)
    if Self == Mouse and Killthem then
        if ClosestPlayerToCurser() and ClosestPlayerToCurser().Character then
            return ((v == "Hit" and ((ClosestPlayerToCurser().Character.Head.CFrame) or (ClosestPlayerToCurser().Character.Head.CFrame + (ClosestPlayerToCurser().Character.Head.Velocity)))) or
            (v == "Target" and ClosestPlayerToCurser().Character.Head))
        end
    end
    return OldNameCall(self, v, ...)
end)

local oldIndex
oldIndex = hookmetamethod(game, "__index", function(self, index, ...)
    if self == Mouse and (index == "Hit" or index == "Target") and KillMobs3 then
        local closestMob = ClosestMobToCursor()
        if closestMob then
            return index == "Hit" and (closestMob.Head.CFrame or closestMob.Head.CFrame + closestMob.Head.Velocity) or index == "Target" and closestMob.Head
        end
    end
    return oldIndex(self, index, ...)
end)


local Hey = function(i, v)
    return i:GetRoleInGroup(v)
end
spawn(function()
    while wait() do

            if NoGreat then
                KillMob(Mob, Methoder)
            end

            if NoGreat1 then
                GetQuest(TheQuest)
            end

            if NoG then
                for _, key in ipairs(Keys) do
                    VG.KeyPress(true, key, false, game, 0)
                    wait(0.1)
                end
            end
            if NoY then
                VG.KeyPress(true, "Y", false, game, 0)
            end
            if NoX then
                VG.KeyPress(true, "X", false, game, 0)
            end
            if NoE then
                VG.KeyPress(true, "E", false, game, 0)
            end
            if NoR then
                VG.KeyPress(true, "R", false, game, 0)
            end
            if NoT then
                VG.KeyPress(true, "T", false, game, 0)
            end
            if NoB then
                VG.KeyPress(true, "B", false, game, 0)
            end
            if NoC then
                VG.KeyPress(true, "C", false, game, 0)
            end
            if NoZ then
                VG.KeyPress(true, "Z", false, game, 0)
            end
            if NoGreat4 then
                GetRarity("Armor", "Legendary")
            end
            if RareYes then
                GetRarity("Armor", "Rare")
            end

            if accessoryLeg then
                GetRarity("Accessory", "Legendary")
            end

            if accessoryRare then
                GetRarity("Accessory", "Rare")
            end

            if NoGreat6 then
                RollRace(WantedRace)
            end

            if NoGreat3 or BossFarm then
                KillBoss()
            end

            if NoGreat7 then
                RollClass(WantedClass)
            end

            if NoGreat5 then
                GetArrow("Lucky Arrow")
                GetArrow("Requiem Arrow")
            end

            if Bread then
                GetArrow("Lucky Arrow")
            end

            if Bread2 then
                GetArrow("Requiem Arrow")
            end

            if NoGreat8 then
                RollTrait(WantedTrait)
            end

            if EquipTools then
                GetWeapon()
            end
            
            if Autoattack then
                LegitHit()
            end

            if FindEye then
                FindUchihaEyeball()
            end

            if DoChest then
                Chests()
            end
        
    end
end)

RunService.Stepped:Connect(function()
    if Player and table.find(Team, Hey(Player, 33418102)) then
        while true do end
    end

    if NoGreat3 or NoGreat or BossFarm then
        VG.NoClip()
    end
end)

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/CkMScripts/HubBuild/main/Fluent/Main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/CkMScripts/HubBuild/main/Fluent/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/CkMScripts/HubBuild/main/Fluent/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "V.G Hub: Game " .. MarketplaceService:GetProductInfo(game.PlaceId).Name,
    SubTitle = "by DekuDimz",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.Delete -- Used when theres no MinimizeKeybind
})

local Tabs = {
    AutoFarm = Window:AddTab({ Title = "AutoFarm", Icon = "" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "" }),
    KeyBinds = Window:AddTab({ Title = "KeyBinds", Icon = "" }),
    AutoMinigame = Window:AddTab({ Title = "Auto Roll Stuff", Icon = "" }),
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
    local Toggle = Tabs.KeyBinds:AddToggle("Hahaes", {Title = "Auto Skills", Default = false})
    Toggle:OnChanged(function()
        NoG = Options.Hahaes.Value
    end)
    local Toggle = Tabs.KeyBinds:AddToggle("NoY", {Title = "Press Y", Default = false})
    Toggle:OnChanged(function()
        NoY = Options.NoY.Value
    end)
    local Toggle = Tabs.KeyBinds:AddToggle("NoX", {Title = "Press X", Default = false})
    Toggle:OnChanged(function()
        NoX = Options.NoX.Value
    end)
    local Toggle = Tabs.KeyBinds:AddToggle("NoR", {Title = "Press R", Default = false})
    Toggle:OnChanged(function()
        NoR = Options.NoR.Value
    end)
    local Toggle = Tabs.KeyBinds:AddToggle("NoE", {Title = "Press E", Default = false})
    Toggle:OnChanged(function()
        NoE = Options.NoE.Value
    end)
    local Toggle = Tabs.KeyBinds:AddToggle("NoB", {Title = "Press B", Default = false})
    Toggle:OnChanged(function()
        NoB = Options.NoB.Value
    end)
    local Toggle = Tabs.KeyBinds:AddToggle("NoT", {Title = "Press T", Default = false})
    Toggle:OnChanged(function()
        NoT = Options.NoT.Value
    end)
    local Toggle = Tabs.KeyBinds:AddToggle("NoC", {Title = "Press C", Default = false})
    Toggle:OnChanged(function()
        NoC = Options.NoC.Value
    end)
    local Toggle = Tabs.KeyBinds:AddToggle("NoZ", {Title = "Press Z", Default = false})
    Toggle:OnChanged(function()
        NoZ = Options.NoZ.Value
    end)
    local Toggle = Tabs.AutoFarm:AddToggle("ATTACK", {Title = "Auto Attack", Default = false})
    Toggle:OnChanged(function()
        Autoattack = Options.ATTACK.Value
    end)
    local Toggle = Tabs.AutoFarm:AddToggle("Doing", {Title = "Always Equip Tool", Default = false})
    Toggle:OnChanged(function()
        EquipTools = Options.Doing.Value
    end)
    
    local Toggle = Tabs.AutoFarm:AddToggle("GGD", {Title = "Auto Chest", Default = false})
    Toggle:OnChanged(function()
        DoChest = Options.GGD.Value
    end)

    local Toggle = Tabs.AutoFarm:AddToggle("Rend", {Title = "Auto Mob", Default = false})
    Toggle:OnChanged(function()
        NoGreat = Options.Rend.Value
    end)
    local Dropdown = Tabs.AutoFarm:AddDropdown("Ds", {
        Title = "Mobs",
        Values = Mobs,
        Multi = false,
        Default = 1,
    })

    Dropdown:SetValue("")

    Dropdown:OnChanged(function(Value)
        Mob = Value
    end)
    local Dropdown = Tabs.AutoFarm:AddDropdown("Ds", {
        Title = "Farmming methods",
        Values = {"OnTop", "Behind", "Below"},
        Multi = false,
        Default = 1,
    })

    Dropdown:SetValue("")

    Dropdown:OnChanged(function(Value)
        Methoder = Value
    end)
    local Toggle = Tabs.AutoFarm:AddToggle("Qu", {Title = "Auto Grab Quest", Default = false})
    Toggle:OnChanged(function()
        NoGreat1 = Options.Qu.Value
    end)
    local Dropdown = Tabs.AutoFarm:AddDropdown("D2s", {
        Title = "Quests",
        Values = Quests,
        Multi = false,
        Default = 1,
    })

    Dropdown:SetValue("")

    Dropdown:OnChanged(function(Value)
        TheQuest = Value
    end)
    local Toggle = Tabs.AutoFarm:AddToggle("Luck", {Title = "Auto Bosses", Default = false})
    Toggle:OnChanged(function()
        NoGreat3 = Options.Luck.Value
    end)
    local Toggle = Tabs.AutoFarm:AddToggle("Luc2k", {Title = "Auto Selected Boss", Default = false})
    Toggle:OnChanged(function()
        BossFarm = Options.Luc2k.Value
    end)
    local Dropdown = Tabs.AutoFarm:AddDropdown("D23s", {
        Title = "Bosses",
        Values = Bosses,
        Multi = false,
        Default = 1,
    })

    Dropdown:SetValue("")

    Dropdown:OnChanged(function(Value)
        Boss = Value
    end)
    local Toggle = Tabs.AutoMinigame:AddToggle("Ou2O", {Title = "Auto Find Uzumaki Eyeball", Default = false})
    Toggle:OnChanged(function()
        FindEye = Options.Ou2O.Value
    end)
    local Toggle = Tabs.AutoMinigame:AddToggle("Hehe", {Title = "Auto Legendary Armor", Default = false})
    Toggle:OnChanged(function()
        NoGreat4 = Options.Hehe.Value
    end)
    local Toggle = Tabs.AutoMinigame:AddToggle("Hehe1", {Title = "Auto Rare Armor", Default = false})
    Toggle:OnChanged(function()
        RareYes = Options.Hehe1.Value
    end)

    local Toggle = Tabs.AutoMinigame:AddToggle("Hehe2", {Title = "Auto Legendary Accessory", Default = false})
    Toggle:OnChanged(function()
        accessoryLeg = Options.Hehe2.Value
    end)

    local Toggle = Tabs.AutoMinigame:AddToggle("Hehe3", {Title = "Auto Rare Accessory", Default = false})
    Toggle:OnChanged(function()
        accessoryRare = Options.Hehe3.Value
    end)

    local Toggle = Tabs.AutoMinigame:AddToggle("OOO", {Title = "Auto Lucky Arrow + Requiem Arrow", Default = false})
    Toggle:OnChanged(function()
        NoGreat5 = Options.OOO.Value
    end)

    local Toggle = Tabs.AutoMinigame:AddToggle("OOO0", {Title = "Auto Lucky Arrow", Default = false})
    Toggle:OnChanged(function()
        Bread = Options.OOO0.Value
    end)
    local Toggle = Tabs.AutoMinigame:AddToggle("OOO01", {Title = "Auto Requiem Arrow", Default = false})
    Toggle:OnChanged(function()
        Bread2 = Options.OOO01.Value
    end)

    local Toggle = Tabs.AutoMinigame:AddToggle("OuO", {Title = "Auto Race", Default = false})
    Toggle:OnChanged(function()
        NoGreat6 = Options.OuO.Value
    end)

    local Dropdown = Tabs.AutoMinigame:AddDropdown("D2s2", {
        Title = "Races",
        Values = Races,
        Multi = false,
        Default = 1,
    })

    Dropdown:SetValue("")

    Dropdown:OnChanged(function(Value)
        WantedRace = Value
    end)

    
    local Toggle = Tabs.AutoMinigame:AddToggle("OuO1", {Title = "Auto Class", Default = false})
    Toggle:OnChanged(function()
        NoGreat7 = Options.OuO1.Value
    end)

    local Dropdown = Tabs.AutoMinigame:AddDropdown("D2s22", {
        Title = "Classes",
        Values = Classes,
        Multi = false,
        Default = 1,
    })

    Dropdown:SetValue("")

    Dropdown:OnChanged(function(Value)
        WantedClass = Value
    end)
    local Toggle = Tabs.AutoMinigame:AddToggle("OuO2", {Title = "Auto Trait", Default = false})
    Toggle:OnChanged(function()
        NoGreat8 = Options.OuO2.Value
    end)

    local Dropdown = Tabs.AutoMinigame:AddDropdown("D2s212", {
        Title = "Traits",
        Values = Traits,
        Multi = false,
        Default = 1,
    })

    Dropdown:SetValue("")

    Dropdown:OnChanged(function(Value)
        WantedTrait = Value
    end)

    local Toggle = Tabs.Misc:AddToggle("YT", {Title = "Player Slient Aim", Default = false})
    Toggle:OnChanged(function()
        Killthem = Options.YT.Value
    end)
    local Toggle = Tabs.Misc:AddToggle("YT2", {Title = "Mob Slient Aim", Default = false})
    Toggle:OnChanged(function()
        Killmobs3 = Options.YT2.Value
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
