loadstring(game:HttpGet("https://raw.githubusercontent.com/CKScrips/HubBuild/main/Extras/Global.lua"))()
VG.DisableConnection(Error)
VG.DisableConnection(Idled)
repeat wait() until Player.PlayerGui:FindFirstChild("PlayButton",true)
RunService.Stepped:Connect(function()
    pcall(function()
        if Player.PlayerGui:FindFirstChild("NewsApp",true).Enabled then
            for i,v in pairs(getconnections(Player.PlayerGui:FindFirstChild("PlayButton",true).MouseButton1Click)) do
                v:Fire()
            end
        end
        if Player.PlayerGui:FindFirstChild("ChooseParent",true) then
            for i,v in pairs(getconnections(Player.PlayerGui:FindFirstChild("ChooseParent",true).MouseButton1Click)) do
                v:Fire()
            end
        end
        if Workspace:FindFirstChild("ServerSidedMapSeats") then
            Workspace.ServerSidedMapSeats:Destroy()
        end
    end)
end)
 
local Table = {6152116144, 185655149}
local Set = setfpscap
local getupvalue = getupvalue or debug.getupvalue
local getconstant = getconstant or debug.getconstant
local getconstants = getconstants or debug.getconstants
local getgc = getgc or get_gc_objects or debug.getgc
local getreg = getreg or getregistry or debug.getregistry
local get_thread_context = get_thread_context or getthreadcontext or getidentity or syn.get_thread_identity
local get_thread_identity = get_thread_context
local set_thread_context = set_thread_context or setthreadcontext or setidentity or syn.set_thread_identity
local set_thread_identity = set_thread_context
local Remotes = {}
local Inventorys = ReplicatedStorage.ClientDB.Inventory
local Count = 0
local Stores = {
    "CoffeeShop",
    "Supermarket",
    "PizzaShop",
    "ToyShop",
    "Obbies",
    "Neighborhood",
    "CampingShop",
    "AutoShop",
    "Nursery",
    "Cave",
    "IceCream",
    "PotionShop",
    "SkyCastle",
    "Hospital",
    "HatShop",
    "PetShop",
    "School",
    "BabyShop",
    "HotSpringHouse",
    "SafetyHub",
    "DebugInterior",
    "VIP",
    "Salon",
    "SpleefMinigame",
    "SimonSaysMinigame",
    "WinterCastle"
}
 
local Baths = {
    "StylishShower",
    "CheapBathtub",
    "ModernShower",
    "Bathtub",
    "GingerbreadShower",
    "HotTub"
}
 
local FreeFoods = {
    "ham_vip",
    "water_vip",
    "chocolate_milk_vip",
    "popcorn_vip",
    "marshmallow_on_a_stick",
    "healing_apple",
    "teachers_apple",
}
 
local Beds = {
    "FancyPetBed",
    "ModernPetBed",
    "CircularPetBed",
    "RectangularPetBed",
    "NormalCrib",
    "BasicCrib",
    "RoyalCrib",
    "PoshCrib",
}
local Tasks = {
    "hungry",
    "sleepy",
    "thirsty",
    "bored",
    "dirty",
    "camping",
    "sick",
    "school",
    "pool_party",
    "salon",
    "pizza_party",
    "beach_party"
}
 
local Eggs = {
    "cracked_egg",
    "regular_pet_egg",
    "royal_egg",
    "retired_egg",
    "seasia_2023_egg",
    "mythic_egg",
    "japan_2022_egg",
    "danger_2023_egg",
}
 
local gifts = {
    "smallgift",
    "biggift",
    "massivegift",
    "legend_hat_2022_simple_chest",
    "legend_hat_2022_regal_chest"
}
local Obbys = {
    "miniworld",
    "coastal_climb",
    "shipwreck_bay",
    "ancient_ruins",
    "lonelypeak",
    "pyramid",
    "tinyisles"
}
 
local RetardedBullShit = {
    "CashRegister",
    "GoldenCashRegister"
}
 
local PP = {}
 
local Part = Instance.new("Part")
Part.Name = "P"
Part.Size = Vector3.new(9e9,0,9e9)
Part.Anchored = true
Part.Transparency = 0.5
Part.CFrame = CFrame.new(5000,5000,5000)
Part.Parent = Workspace
ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("Core"):WaitForChild("InteriorsM"):WaitForChild("InteriorsM")
local Location = nil
for i, v in pairs(getgc()) do
    if type(v) == "function" then
        if getfenv(v).script == ReplicatedStorage.ClientModules.Core.InteriorsM.InteriorsM then
            if table.find(getconstants(v), "LocationAPI/SetLocation") then
                Location = v
                break
            end
        end
    end
end
 
local SetLocation = function(A, B, C)
    local O = get_thread_identity()
    set_thread_identity(2)
    Location(A, B, C)
    set_thread_identity(7)
end
local Home = function()
    if Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA("Model") then
        return Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA("Model").Name
    else
        return false
    end
end
local PersonHome = function()
    if Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA("Model") then
        return Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA("Model").Name
    else
        return false
    end
end
local Store = function()
    if Workspace.Interiors:FindFirstChildWhichIsA("Model") then
        if not string.find(Workspace.Interiors:FindFirstChildWhichIsA("Model").Name,"MainMap") and not
            string.find(Workspace.Interiors:FindFirstChildWhichIsA("Model").Name,"Neighborhood")
        then
            return Workspace.Interiors:FindFirstChildWhichIsA("Model").Name
        else
            return false
        end
    else
        return false
    end
end
 
local MainMap = function()
    if Workspace.Interiors:FindFirstChildWhichIsA("Model") then
        if string.find(Workspace.Interiors:FindFirstChildWhichIsA("Model").Name,"MainMap") then
            return Workspace.Interiors:FindFirstChildWhichIsA("Model").Name
        else
            return false
        end
    else
        return false
    end
end
 
local Neighborhood = function()
    if Workspace.Interiors:FindFirstChildWhichIsA("Model") then
        if string.find(Workspace.Interiors:FindFirstChildWhichIsA("Model").Name,"Neighborhood") then
            return Workspace.Interiors:FindFirstChildWhichIsA("Model").Name
        else
            return false
        end
    else
        return false
    end
end
 
local GoToStore = function(Name)
    if Store() == Name then
        return true
    end
 
    SetLocation(Name, "MainDoor", {})
 
    while Store() ~= Name do
        wait()
    end
    if Home() then
        return true
    end
    return false
end
 
local GoToHome = function()
    SetLocation("housing", "MainDoor", {["house_owner"] = Player})
    while not Home() do
        wait()
 
    end
    if Home() then
 
        return true
    end
 
    return false
 
end
 
local GoToNeighborhood = function()
    SetLocation("Neighborhood", "MainDoor", {})
    while not Neighborhood() do
        wait()
 
    end
    if Neighborhood() then
 
        return true
    end
    return false
end
 
local GoToMainMap = function()
    SetLocation("MainMap", "Neighborhood/MainDoor", {})
    while not MainMap() do
 
        wait()
    end
    if MainMap() then
 
        return true
    end
    return false
end
 
local GoToPersonsHouse = function(Name)
    SetLocation("housing","MainDoor",{["house_owner"] = Players[Name]})
    while not PersonHome() do
 
        wait()
    end
    if PersonHome() then
 
        return true
    end
    return false
end
local Bed = function(Name)
    GoToHome()
    Player.Character.HumanoidRootPart.CFrame = Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA('Model'):GetModelCFrame():ToWorldSpace(CFrame.new(0, 0, -6)) 
    for i, v in pairs(Workspace.HouseInteriors.furniture:GetChildren()) do
        if v:FindFirstChildWhichIsA("Model") and (table.find(Beds, v:FindFirstChildWhichIsA("Model").Name)) then
            local String = string.split(v.Name,"/f")[2]
            print(String)
            return "f".. String
        end
    end
end
local Cash = function()
    for i, v in pairs(Workspace.HouseInteriors.furniture:GetChildren()) do
        if v:FindFirstChildWhichIsA("Model") and (table.find(RetardedBullShit, v:FindFirstChildWhichIsA("Model").Name)) then
            local String = string.split(v.Name,"/f")[2]
            print(String)
            return "f".. String
        end
    end
end
 
local Showers = function(Name)
    GoToHome()
    Player.Character.HumanoidRootPart.CFrame = Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA('Model'):GetModelCFrame():ToWorldSpace(CFrame.new(0, 0, -6)) 
    for i, v in pairs(Workspace.HouseInteriors.furniture:GetChildren()) do
        if v:FindFirstChildWhichIsA("Model") and (table.find(Baths, v:FindFirstChildWhichIsA("Model").Name)) then
            local String = string.split(v.Name,"true/")[2]
            print(String)
            return String
        end
    end
end
 
local NoCliper = function()
    for i,v in next, Player.Character:GetChildren() do
        if v:IsA("BasePart") then
            v.CanCollide = false
            v.Velocity = Vector3.new(0,0,0)
        end
    end
    return Player.Character
end
 
local Neons = {}
local AilmentFurnitues = {}
local Neon = {}
local Spec = {}
local Key = {}
local PetID
local Pet
local PetsShow = {}
local List = {}
local JoJo = {}
local GGO = {}
local Ps = {}
for i,v in next, Players:GetPlayers() do
    table.insert(Ps, v.Name)
end
for i, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
    local key = tostring(v["id"]) .. " - " .. tostring(v["properties"]["age"]) .. " years old"
    if not table.find(List, Key) and v.kind ~= "practice_dog" then
        PetsShow[key] = v
        table.insert(List, key)
        table.sort(List)
    end
end
for i, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
    if not table.find(JoJo,tostring(v["id"])) and v.kind ~= "practice_dog" then
        local Key2 = tostring(v["id"])
        GGO[Key2] = v
        table.insert(JoJo,Key2)
        table.sort(JoJo)
    end
end
 
UserInputService.WindowFocusReleased:Connect(function()
    if Render then
        RunService:Set3dRenderingEnabled(false)
        if table.find(Table, game.PlaceId) then
            Set(30)
        else
            Set(15)
        end
    end
end)
UserInputService.WindowFocused:Connect(function()
    if Render then
        RunService:Set3dRenderingEnabled(true)
        Set(100)
    end
end)
 
for i, v in pairs(getupvalue(require(ReplicatedStorage.Fsys).load("RouterClient").init, 4)) do
    v.Name = i
end
pcall(function()
    ReplicatedStorage.API:FindFirstChild("DailyLoginAPI/ClaimDailyReward"):InvokeServer()
end)
 
local a = {
    ["sleepy"] = function(c)
        spawn(function()
            while wait(3) and c.Parent == Player.PlayerGui.AilmentsMonitorApp.Ailments and PetFarm do
                if c.Parent == Player.PlayerGui.AilmentsMonitorApp.Ailments then
                    print(Player, Bed(), 'UseBlock', {['cframe'] = Player.Character.HumanoidRootPart.CFrame}, C)
                    ReplicatedStorage:FindFirstChild('HousingAPI/ActivateFurniture',true):InvokeServer(Player, Bed(), 'UseBlock', {['cframe'] = Player.Character.HumanoidRootPart.CFrame}, C)
                    if not Bed() then
                        GoToMainMap()
                        GoToHome()
                    end
                end
            end
        end)
        repeat wait(0) until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ['dirty'] = function(c)
        spawn(function()
            while c.Parent == Player.PlayerGui.AilmentsMonitorApp.Ailments and wait(3) do
                print(Player, Bed(), 'UseBlock', {['cframe'] = Player.Character.HumanoidRootPart.CFrame}, C)
                ReplicatedStorage:FindFirstChild("HousingAPI/ActivateFurniture",true):InvokeServer(Player, Showers(), 'UseBlock', {['cframe'] = Player.Character.HumanoidRootPart.CFrame}, C)
                if not Showers() then
                    GoToMainMap()
                    GoToHome()
                end
            end
        end)
        repeat wait() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
        end,
    ["hungry"] = function(c)
        ReplicatedStorage:FindFirstChild("ShopAPI/BuyItem",true):InvokeServer('food', 'pizza', {})
        ReplicatedStorage:FindFirstChild("ToolAPI/BakeItem",true):InvokeServer()
        while Player.Character:FindFirstChild('PizzaTool') do wait() end
        while not Player.Character:FindFirstChild('PizzaTool') do wait() end
        local Foods = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.food or {}
        local Pizza
        for i,v in pairs(Foods) do
            if v.id == 'pizza' then
                Pizza = v.unique
                break
            end
        end
        if not Pizza then
            return
        end
        wait(2)
        ReplicatedStorage:FindFirstChild("PetObjectAPI/CreatePetObject",true):InvokeServer("__Enum_PetObjectCreatorType_2", {["unique_id"] = Pizza})
        ReplicatedStorage:FindFirstChild("PetAPI/ConsumeFoodItem",true):FireServer(Pizza)
        repeat wait() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["thirsty"] = function(c)
        ReplicatedStorage:FindFirstChild("ShopAPI/BuyItem",true):InvokeServer('food', 'tea', {})
        local Foods = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.food or {}
        local Tea
        for i, v in pairs(Foods) do
            if v.id == 'tea' then
                Tea = v.unique
                break
            end
        end
        if not Tea then
            return
        end
        wait(2)
        print(Tea)
        ReplicatedStorage:FindFirstChild("PetObjectAPI/CreatePetObject",true):InvokeServer("__Enum_PetObjectCreatorType_2", {["unique_id"] = Tea})
        ReplicatedStorage:FindFirstChild("PetAPI/ConsumeFoodItem",true):FireServer(Tea)
        repeat wait() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["sick"] = function(c)
        repeat wait(0) ReplicatedStorage:FindFirstChild("MonitorAPI/HealWithDoctor",true):FireServer() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["adoption_party"] = function(c)
        GoToStore('Nursery')
        repeat wait() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["school"] = function(c)
        GoToStore('School')
        repeat wait() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["pizza_party"] = function(c)
        GoToStore("PizzaShop")
        repeat wait() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["salon"] = function(c)
        GoToStore("Salon")
        repeat wait() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["beach_party"] = function(c)
        GoToMainMap()
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(Workspace.StaticMap.Beach.BeachPartyAilmentTarget.Position + Vector3.new(0, 5, 0))
        repeat wait() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["camping"] = function(c)
        GoToMainMap()
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(Workspace.StaticMap.Campsite.CampsiteOrigin.Position + Vector3.new(0, 5, 0))
        repeat wait() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ['bored'] = function(c)
        GoToMainMap()
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(Workspace.StaticMap.Park.AilmentTarget.Position + Vector3.new(0, 5, 0))
        repeat wait() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end
}
 
 
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/CkMScripts/HubBuild/main/Fluent/Main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/CkMScripts/HubBuild/main/Fluent/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/CkMScripts/HubBuild/main/Fluent/InterfaceManager.lua"))()
 
local Window = Fluent:CreateWindow({
    Title = "CkM Hub: Game " .. MarketplaceService:GetProductInfo(game.PlaceId).Name,
    SubTitle = "",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.Delete -- Used when theres no MinimizeKeybind
})
 
 
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}
 
local Options = Fluent.Options
 
do
    Fluent:Notify({
        Title = "CkM Hub",
        Content = "Congrats, you're using CkM Hub " .. Verison,
        SubContent = "Have fun!", -- Optional
        Duration = 10 -- Set to nil to make the notification not disappear
    })
 
    local Toggle = Tabs.Main:AddToggle("no", {Title = "Baby Farm", Default = false})
    Toggle:OnChanged(function()
        BabyFarm = Options.no.Value
        spawn(function()
            if BabyFarm then
                ReplicatedStorage.API["TeamAPI/ChooseTeam"]:InvokeServer("Babies", true)
            end 
            if not BabyFarm then 
                ReplicatedStorage.API["TeamAPI/ChooseTeam"]:InvokeServer("Parents", true)
            end 
        end)
        spawn(function()
            while wait(1) and BabyFarm do 
                pcall(function()
                    for i,v in pairs(Player.PlayerGui.AilmentsMonitorApp.Ailments:GetChildren()) do
                        if v:IsA("Frame") then
                            wait(.1)
                            ReplicatedStorage.API["MonitorAPI/AddAdditive"]:FireServer(v.Name, math.random(1,100))
                        end
                    end 
                end)
            end 
        end)
    end)
    local Toggle = Tabs.Main:AddToggle("CPU", {Title = "LowCpu render", Default = false})
    Toggle:OnChanged(function()
        Render = Options.CPU.Value
    end)
    local Toggle = Tabs.Main:AddToggle("Cr", {Title = "Lag Server", Default = false})
    Toggle:OnChanged(function()
        Crash = Options.Cr.Value
        RunService.RenderStepped:Connect(function()
            if Crash then
                for i=1,50 do
                    ReplicatedStorage.API["TeamAPI/ChooseTeam"]:InvokeServer("Babies", true)
                end 
            end 
        end)
    end)
    local Toggle = Tabs.Main:AddToggle("Ne", {Title = "Auto Neon", Default = false})
    Toggle:OnChanged(function()
        Neon = Options.Ne.Value
        spawn(function()
            while Neon and wait() do
                pcall(function()
                    local N = 0
                    for i,v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
                        local Old = v.id
                        if string.find(Old,v.id) and v.properties.age == 6 then
                            N = N + 1
                            table.insert(Neons, v.unique)
                            if N == 4 then
                                ReplicatedStorage.API:FindFirstChild("PetAPI/DoNeonFusion"):InvokeServer({unpack(Neons)})
                                table.clear(Neons)
                                N = 0
                            end
                        end
                    end
                end)
            end
        end)
    end)
 
    local Dropdown = Tabs.Main:AddDropdown("d", {
        Title = "Pets",
        Values = List,
        Multi = false,
        Default = 1,
    })
 
    Dropdown:SetValue(nil)
 
    Dropdown:OnChanged(function(Value)
        Key = PetsShow[Value]
    end)
    local Toggle = Tabs.Main:AddToggle("New", {Title = "Auto pet", Default = false})
    Toggle:OnChanged(function()
        PetFarm = Options.New.Value
        RunService.RenderStepped:connect(function()
            if PetFarm then
                pcall(function()
                    Workspace["P"].CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(0,-5,0))
                    NoCliper()
                end)
            end
        end)
        spawn(function()
            while wait(20) and PetFarm and Refresh do
                pcall(function()
                    ReplicatedStorage.API["ToolAPI/Unequip"]:InvokeServer(PetID)
                    Pet = ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(PetID)
                end)
            end
        end)
        if Key ~= nil then
            PetID = Key.unique
            ReplicatedStorage.API["ToolAPI/Unequip"]:InvokeServer(PetID)
            Pet, C = ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(PetID)
        end
        spawn(function()
            while wait() and PetFarm do
                pcall(function()
                    local Ailment = Player.PlayerGui.AilmentsMonitorApp.Ailments:FindFirstChildWhichIsA("Frame")
                    if Ailment then
                        local Name = Ailment.Name
                        if a[Name]then
                            a[Name](Ailment)
                        end
                    end
                    if Pet and C then
                        if C.Parent ~= Workspace.Pets then
                            ReplicatedStorage.API["ToolAPI/Unequip"]:InvokeServer(PetID)
                            Pet, C = ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(PetID)
                        end
                    else
                        ReplicatedStorage.API["ToolAPI/Unequip"]:InvokeServer(PetID)
                        Pet, C = ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(PetID)
                    end
                end)
            end
        end)
    end)
    local Toggle = Tabs.Main:AddToggle("New1", {Title = "SwitchOutFullyGrown", Default = false})
    Toggle:OnChanged(function()
        SwitchOutFullyGrown = Options.New1.Value
        spawn(function()
            while SwitchOutFullyGrown and wait() do
                pcall(function()
                    local Pets = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets or {}
                    if Pets[PetID] and Pets[PetID]["properties"]["age"] == 6 then
                        print(Pets[PetID]["properties"]["age"])
                        for i, v in pairs(Pets) do
                            if v["properties"]["age"] ~= 6 then
                                PetID = v.unique
                            end
                        end
                    end
                end)
            end
        end)
    end)
    local Toggle = Tabs.Main:AddToggle("New12", {Title = "SwitchOutEgg", Default = false})
    Toggle:OnChanged(function()
        SwitchOutEgg = Options.New12.Value
        spawn(function()
            while SwitchOutEgg and wait() do
                pcall(function()
                    local Pets = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets or {}
                    if not Pets[PetID]["id"]:match("egg") and not Pets[PetID]["id"]:match("basic_egg") then
                        for i, v in pairs(Pets) do
                            if v["id"]:match("egg") and not v["id"]:match("basic_egg") then
                                PetID = v.unique
                            end
                        end
                    end
                end)
            end
        end)
    end)
    local Toggle = Tabs.Main:AddToggle("New123", {Title = "Switch Out same Pet Species", Default = false})
    Toggle:OnChanged(function()
        True = Options.New123.Value
        spawn(function()
            while True and wait() do
                pcall(function()
                    local Pets = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets or {}
                    if v["id"] ~= sp or v["properties"]["age"] == 6 then
                        for i, v in pairs(Pets) do
                            if v["id"] == sp and v["properties"]["age"] ~= 6 then
                                PetID = v.unique
                            end
                        end
                    end
                end)
            end
        end)
    end)
    local Dropdown = Tabs.Main:AddDropdown("s", {
        Title = "Pets Species",
        Values = JoJo,
        Multi = false,
        Default = 1,
    })
 
    Dropdown:SetValue("DekuDimz")
 
    Dropdown:OnChanged(function(Value)
        sp = Value
    end)
    local Toggle = Tabs.Main:AddToggle("New1231", {Title = "Auto use Age Pot", Default = false})
    Toggle:OnChanged(function()
        Grow = Options.New1231.Value
        spawn(function()
            while Grow and wait() do
                pcall(function()
                    local Foods = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.food or {}
                    local Tea
                    for i, v in pairs(Foods) do
                        if v.kind == "pet_age_potion" then
                            Tea = v.unique
                            break
                        end
                    end
                    if not Tea then
                        return
                    end
                    wait(2)
                    local Pets = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets or {}
                    for i,v in next, Pets do
                        if v.kind == Petsc and v["properties"]["age"] ~= 6 then
                            PetID = v.unique
                            ReplicatedStorage.API["ToolAPI/Unequip"]:InvokeServer(PetID)
                            ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(PetID)
                        end
                    end
                    ReplicatedStorage:FindFirstChild("PetObjectAPI/CreatePetObject",true):InvokeServer("__Enum_PetObjectCreatorType_2", {["unique_id"] = Tea})
                    ReplicatedStorage:FindFirstChild("PetAPI/ConsumeFoodItem",true):FireServer(Tea)
                end)
            end
        end)
    end)
    local Dropdown = Tabs.Main:AddDropdown("a", {
        Title = "Pets Use potion on",
        Values = List,
        Multi = false,
        Default = 1,
    })
 
    Dropdown:SetValue("CkM")
 
    Dropdown:OnChanged(function(Value)
        Petsc = Value
    end)
    local Toggle = Tabs.Main:AddToggle("Hi", {Title = "Healing Aura", Default = false})
    Toggle:OnChanged(function()
        HealOthers = Options.Hi.Value
        spawn(function()
            while HealOthers and wait(2) do
                ReplicatedStorage.API["MonitorAPI/HealWithDoctor"]:FireServer()
            end
        end)
    end)
    local Toggle = Tabs.Main:AddToggle("Hi1", {Title = "Anti Pick Up", Default = false})
    Toggle:OnChanged(function()
        Family = Options.Hi1.Value
        if Family then
            ReplicatedStorage.API["FamilyAPI/CreateFamily"]:InvokeServer() 
        elseif not Family then
            ReplicatedStorage.API["FamilyAPI/LeaveFamily"]:InvokeServer()
        end
    end)
    local Toggle = Tabs.Main:AddToggle("Hi2", {Title = "Auto buy egg", Default = false})
    Toggle:OnChanged(function()
        Loll = Options.Hi2.Value
        spawn(function()
            while Loll and wait() do
                pcall(function()
                    wait(1)
                    ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("pets",Egg,{})
                end)
            end 
        end)
    end)
    local Dropdown = Tabs.Main:AddDropdown("a13", {
        Title = "Eggs",
        Values = Eggs,
        Multi = false,
        Default = 1,
    })
 
    Dropdown:SetValue("CkM")
 
    Dropdown:OnChanged(function(Value)
        Egg = Value
    end)
    local Toggle = Tabs.Main:AddToggle("Hi21", {Title = "Auto buy Gift", Default = false})
    Toggle:OnChanged(function()
        Loll = Options.Hi21.Value
        spawn(function()
            while Loll and wait() do
                pcall(function()
                    wait(1)
                    ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("gifts",Gifts,{})
                end)
            end 
        end)
    end)
    local Dropdown = Tabs.Main:AddDropdown("a132", {
        Title = "Gifts",
        Values = gifts,
        Multi = false,
        Default = 1,
    })
 
    Dropdown:SetValue("CkM")
 
    Dropdown:OnChanged(function(Value)
        Gift = Value
    end)
    local Toggle = Tabs.Main:AddToggle("Hi3", {Title = "Auto Open Gifts", Default = false})
    Toggle:OnChanged(function()
        System = Options.Hi3.Value
        spawn(function()
            while System do
                wait(2)
                local gifts = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.gifts or {}
                local GiftTable
                local GiftID
                local Gift
 
                for i, v in pairs(gifts) do
                    Gift = v.unique
 
                    pcall(function()
                        ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(Gift)
                        ReplicatedStorage.API:FindFirstChild("ShopAPI/OpenGift"):InvokeServer(Gift)
                    end)
                end
            end
        end)
    end)
    local Toggle = Tabs.Main:AddToggle("Hi4", {Title = "Auto Trade Apect Player", Default = false})
    Toggle:OnChanged(function()
        Trade = Options.Hi4.Value
        spawn(function()
            while Trade do wait()
                pcall(function()
                    for i,v in pairs(Players:GetPlayers()) do
                        if v ~= Player then
                            ReplicatedStorage.API:FindFirstChild("TradeAPI/AcceptOrDeclineTradeRequest"):InvokeServer(v,true)
                        end 
                    end 
                    ReplicatedStorage.API:FindFirstChild("TradeAPI/AcceptNegotiation"):FireServer()
                    ReplicatedStorage.API:FindFirstChild("TradeAPI/ConfirmTrade"):FireServer()
                    for i,v in pairs(getconnections(Player.PlayerGui.DialogApp.Dialog.NormalDialog.Buttons.ButtonTemplate.MouseButton1Click)) do
                        v.Function()
                        v:Fire()
                    end 
                end)
            end 
        end)
    end)
    local Toggle = Tabs.Main:AddToggle("Hi5", {Title = "Auto Buy from Player", Default = false})
    Toggle:OnChanged(function()
        Buy = Options.Hi5.Value
        spawn(function()
            while wait() and Buy do 
                pcall(function()
                    ReplicatedStorage.API:FindFirstChild("RefreshmentStandAPI/BuyRefreshment"):InvokeServer("hotdog_stand",Playt)
                    ReplicatedStorage.API:FindFirstChild("RefreshmentStandAPI/BuyRefreshment"):InvokeServer("lemonade_stand",Playt)
                    for i,v in pairs(getconnections(Player.PlayerGui.DialogApp.Dialog.NormalDialog.Buttons.ButtonTemplate.MouseButton1Click)) do
                        v.Function()
                        v:Fire()
                    end 
                end)
            end 
        end)
    end)
    local Toggle = Tabs.Main:AddToggle("Hi6", {Title = "Auto Buy from Player", Default = false})
    Toggle:OnChanged(function()
        Sus = Options.Hi6.Value
        spawn(function()
            while wait() and Sus do 
                pcall(function()
                    local Is 
                    if not Is then  
                        GoToPersonsHouse(tostring(Playt))
                        Player.Character.HumanoidRootPart.CFrame = Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA('Model'):GetModelCFrame():ToWorldSpace(CFrame.new(0, 0, -6)) 
                        wait(2)
                        Is = Cash()
                    end 
                    if Is then
                        ReplicatedStorage.API:FindFirstChild("HousingAPI/ActivateFurniture"):InvokeServer(Playt,Cash(),"UseBlock",50,Player.Character)
                        for i,v in pairs(getconnections(Player.PlayerGui.DialogApp.Dialog.NormalDialog.Buttons.ButtonTemplate.MouseButton1Click)) do
                            v.Function()
                            v:Fire()
                        end 
                    end
                end)
            end 
        end)
    end)
    local Toggle = Tabs.Main:AddToggle("Hi6", {Title = "Auto Transfer all to Player", Default = false})
    Toggle:OnChanged(function()
        Sus = Options.Hi6.Value
        TransferPet = A
        spawn(function()
            while TransferPet and wait(1) do
                pcall(function()
                    if not Player.PlayerGui.TradeApp.Frame.Visible then
                        ReplicatedStorage.API:FindFirstChild("TradeAPI/SendTradeRequest"):FireServer(Playt)
                    end 
                    if Player.PlayerGui.TradeApp.Frame.Visible then
                        if Petsd == "Pets" then
                            for i, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
                                ReplicatedStorage.API:FindFirstChild("TradeAPI/AddItemToOffer"):FireServer(v.unique)
                            end
                        end 
                        if Petsd == "GrownPets" then
                            for i, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
                                if v["properties"]["age"] == 6 then
                                    ReplicatedStorage.API:FindFirstChild("TradeAPI/AddItemToOffer"):FireServer(v.unique)
                                end 
                            end
                        end 
                        if Petsd == "Eggs" then
                            for i, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
                                if v["id"]:find("egg") and not v["id"]:find("_2022") then
                                    ReplicatedStorage.API:FindFirstChild("TradeAPI/AddItemToOffer"):FireServer(v.unique)
                                end 
                            end
                        end 
                        if Petsd == "Gifts" then
                            for i,v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.gifts) do
                                ReplicatedStorage.API:FindFirstChild("TradeAPI/AddItemToOffer"):FireServer(v.unique)
                            end 
                        end 
                        ReplicatedStorage.API:FindFirstChild("TradeAPI/AcceptNegotiation"):FireServer()
                        ReplicatedStorage.API:FindFirstChild("TradeAPI/ConfirmTrade"):FireServer()
                        for i,v in pairs(getconnections(Player.PlayerGui.DialogApp.Dialog.NormalDialog.Buttons.ButtonTemplate.MouseButton1Click)) do
                            v.Function()
                            v:Fire()
                        end 
                    end 
                end)
            end 
        end)
    end)
    local Dropdown = Tabs.Main:AddDropdown("s", {
        Title = "Players",
        Values = Ps,
        Multi = false,
        Default = 1,
    })
 
    Dropdown:SetValue("CkM")
 
    Dropdown:OnChanged(function(Value)
        Playt = Value
    end)
    Tabs.Main:AddButton({Title = "Grab Trading Linence",Description = "Grabs Trading Linence",Callback = function()
        ReplicatedStorage.API:FindFirstChild("TradeAPI/BeginQuiz"):FireServer()
        for i,v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v,"question_index") then
                for i,v in pairs(v.quiz) do
                    ReplicatedStorage.API:FindFirstChild("TradeAPI/AnswerQuizQuestion"):FireServer(v.answer)
                end 
            end 
        end 
    end})
    Tabs.Main:AddButton({Title = "Go To Store",Description = "Goes to selected store",Callback = function()
        spawn(function()
            pcall(function()
                GoToStore(Ass)
                Player.Character.HumanoidRootPart.CFrame = Workspace.Interiors:FindFirstChildWhichIsA('Model').Doors.MainDoor.WorkingParts.TouchToEnter.CFrame:ToWorldSpace(CFrame.new(0, 0, -6))
            end)
        end)
    end})
    local Dropdown = Tabs.Main:AddDropdown("s", {
        Title = "Stores",
        Values = Stores,
        Multi = false,
        Default = 1,
    })
 
    Dropdown:SetValue("")
 
    Dropdown:OnChanged(function(Value)
        Ass = Value
    end)
    Tabs.Main:AddButton({Title = "Go To Home",Description = "Goes to House",Callback = function()
        spawn(function()
            GoToHome()
            Player.Character.HumanoidRootPart.CFrame = Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA('Model'):GetModelCFrame():ToWorldSpace(CFrame.new(0, 0, -6)) 
        end)
    end})
    Tabs.Main:AddButton({Title = "Go To MainMap",Description = "Goes to MainMap",Callback = function()
        spawn(function()
            GoToMainMap()
            Player.Character.HumanoidRootPart.CFrame = Workspace.Interiors:FindFirstChildWhichIsA("Model"):GetModelCFrame():ToWorldSpace(CFrame.new(0, 0, -6))
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(-247.35408, 17.3820152, -1518.88879) 
        end)
    end})
 
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
