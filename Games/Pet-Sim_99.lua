
loadstring(game:HttpGet("https://raw.githubusercontent.com/1201for/V.G-Hub/main/Extras/Global"))()

VG.DisableConnection(Idled)
VG.DisableConnection(Error)
VG.DisableConnection(UserInputService.WindowFocused)
VG.DisableConnection(UserInputService.WindowFocusReleased)

local Hehe = {}
local Zones = {}
local Fruits = {}
local EggTable = {}
local Instances = {}
local Flags = {}
local VendingMachines = {}
local Dice = {
    "Lucky Dice II",
    "Mega Lucky Dice",
    "Mega Lucky Dice II",
}

local Upgrades = {
    "RNGEggLuck",
    "RNGHatchSpeed",
    "RNGBonusLuck",
    "RNGHugeLuck"
}
local Library  = require(ReplicatedStorage:WaitForChild("Library"))
local Client2 = ReplicatedStorage.Library:WaitForChild("Client")
local Client = {}
for i,v in next, Client2:GetChildren() do
    Client[v.Name] = require(v)
end
local ZonesUtil = require(game:GetService("ReplicatedStorage").Library.Util.ZonesUtil)
local RNGHatching = require(game:GetService("ReplicatedStorage").Library.Client.RngEggFrontend)

local ShinyRelics = getsenv(Player.PlayerScripts.Scripts.Game.Misc["Shiny Relics"])
local Hatching = getsenv(Player.PlayerScripts.Scripts.Game:WaitForChild("Egg Opening Frontend"))
-----
local Network = ReplicatedStorage:WaitForChild("Network")
local Things = Workspace:WaitForChild("__THINGS")
local Active = Things.__INSTANCE_CONTAINER:WaitForChild("Active")
local Gifts = ReplicatedStorage:WaitForChild("__DIRECTORY").MiscItems.Categorized.Gifts
local CalculateSpeedMultiplier = Client.PlayerPet.CalculateSpeedMultiplier
local HatchingAnimation = Hatching.PlayEggAnimation
local PlayAnimation = RNGHatching.PlayAnimation
local F = {}
for i,v in next, getgc(true) do
    if type(v) == "function" then
        local Info = getinfo(v).name
        if Info == "GetNearestBreakable" then
            F[Info] = v
        elseif Info == "CalculateSpeedMultiplier" then
            F[Info] = v
        elseif Info == "PlayEggAnimation" then
            F[Info] = v
        elseif Info == "RequestRelics" then
            F[Info] = v
        elseif Info == "RelicClicked"then
            F[Info] = v
        elseif Info == "GetTitle" then
            F[Info] = v
        elseif Info == "All" then
            F[Info] = v
        elseif getfenv(v).script == game:GetService("ReplicatedStorage").Library.Client.TabController then
            if Info == "OpenTab" then
                F[Info] = v
            elseif Info == "CloseTab" then
                F[Info] = v
            end
        elseif Info == "Setup" and getfenv(v).script == game:GetService("ReplicatedStorage").Library.Client.CustomEggsCmds then
            F[Info] = v
        end
    end
end
-----
local RE = function(RemoteName)
    if Network:FindFirstChild(RemoteName) then
        return Network[RemoteName]
    else
        error("Failed to load remote " .. RemoteName .. " Please Contact Deku with this error message")
    end
end

local RF = function(RemoteName)
    if Network:FindFirstChild(RemoteName) then
        return Network[RemoteName]
    else
        error("Failed to load Remotfunction " .. RemoteName .. " Please Contact Deku with this error")
    end
end

local Roll = function()
    VG.FireFunction(Player.PlayerGui._MISC.RngUI.Button.Roll.Activated)
end
local GoToEvent = function()
    local Woah = VG.FFD(Active, "RngInstance")
    if not Woah then
        VG.Teleport(Things.Instances.RngInstance.Teleports.Enter.Position)
        wait(10)
        VG.Teleport(Vector3.new(4064, 2566, -5417))
    end
    if Woah and not EventToggle then
        VG.Teleport(Things.Instances.RngInstance.Teleports.Leave.Position)
    end
end

local LuckyDiceMerchant = function()
    for i=1, 6 do
        RF("Merchant_RequestPurchase"):InvokeServer("LuckyDiceMerchant", i)
    end
end

local MegaDice = function()
    RF("LuckyDice_ConsumeMega"):InvokeServer("Mega Lucky Dice II", 1)
end

local Combined = function(Dice)
    RF("LuckyDice_Craft"):InvokeServer(Dice, 1)
end

local CombinedAll = function()
    for _, v in next, Dice do
        RF("LuckyDice_Craft"):InvokeServer(v, 1)
    end
end

local Upgrades1All = function()
    for _,v in next, Upgrades do
        RF("Rng_PurchaseUpgrade"):InvokeServer("First", v)
    end
end
local Upgrades1 = function(NeededUPGRADE)
    RF("Rng_PurchaseUpgrade"):InvokeServer("First", NeededUPGRADE)
end

local Run = function()
    for i,v in next, Client.Save.GetSaves()[Player].Inventory.Misc do
        if v.id == "Comet" and (COMET or ALL) then
            RF("Comet_Spawn"):InvokeServer(i)
        elseif v.id == "Mini Lucky Block" and (LUCKYBLOCK or ALL) then
            RF("MiniLuckyBlock_Consume"):InvokeServer(i)
        elseif v.id == "Mini Pinata" and (PINATA or ALL) then
            RF("MiniPinata_Consume"):InvokeServer(i)
        elseif v.id == "Party Box" and (PARTY or ALL) then
            RF("PartyBox_Consume"):InvokeServer(i)
        end
    end
    if AllKeys then
        for i,v in next, Network:GetChildren() do
            if v.Name:find("_Combine") then
                v:InvokeServer(1)
            end
        end
    end
    if VoidKey then
        RF("VoidKey_Unlock"):InvokeServer()
    elseif TechKey then
        RF("TechKey_Unlock"):InvokeServer()
    elseif CrystalKey then
        RF("CrystalKey_Unlock"):InvokeServer()
    elseif SecretRoom then
        RF("SecretRoom_Unlock"):InvokeServer("Treehouse Merchant")

        RF("Instancing_PlayerEnterInstance"):InvokeServer("TreehouseMerchant")

        F.OpenTab("TreehouseMerchant")
        local Huges = {"rbxassetid://16410740491","rbxassetid://16410740693"}
        for i,v in next, getupvalue(getsenv(Player.PlayerScripts.Scripts.Game.Machines["Treehouse Merchant"]).UpdateMerchant, 5) do
            if table.find(Huges, v.Icon.Image) then
                FR("TreehouseMerchant_Purchase"):InvokeServer(i)
            else
                FR("TreehouseMerchant_Purchase"):InvokeServer(math.random(1,3))

            end
        end

        F.CloseTab("TreehouseMerchant")

        FE("Instancing_PlayerLeaveInstance"):FireServer("TreehouseMerchant")
    end
end

local Upgrade = function()
    for i=1, 99 do wait()
        RF("EquipSlotsMachine_RequestPurchase"):InvokeServer(i)
    end
end

local DayCare = function()
    local Pets = {}
    if Client.DaycareCmds.GetUsedSlots() ~= Client.DaycareCmds.GetMaxSlots() then
        for i,v in next, Client.PlayerPet.GetAll() do
            Pets[v] = v.item._uid
            RF("Daycare: Enroll"):InvokeServer({[v.item._uid] = 1})
            Client.DaycareCmds.Claim(v.item._uid)
        end
    end
end
local CurrentActive = function()
    return Active:GetChildren()[1]
end

local GetMap = function()
    for i,v in next, Workspace:GetChildren() do
        if v.Name:find("Map") and v:IsA("Folder") then
            return v.Name
        end
    end
end
local getShiny = function(Shin)
    if Shin then
        for i,v in next, getupvalue(F.RequestRelics,1) do
            if v.Model == Shin then
                return v
            end
        end
    end
end

local GetFruits = function()
    for i,v in next, Client.Save.GetSaves()[Player].Inventory.Fruit do
        if require(game:GetService("ReplicatedStorage").Library.Client.FruitCmds).GetMaxConsume(i) ~= 0 then
            require(game:GetService("ReplicatedStorage").Library.Client.FruitCmds).Consume(i, 1)
        end
    end
end

local GetPotions = function()
    for i,v in next, Client.Save.GetSaves()[Player].Inventory.Potion do wait()
        require(game:GetService("ReplicatedStorage").Library.Client.PotionCmds).Consume(i)
    end
end


local OpenAllGifts = function()
    for _,v in next, Client.Save.GetSaves()[Player].Inventory.Misc do
        if Gifts:FindFirstChild(v.id) then
            RF("GiftBag_Open"):InvokeServer(v.id)
        end
    end
end

local GetFlags = function()
	local LMAO = Client.Save.GetSaves()[Player].Inventory.Misc
	for i,v in next, LMAO do
		if table.find(Flags, v.id) then
            print(i, v.id)
			RF("FlexibleFlags_Consume"):InvokeServer(WantedFlag, i)
		end
	end
end

local ClaimRanks = function()
    for _,v in Player.PlayerGui.Rank.Frame.Rewards.Items.Unlocks:GetChildren() do
        if v.Name == "ClaimSlot" then
            RE("Ranks_ClaimReward"):FireServer(tonumber(v.Title.Text))
        end
    end
end

--------------- Fishing
local Activated = function()
    if Method == "Fishing" and not Active:FindFirstChild("Fishing") then
        VG.Teleport(Things.Instances.Fishing.Teleports.Enter.Position)
        wait(5)
    elseif Method == "AdvancedFishing" and not Active:FindFirstChild("AdvancedFishing") then
        VG.Teleport(Things.Instances.AdvancedFishing.Teleports.Enter.Position)
        wait(5)
        VG.GetHumanoid():MoveTo(1448, 67, -4445)
    end
    if Method == "AdvancedFishing" then
        if require(ReplicatedStorage.Library.Client.MasteryCmds).GetLevel("Fishing") < 30 then
            RF("Instancing_InvokeCustomFromClient"):InvokeServer(CurrentActive().Name, "RequestCast",Vector3.new(1466.473388671875, 61.62495040893555, -4454.935546875))
        elseif require(ReplicatedStorage.Library.Client.MasteryCmds).GetLevel("Fishing") >= 30 and CurrentActive().Interactable:FindFirstChild("DeepPool") then
            RF("Instancing_InvokeCustomFromClient"):InvokeServer("AdvancedFishing","RequestCast", CurrentActive().Interactable.DeepPool.Position)
        else
            RF("Instancing_InvokeCustomFromClient"):InvokeServer(CurrentActive().Name, "RequestCast",Vector3.new(1466.473388671875, 61.62495040893555, -4454.935546875))
        end
        RE("Instancing_FireCustomFromClient"):FireServer("AdvancedFishing","RequestReel")
        RF("Instancing_InvokeCustomFromClient"):InvokeServer("AdvancedFishing","Clicked")
    elseif Method == "Fishing" then
        if require(game.ReplicatedStorage.Library.Client.MasteryCmds).GetLevel("Fishing") < 30 then
            RF("Instancing_InvokeCustomFromClient"):InvokeServer("Fishing","RequestCast",Vector3.new(1139, 75, -3445))
        elseif require(ReplicatedStorage.Library.Client.MasteryCmds).GetLevel("Fishing") >= 30 and CurrentActive().Interactable:FindFirstChild("DeepPool") then
            RF("Instancing_InvokeCustomFromClient"):InvokeServer("Fishing","RequestCast", CurrentActive().Interactable.DeepPool.Position)
        else
            RF("Instancing_InvokeCustomFromClient"):InvokeServer("Fishing","RequestCast",Vector3.new(1139, 75, -3445))
        end
        RE("Instancing_FireCustomFromClient"):FireServer("Fishing","RequestReel")
        RF("Instancing_InvokeCustomFromClient"):InvokeServer("Fishing","Clicked")
    end
end

----- Collecting Stuff
local Venders = function()
    local OldPos = Player.Character:GetModelCFrame()
    for i,v in next, VendingMachines do
        local Real = VG.FFD(Workspace[GetMap()], v)
        if Real and Real:FindFirstChild("VendingMachine") and not Real.VendingMachine.Screen.SurfaceGui.SoldOut.Visible then
            VG.Teleport(Real:GetModelCFrame().Position)
            repeat wait() RE("VendingMachines_Purchase"):InvokeServer(v, 1) until Real.VendingMachine.Screen.SurfaceGui.SoldOut.Visible
        end
    end
    Player.Character:SetPrimaryPartCFrame(OldPos)
end

local Rebirth = function()
    local yes = require(game:GetService("ReplicatedStorage").Library.Client.RebirthCmds)
    if yes.GetNextRebirth() and yes.GetNextRebirth().RebirthNumber then
        RF("Rebirth_Request"):InvokeServer(tostring(yes.GetNextRebirth().RebirthNumber))
    end
end


local TargetFarm = function()
    local Target = F.GetNearestBreakable()
    if Target then
        RE("Breakables_PlayerDealDamage"):FireServer(Target.Name)
        game:GetService("ReplicatedStorage").Library.Signal.AutoClicker_Click:Fire(Target.Name)
    end
end
local Collect = function()
    local FuckYou = workspace.__THINGS.Orbs:GetChildren()
    local MyOrbs = {}

    if #FuckYou > 0 then
        for i,v in next, FuckYou do
            MyOrbs[i] = tonumber(v.Name)
            v:Destroy()
        end
    end
    RE("Orbs: Collect"):FireServer(MyOrbs)
end

local AutoFarmZones = function()
    local Owned = Client.ZoneCMDS.GetMaxOwnedZone()
    if Owned then
        local Zone = ZonesUtil.GetInteractFolder(Owned)
        if not Zone then
            RF("Teleports_RequestTeleport"):InvokeServer(Owned)
        end
        if Zone then
            if Zone:FindFirstChild("Buy Signs") then
                VG.GetHumanoid():MoveTo(Zone.BREAKABLE_SPAWNS.Main.Position + Vector3.new(0,1,0))
            elseif Zone:FindFirstChild("BREAKABLE_SPAWNS") and Zone.BREAKABLE_SPAWNS:FindFirstChild("Boss") then
                VG.GetHumanoid():MoveTo(Zone.BREAKABLE_SPAWNS.Main.Position + Vector3.new(0,1,0))
            else
                VG.GetHumanoid():MoveTo(Zone.BREAK_ZONES.BREAK_ZONE.Position + Vector3.new(0,1,0))
            end
        end
        local NotOwned = Client.ZoneCMDS.GetNextZone()
        RF("Zones_RequestPurchase"):InvokeServer(NotOwned)
    end
    TargetFarm()
    Collect()
    Rebirth()
    Upgrade()
    ALL = YesLol
end
local GetLastEgg = function()
    return require(ReplicatedStorage.Library.Client.EggCmds).GetHighestEggNumberAvailable()
end
local GetMaxEggsAbleToOpen = function()
    return require(ReplicatedStorage.Library.Client.EggCmds).GetMaxHatch()
end
local GetLastEggName = function()
    for i, v in next, ReplicatedStorage.__DIRECTORY.Eggs["Zone Eggs"]:GetChildren() do
        for i, v in next, v:GetChildren() do
            for i, v in next, v:GetChildren() do
                if v:IsA("ModuleScript") then
                    local String = string.split(v.Name, " | ")[1]
                    if GetLastEgg() == tonumber(String) then
                        return string.split(v.Name, " | ")[2]
                    end
                end
            end
        end
    end
end

local BuyLastEgg = function()
    local String = require(game:GetService("ReplicatedStorage").Library.Util.WorldsUtil).GetWorld()._id
    local String2 = string.gsub(String, " ", "")
    local OldCFrame = Player.Character.HumanoidRootPart.CFrame
    local Lol = Workspace.__THINGS.Eggs:FindFirstChild(String2)
    if Lol then
        Lol = Workspace.__THINGS.Eggs[String2]:GetChildren() 
    else
        Lol = Workspace.__THINGS.Eggs.Main:GetChildren()
    end
    for i, v in next, Lol do
        local String = string.split(v.Name, " -")[1]
        if GetLastEgg() == tonumber(String) then
            if TeleportToEgg then
                VG.Teleport(v:GetModelCFrame().Position)
            end
            wait(.1)
            RF("Eggs_RequestPurchase"):InvokeServer(GetLastEggName(), tonumber(GetMaxEggsAbleToOpen()))
            break
        end
    end
    if TeleportToEgg then
        Player.Character:SetPrimaryPartCFrame(OldCFrame)
    end
end

local BuyEgg = function(Egg, Amount)
    RF("Eggs_RequestPurchase"):InvokeServer(Egg, GetMaxEggsAbleToOpen())
end


local CustomEggs = function(WantedEgg, True)
    local HEHE = {}
    for i,v in next, getupvalue(F.Setup, 1) do
        if not True then
            if v._id == WantedEgg then
                RF("CustomEggs_Hatch"):InvokeServer(i, tonumber(GetMaxEggsAbleToOpen()))
            end
        elseif True then
            HEHE[v._id] = v._id
        end
    end
    return HEHE
end
---------------BackRooms

local GetCustomEggByName = function(Toggle, String)
    local Egg = nil
    for i,v in next, getupvalue(require(game:GetService("ReplicatedStorage").Library.Client.CustomEggsCmds).All, 1) do
        if v._id == String and Toggle then
            Egg = v._model
        elseif v._id == String and not Toggle then
            Egg = v._hatchable
        end
    end
    return Egg
end

--- Digsite Stuff
local GetBlock = function()
    local IHateMakingNamesFortables = CurrentActive()
    local Distance = math.huge
    local Block = nil
    for i,v in next, IHateMakingNamesFortables.Important.ActiveBlocks:GetChildren() do
        if v:IsA("BasePart") then
            local Mag = VG.Mag(Player.Character.HumanoidRootPart, v)
            if Mag <=  Distance then
                Distance = Mag
                Block = v
            end
        end
    end
    return Block -- I Hate this part
end

local GetChest = function()
    local Table = CurrentActive()
    local Distance = math.huge -- KYS
    local Chest = nil
    for i,v in next, Table.Important.ActiveChests:GetChildren() do
        if v:IsA("Model") then
            local NewMag = VG.Mag(Player.Character.HumanoidRootPart, v:GetModelCFrame())
            if NewMag <= Distance then
                Distance = NewMag
                Chest = v
            end
        end
    end
    return Chest
end

local Dig = function()
    if Method2 == "Digsite" and not Active:FindFirstChild("Digsite") then
        VG.Teleport(Things.Instances.Digsite.Teleports.Enter.Position)
    elseif Method2 == "AdvancedDigsite" and not Active:FindFirstChild("AdvancedDigsite") then
        VG.Teleport(Things.Instances.AdvancedDigsite.Teleports.Enter.Position)
    end
    if (GetBlock() == nil or GetChest() == nil) then
        if Method2 == "Digsite" and not Active:FindFirstChild("Digsite") then
            VG.Teleport(Workspace.__THINGS.Instances["Digsite"].Teleports.Leave.Position)
            wait(5)
            VG.Teleport(Workspace.__THINGS.Instances["Digsite"].Teleports.Enter.Position)
        end
        if Method2 == "AdvancedDigsite" and not Active:FindFirstChild("AdvancedDigsite") then
            VG.Teleport(Workspace.__THINGS.Instances["AdvancedDigsite"].Teleports.Leave.Position)
            wait(5)
            VG.Teleport(Workspace.__THINGS.Instances["AdvancedDigsite"].Teleports.Enter.Position)
        end
    end
    if CurrentActive() and CurrentActive().Name == "Digsite" then
        if Player.Character.HumanoidRootPart.Position.Y <= -1991 then
            VG.FireConnection(Player.PlayerGui._INSTANCES.Digsite.Return.Activated)
        end
    end
    if GetChest() then
        VG.Teleport(GetChest():FindFirstChildWhichIsA("BasePart").Position)
        RE("Instancing_FireCustomFromClient"):FireServer(CurrentActive().Name, "DigChest", GetChest():GetAttribute('Coord'))
    else
        VG.Teleport(GetBlock().Position)
        RE("Instancing_FireCustomFromClient"):FireServer(CurrentActive().Name, "DigBlock", GetBlock():GetAttribute('Coord'))
    end
end
local DigAura = function() -- just Dig() without tweening
    if GetChest() then
        RE("Instancing_FireCustomFromClient"):FireServer(CurrentActive().Name, "DigChest", GetChest():GetAttribute('Coord'))
    else
        RE("Instancing_FireCustomFromClient"):FireServer(CurrentActive().Name, "DigBlock", GetBlock():GetAttribute('Coord'))
    end
end

---- Obby Stuff

local TeleportObby = function()
    for i,v in next, Workspace.__THINGS.Instances:GetChildren() do
        if v.Name == WantedObby then
            VG.Teleport(v.Teleports.Enter.Position)
        end
    end
end
local Doobbystuff = function(Obby)
    local New = Workspace.__THINGS.__INSTANCE_CONTAINER.Active:GetChildren()[1]
    local Model = VG.FFD(New, "StartLine")
    local Model2 = VG.FFD(New, "Goal")
    if Model then
        if Model:IsA("Model") then
            VG.Teleport(VG.FFD(New, "StartLine"):GetModelCFrame().Position + Vector3.new(0,5,-5))
        elseif Model:IsA("BasePart") then
            VG.Teleport(VG.FFD(New, "StartLine").Position + Vector3.new(-5,5,0))
        end
    end
    wait(5)
    if Model2 then
        VG.Teleport(VG.FFD(New, "Goal").Pad.Position)
    end
end

---- Table insert shit
for i,v in next, ReplicatedStorage.__DIRECTORY.Zones:GetChildren() do
    for i,v in next, v:GetChildren() do
        if v:IsA("ModuleScript") then
            local String = string.split(v.Name, "| ", "")[2]
            table.insert(Zones, String)
        end
    end
end

for i,v in next, ReplicatedStorage.__DIRECTORY.VendingMachines:GetChildren() do
    local String = string.split(v.Name, " | ")[2]
    table.insert(VendingMachines, String)
end

for i,v in next, ReplicatedStorage.Assets.Instancing:GetChildren() do
    table.insert(Hehe, v.Name)
end

for i,v in next, ReplicatedStorage.__DIRECTORY.Fruits:GetChildren() do
	local Name = string.split(v.Name, " | ")[2]
	table.insert(Fruits, Name)
end

for i,v in ReplicatedStorage.__DIRECTORY.Eggs["Zone Eggs"]:GetDescendants() do
    if v:IsA("ModuleScript") then
        local EggName = string.split(v.Name, " | ")[2]
        table.insert(EggTable, EggName)
    end
end

for i,v in next, ReplicatedStorage.__DIRECTORY.ZoneFlags:GetChildren() do
	local NewName = string.split(v.Name, "ZoneFlag | ")[2]
	table.insert(Flags, NewName)
end

for i,v in next, workspace.__THINGS.Instances:GetChildren() do
    if not table.find(Instances, v.Name) then
        table.insert(Instances, v.Name)
    end
end

local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(...)
   local Self, Args = ..., {...}
   if Self.Name == "Is Real Player" and getnamecallmethod() == "InvokeServer" then
      return
   end
   return OldNameCall(...)
end)


Client.PlayerPet.CalculateSpeedMultiplier = function(...)
    if PetSpeed then
        return 9e9
    else
        return CalculateSpeedMultiplier(...)
    end
end
RNGHatching.PlayAnimation = function(...)
    if NoHatch then
        return
    else
        return PlayAnimation(...)
    end
end
Hatching.PlayEggAnimation = function(...)
    if NoHatch2 then
        return
    else
        return HatchingAnimation(...)
    end
end
spawn(function()
    while wait(.1) do
        pcall(function()
            game:GetService("Players").LocalPlayer.PlayerScripts.Scripts.Core["Idle Tracking"].Enabled = false
            if MegaUse then
                MegaDice()
            end
            if CombineAll then
                CombinedAll()
            end
            if UpgradeAll then
                Upgrades1All()
            end
            if EventToggle then
                GoToEvent()
            end
            if Rolled then
                Roll()
            end
            if Combine then
                Combined(SelectedDice)
            end
            if Buydice then
                LuckyDiceMerchant()
            end
            if UpgradeStuff then
                Upgrades1(SelectedUpgrade)
            end
            if AutoFarm then
                TargetFarm()
            end
            if UltimateButtons then
                local Equipped = Client.UltimateCmds.GetEquippedItem()
                local IsCharged = Client.UltimateCmds.IsCharged(Equipped._data.id)
                if IsCharged then
                    Client.UltimateCmds.Activate(Equipped._data.id)
                end
            end
            if Hey3y then
                BuyLastEgg()
            end
            if Heyy then
                BuyEgg(WantedEgg, GetMaxEggsAbleToOpen())
            end
            if Frut then
                GetFruits()
            end
            if Fag then
                GetFlags()
            end
            if Fag2 then
                RF("Spinny Wheel: Request Spin"):InvokeServer("DiamondWheel")
            end
            if vut then
                Venders()
            end
            if ToHateYou then
                OpenAllGifts()
            end
            if YesLol then
                AutoFarmZones()
            end
            if Rebi then
                Rebirth()
            end
            if ClaimRank then
                ClaimRanks()
            end
            if gg or YesLol then
                Collect()
            end
            if SqueakyToy then
                RF("SqueakyToy_Consume"):InvokeServer()
            end
            if ToyBall then
                RF("ToyBall_Consume"):InvokeServer()
            end
            if ToyBone then
                RF("ToyBone_Consume"):InvokeServer()
            end
            if Potionwant then
                GetPotions()
            end
            if DayCareyes then
                DayCare()
            end
            if Custom then
                CustomEggs(WantedCustomEgg, false)
            end
        end)
    end
end)

spawn(function()
    while wait(1) do
        pcall(function()
            Run()
        end)
    end
end)


spawn(function()
    while wait() do
        pcall(function()
            if Yes then
                local OldPos = Player.Character:GetModelCFrame()
                for i,v in next, workspace.__THINGS.HiddenPresents:GetChildren() do
                    if v:IsA("BasePart") and v.Transparency == 0 then
                        Player.Character:SetPrimaryPartCFrame(v.CFrame)
                        wait(.1)
                        Clicked(GetPresentTable(v))
                        break
                    end
                end
                Player.Character:SetPrimaryPartCFrame(OldPos)
                wait(10)
            end
        end)
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
 
 
local Tabs = {
    AutoFarm = Window:AddTab({ Title = "AutoFarm", Icon = "" }),
    Comsumeables = Window:AddTab({ Title = "Comsumeables", Icon = "" }),
    Event = Window:AddTab({ Title = "Event", Icon = "" }),
    Keys = Window:AddTab({ Title = "+Keys", Icon = "" }),
    Misc = Window:AddTab({ Title = "Misc etc", Icon = "" }),
    AutoMinigame = Window:AddTab({ Title = "AutoMinigames", Icon = "" }),
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
    ------------------------------------------------------------------------------------------------- Event
    
    local Toggle = Tabs.Event:AddToggle("lfhkshjfhkhsdfjkhujhjahjuhahahahahaha", {Title = "Auto GoTo Event", Default = false})
    Toggle:OnChanged(function()
        EventToggle = Options.lfhkshjfhkhsdfjkhujhjahjuhahahahahaha.Value
    end)
    local Toggle = Tabs.Event:AddToggle("sdgfhgbjabdhbhasbfuiyheuihiuhiduf", {Title = "Auto Comsume Mega II Dice", Default = false})
    Toggle:OnChanged(function()
        MegaUse = Options.sdgfhgbjabdhbhasbfuiyheuihiuhiduf.Value
    end)

    local Toggle = Tabs.Event:AddToggle("djshfiujsoidjfhnijsen", {Title = "Auto Roll", Default = false})
    Toggle:OnChanged(function()
        Rolled = Options.djshfiujsoidjfhnijsen.Value
    end)

    local Toggle = Tabs.Event:AddToggle("dfokjsodhnfgjsdbngkjbnnvv", {Title = "Auto Combine", Default = false})
    Toggle:OnChanged(function()
        Combine = Options.dfokjsodhnfgjsdbngkjbnnvv.Value
    end)
    local Dropdown = Tabs.Event:AddDropdown("sdkfbhkjhejkrhkje", {Title = "Dices",Values = Dice,Multi = false,Default = 1})
    Dropdown:OnChanged(function(Value)
        SelectedDice = Value
    end)

    local Toggle = Tabs.Event:AddToggle("asdbujyhbeubbhwsbdhjbhjcb", {Title = "Auto Buy Dice", Default = false})
    Toggle:OnChanged(function()
        Buydice = Options.asdbujyhbeubbhwsbdhjbhjcb.Value
    end)

    local Toggle = Tabs.Event:AddToggle("djsfjibsenjkwnbqkjenkjdnnnanananan", {Title = "Auto Buy Upgrade", Default = false})
    Toggle:OnChanged(function()
        UpgradeStuff = Options.djsfjibsenjkwnbqkjenkjdnnnanananan.Value
    end)
    local Dropdown = Tabs.Event:AddDropdown("disfhuiyeowunbfiunikjbnsdxfjkbjkbad", {Title = "Upgrades",Values = Upgrades,Multi = false,Default = 1})
    Dropdown:OnChanged(function(Value)
        SelectedUpgrade = Value
    end)

    local Toggle = Tabs.Event:AddToggle("dsfkhlkjshbfjghbjhsdbfjknsjdfhjkhkjhjas", {Title = "No RNG Roll Animation", Default = false})
    Toggle:OnChanged(function()
        NoHatch = Options.dsfkhlkjshbfjghbjhsdbfjknsjdfhjkhkjhjas.Value
    end)
    local Toggle = Tabs.Event:AddToggle("skdjfhbjkshbdfjhsdjhfikjbnjvnnonsda", {Title = "Combine All Dice", Default = false})
    Toggle:OnChanged(function()
        CombineAll = Options.skdjfhbjkshbdfjhsdjhfikjbnjvnnonsda.Value
    end)
    local Toggle = Tabs.Event:AddToggle("kjjdhfshfajhdsfhnkjksdf", {Title = "Auto Buy  All Upgrades", Default = false})
    Toggle:OnChanged(function()
        UpgradeAll = Options.kjjdhfshfajhdsfhnkjksdf.Value
    end)
    ------------------------------------------------------------------------------------------------- Others

    local Toggle = Tabs.AutoFarm:AddToggle("Rend", {Title = "Disable 3D Rendering", Default = false})
    Toggle:OnChanged(function()
        Norender = Options.Rend.Value
        if Norender then
            RunService:Set3dRenderingEnabled(false)
        else
            RunService:Set3dRenderingEnabled(true)
        end
    end)
    local Toggle = Tabs.AutoFarm:AddToggle("lkjhnfdjkgnjdfkgbjkdfngjkndfkg", {Title = "Automaticly go through game", Default = false})
    Toggle:OnChanged(function()
        YesLol = Options.lkjhnfdjkgnjdfkgbjkdfngjkndfkg.Value
    end)

    local Toggle = Tabs.AutoFarm:AddToggle("PetCoin", {Title = "Auto Break Nearest Coin", Default = false})
    Toggle:OnChanged(function()
        AutoFarm = Options.PetCoin.Value
    end)
    local Toggle = Tabs.AutoFarm:AddToggle("Lols", {Title = "Auto Ultimate", Default = false})
    Toggle:OnChanged(function()
        UltimateButtons = Options.Lols.Value
    end)
    local Toggle = Tabs.AutoFarm:AddToggle("DayCareyes", {Title = "Auto DayCare", Default = false})
    Toggle:OnChanged(function()
        DayCareyes = Options.DayCareyes.Value
    end)
    
    local Toggle = Tabs.AutoFarm:AddToggle("f93", {Title = "Infinite Pet Speed", Default = false})
    Toggle:OnChanged(function()
        PetSpeed = Options.f93.Value
    end)
    local Toggle = Tabs.AutoFarm:AddToggle("f933", {Title = "Skip Egg HatchingAnimation", Default = false})
    Toggle:OnChanged(function()
        NoHatch2 = Options.f933.Value
    end)
    local Toggle = Tabs.AutoFarm:AddToggle("Egg2d", {Title = "Auto Open Last Egg", Default = false})
    Toggle:OnChanged(function()
        Hey3y = Options.Egg2d.Value
    end)
    local Toggle = Tabs.AutoFarm:AddToggle("Eggd", {Title = "Auto Open Egg", Default = false})
    Toggle:OnChanged(function()
        Heyy = Options.Eggd.Value
    end)
    local Dropdown = Tabs.AutoFarm:AddDropdown("Ds", {Title = "Eggs",Values = EggTable,Multi = false,Default = 1})
    Dropdown:OnChanged(function(Value)
        WantedEgg = Value
    end)

    local Toggle = Tabs.AutoFarm:AddToggle("Edsjfbhjkdshbfggd", {Title = "Auto Open Custom Egg", Default = false})
    Toggle:OnChanged(function()
        Custom = Options.Edsjfbhjkdshbfggd.Value
    end)
    local New = CustomEggs(nil, true)
    local Dropdown = Tabs.AutoFarm:AddDropdown("Ds", {Title = "Custom Eggs",Values = New,Multi = false,Default = 1})
    Dropdown:OnChanged(function(Value)
        WantedCustomEgg = Value
    end)

    local Toggle = Tabs.AutoFarm:AddToggle("Toyo224u", {Title = "Auto DiamondWheel", Default = false})
    Toggle:OnChanged(function()
        Fag2 = Options.Toyo224u.Value
    end)
    local Toggle = Tabs.AutoFarm:AddToggle("Toyou2", {Title = "Auto Buy Venders", Default = false})
    Toggle:OnChanged(function()
        vut = Options.Toyou2.Value
    end)
    local Toggle = Tabs.AutoFarm:AddToggle("Orbs", {Title = "Auto Collect Orbs", Default = false})
    Toggle:OnChanged(function()
        gg = Options.Orbs.Value
    end)

    local Toggle = Tabs.AutoFarm:AddToggle("Gifts", {Title = "Auto Find Hidden Presents", Default = false})
    Toggle:OnChanged(function()
        Yes = Options.Gifts.Value
    end)
    local Toggle = Tabs.Comsumeables:AddToggle("Toyou", {Title = "Auto Eat Fruits", Default = false})
    Toggle:OnChanged(function()
        Frut = Options.Toyou.Value
    end)
    local Toggle = Tabs.Comsumeables:AddToggle("Toyo24u", {Title = "Auto Place Flags", Default = false})
    Toggle:OnChanged(function()
        Fag = Options.Toyo24u.Value
    end)

    local Dropdown = Tabs.Comsumeables:AddDropdown("Ds", {Title = "Flags",Values = Flags,Multi = false,Default = 1})
    Dropdown:OnChanged(function(Value)
        WantedFlag = Value
    end)
    local Toggle = Tabs.Comsumeables:AddToggle("Potionwant", {Title = "Auto Use All Potions", Default = false})
    Toggle:OnChanged(function()
        Potionwant = Options.Potionwant.Value
    end)
    local Toggle = Tabs.Comsumeables:AddToggle("PARTY", {Title = "Auto Party Box", Default = false})
    Toggle:OnChanged(function()
        PARTY = Options.PARTY.Value
    end)
    local Toggle = Tabs.Comsumeables:AddToggle("PINATA", {Title = "Auto Pinata", Default = false})
    Toggle:OnChanged(function()
        PINATA = Options.PINATA.Value
    end)
    local Toggle = Tabs.Comsumeables:AddToggle("COMET", {Title = "Auto Comet", Default = false})
    Toggle:OnChanged(function()
        COMET = Options.COMET.Value
    end)
    local Toggle = Tabs.Comsumeables:AddToggle("LUCKYBLOCK", {Title = "Auto Lucky Block", Default = false})
    Toggle:OnChanged(function()
        LUCKYBLOCK = Options.LUCKYBLOCK.Value
    end)

    local Toggle = Tabs.Comsumeables:AddToggle("ALL", {Title = "Auto Quick Items", Default = false})
    Toggle:OnChanged(function()
        ALL = Options.ALL.Value
    end)
    local Toggle = Tabs.Comsumeables:AddToggle("kjfhdijkfhsd", {Title = "Auto Use ToyBalls", Default = false})
    Toggle:OnChanged(function()
        ToyBall = Options.kjfhdijkfhsd.Value
    end)
    local Toggle = Tabs.Comsumeables:AddToggle("kjfhdajhdjshdijkfhsd", {Title = "Auto Use SqueakyToys", Default = false})
    Toggle:OnChanged(function()
        SqueakyToy = Options.kjfhdajhdjshdijkfhsd.Value
    end)

    local Toggle = Tabs.Comsumeables:AddToggle("kjfhdajhdhjbgdjkifhkfgjkfdhgkjdjshdijkfhsd", {Title = "Auto Use ToyBones", Default = false})
    Toggle:OnChanged(function()
        ToyBone = Options.kjfhdajhdhjbgdjkifhkfgjkfdhgkjdjshdijkfhsd.Value
    end)
    Tabs.Comsumeables:AddButton({Title = "Open All Gifts",Description = "Opens All Gifts in Inventory",Callback = function()
        OpenAllGifts()
    end})
    local Toggle = Tabs.Comsumeables:AddToggle("HateNig", {Title = "Auto Open All Gifts", Default = false})
    Toggle:OnChanged(function()
        ToHateYou = Options.HateNig.Value
    end)
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Tabs.Misc:AddButton({Title = "Auto Grab All ShinyRelics",Description = "Grabs all relics Working",Callback = function()
        for i,v in next, Workspace.__THINGS.ShinyRelics:GetChildren() do
            if v:IsA("BasePart") and v.Transparency == 0 then
                F.RelicClicked(getShiny(v))
            end
        end
    end})

    local Toggle = Tabs.Misc:AddToggle("Ranked", {Title = "Auto Claim Ranks Rewards", Default = false})
    Toggle:OnChanged(function()
        g = Options.Ranked.Value
    end)
    Tabs.Misc:AddButton({Title = "Auto Selected Obby",Description = "Automaticly does obby must be in obby to work",Callback = function()
        Doobbystuff()
    end})
    Tabs.Misc:AddButton({Title = "Auto Teleport Obby",Description = "Teleports so Obby",Callback = function()
        TeleportObby()
    end})
    local Dropdown = Tabs.Misc:AddDropdown("idkanymore", {Title = "Obbys",Values = Instances,Multi = false,Default = 1,})
    Dropdown:OnChanged(function(Value)
        WantedObby = Value
    end)

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    local Toggle = Tabs.AutoMinigame:AddToggle("DigSite", {Title = "Auto DigSites", Default = false})
    Toggle:OnChanged(function()
        Toggle = Options.DigSite.Value
        Stepped:Connect(function()
            if Toggle then
                VG.NoClip()
            end
        end)
        spawn(function()
            while Toggle and wait() do
                pcall(function()
                    Dig()
                end)
            end
        end)
    end)
    local Dropdown = Tabs.AutoMinigame:AddDropdown("e234", {Title = "Dig Areas",Values = {"AdvancedDigsite", "Digsite"},Multi = false,Default = 2})
    Dropdown:SetValue("")
    Dropdown:OnChanged(function(Value)
        Method2 = Value
    end)

    local Toggle = Tabs.AutoMinigame:AddToggle("DigSiteAura", {Title = "Dig Aura", Default = false})
    Toggle:OnChanged(function()
        Digaura = Options.DigSiteAura.Value
        spawn(function()
            while wait(.2) and Digaura do
                pcall(function()
                    DigAura()
                end)
            end
        end)
    end)
    local Toggle = Tabs.AutoMinigame:AddToggle("Fih", {Title = "Auto Fishing", Default = false})
    Toggle:OnChanged(function()
        Fishe = Options.Fih.Value
        spawn(function()
            while wait() and Fishe do
                pcall(function()
                    Activated()
                end)
            end
        end)
        spawn(function()
            while Fishe and wait(300) do
                pcall(function()
                    User:SendMouseButtonEvent(0,0, 0, true, game, 0)
                    User:SendMouseButtonEvent(0,0, 1, true, game, 0)
                    wait(1)
                    User:SendMouseButtonEvent(0,0, 0, false, game, 0)
                    User:SendMouseButtonEvent(0,0, 1, false, game, 0)
                end)
            end
        end)
    end)

    local Dropdown = Tabs.AutoMinigame:AddDropdown("e34", {Title = "Fishing Areas",Values = {"AdvancedFishing", "Fishing"},Multi = false,Default = 1,})
    Dropdown:OnChanged(function(Value)
        Method = Value
    end)

    local Toggle = Tabs.Keys:AddToggle("dshfjksdhbfkjhsdkfjhsd", {Title = "Auto Tech Chest", Default = false})
    Toggle:OnChanged(function()
        TechKey = Options.dshfjksdhbfkjhsdkfjhsd.Value
    end)
    local Toggle = Tabs.Keys:AddToggle("sdfjhkjhfgjklhskdhwaqwqqq", {Title = "Auto Void Chest", Default = false})
    Toggle:OnChanged(function()
        VoidKey = Options.sdfjhkjhfgjklhskdhwaqwqqq.Value
    end)
    local Toggle = Tabs.Keys:AddToggle("jkhfdjkshfjkhsjejnnw", {Title = "Auto Crystal Chest", Default = false})
    Toggle:OnChanged(function()
        CrystalKey = Options.jkhfdjkshfjkhsjejnnw.Value
    end)
    local Toggle = Tabs.Keys:AddToggle("sdfhkjshknflkjsenjefencfnjnjvnjvnjvnjvnjvu", {Title = "Auto Secret Key Huge Hunter", Default = false})
    Toggle:OnChanged(function()
        SecretRoom = Options.sdfhkjshknflkjsenjefencfnjnjvnjvnjvnjvnjvu.Value
    end)
    local Toggle = Tabs.Keys:AddToggle("jkhfdjkshfjkhbdfbhskhfdhjbfjbvhbvjkhsjejnnw", {Title = "Auto Craft All Keys", Default = false})
    Toggle:OnChanged(function()
        AllKeys = Options.jkhfdjkshfjkhbdfbhskhfdhjbfjbvhbvjkhsjejnnw.Value
    end)
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
 
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.AutoFarm)
 
Window:SelectTab(1)
 
Fluent:Notify({
    Title = "V.G Hub",
    Content = "The script has been loaded.",
    Duration = 8
})
 
SaveManager:LoadAutoloadConfig()
