task.wait(2)

local PathfindingService = game:GetService("PathfindingService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local NPC = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
local NPCHumanoid = NPC:FindFirstChild("Humanoid")
local NPCHumanoidRoot = NPC:FindFirstChild("HumanoidRootPart")

print(NPCHumanoid, NPCHumanoidRoot)

local mainAbilityCooldown = 0
local ragingpaceCooldown = 0

local stamina = 110
local running = false
local ragingpace = false

local lastdist = math.huge

local function getClosestPlayer()
	local magnitudes = {}
	local target = nil
	local distance = nil

	for _,player in pairs(Players:GetPlayers()) do
		if player ~= game.Players.LocalPlayer then
			local dist = player:DistanceFromCharacter(NPCHumanoidRoot.Position)
			table.insert(magnitudes, {dist,player})
		end
	end

	table.sort(magnitudes, function(a,b)
		return a[1] < b[1]
	end)

	if #magnitudes > 0 then
		target = magnitudes[1][2]
		distance = magnitudes[1][1]
	end

	return target
end

RunService.Heartbeat:Connect(function(delta)
	print(stamina)
	if mainAbilityCooldown > 0 then
		mainAbilityCooldown -= delta
	else
		mainAbilityCooldown = 0
	end
	if ragingpaceCooldown > 0 then
		ragingpaceCooldown -= delta
	else
		ragingpaceCooldown = 0
	end
	local target = getClosestPlayer()
	local dist = target:DistanceFromCharacter(NPCHumanoidRoot.Position)
	if (running and dist < 50) or ragingpace then
		stamina -= (delta * 8)
		if stamina < 0 then
			stamina = 0
		end
	else
		stamina += (delta * 21)
	end
	if running then
		if ragingpace then
			NPCHumanoid.WalkSpeed = 19.5
		else
			NPCHumanoid.WalkSpeed = 28
		end
	else
		NPCHumanoid.WalkSpeed = 9
	end
	if stamina > 110 then
		stamina = 110
	elseif stamina == 0 then
		stamina = -42
		running = false
	end
end)

local path = nil
local waypoints = nil
local RANGE = 50

local function CreatePlayerPath(target)
	local playerPath = PathfindingService:CreatePath({
		AgentRadius = 5,
	})
	local TargetHRP = target.Character:WaitForChild("HumanoidRootPart")

	local success, errorMessage = pcall(function()
		playerPath:ComputeAsync(NPCHumanoidRoot.Position, TargetHRP.Position)
	end)

	if not success or playerPath.Status ~= Enum.PathStatus.Success then
		return nil
	end

	return playerPath
end

local predictedstamina = 110
local timebeforenext = 1
local waiting = false

RunService.Heartbeat:Connect(function(dt)
	local target = getClosestPlayer()
	if not target then return end
	local targetPos = target.Character.PrimaryPart.Position
	local dist = (NPCHumanoidRoot.Position - targetPos).Magnitude
	task.wait(0.1)
	local newtargetPos = target.Character.PrimaryPart.Position
	local targetrunning = (targetPos - newtargetPos).Magnitude / 0.1 > 20

	if waiting then
		running = false
		if stamina > 109 then
			waiting = false
		end
	else
		if targetrunning then
			predictedstamina -= dt * 15
			if predictedstamina < 0 then
				if targetrunning then
					predictedstamina += 10
				else
					predictedstamina = 0
				end
			end
		else
			predictedstamina += dt * 20
			if predictedstamina > 100 then
				predictedstamina = 100
			end
		end
		if dist > 50 then
			running = true
		else
			if targetrunning and not running then
				running = predictedstamina < (stamina / 1.2)
			elseif not targetrunning and running then
				if dist < 15 and math.random(1,20) > 1 then
					running = true
				else
					running = false
				end
			elseif not targetrunning and not running then
				if math.random(1,30) == 1 then
					running = true
				end
			elseif targetrunning and running then
				if stamina < 40 then
					waiting = true
					running = false
				else
					running = true
				end
			end
			if math.random(1,20) == 1 then
				local idk = 0
				repeat
					running = true
					idk += 1
					task.wait()
				until idk > 70
				running = false
			end

			if dist < 5 then
				local mainui = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("MainUI")
				if mainui then
					local abilitycontainer = mainui:FindFirstChild("AbilityContainer")
					if abilitycontainer then
						if abilitycontainer:FindFirstChild("Slash") then
							abilitycontainer.Slash:Activate()
						else
							print("no slash")
						end
					else
						print("no ability container")
					end
				else
					print("no mainui")
				end
			end
		end
	end
end)

while true do
	local target = getClosestPlayer()

	if target then
		repeat task.wait() until target.Character or target.CharacterAdded:Wait()
		path = CreatePlayerPath(target)

		if path then
			waypoints = path:GetWaypoints()

			workspace.idk:ClearAllChildren()

			local part = Instance.new("Part")
			part.Anchored = true
			part.Size = Vector3.new(1,1,1)
			part.Position = waypoints[2].Position
			part.Parent = workspace.idk

			NPCHumanoid:MoveTo(waypoints[2].Position)
			if stamina < 10 then
				task.wait(1)
				ragingpace = true
			end
		end
	else
		print("gulp.")
		path = nil
		waypoints = nil
	end

	RunService.Heartbeat:Wait()
end
