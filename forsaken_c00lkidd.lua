local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local flinging = false
local bambam

local noclipping = false
local flingDied
local Clip = false
local stamina = 110

local mainabilitycooldown = 0
local corruptnaturecooldown = 0
local walkspeedoveridecooldown = 0
local running = false
local stunned = false

local function UI()
	if true then
		local MainUI = Instance.new("ScreenGui")
		MainUI.Name = "MainUI"
		MainUI.ResetOnSpawn = false
		MainUI.DisplayOrder = 1
		MainUI.ClipToDeviceSafeArea = false
		MainUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		MainUI.Parent = player.PlayerGui

		local AbilityContainer = Instance.new("Frame")
		AbilityContainer.Name = "AbilityContainer"
		AbilityContainer.AnchorPoint = Vector2.new(0.50, 0.50)
		AbilityContainer.Size = UDim2.new(0.20, 125.00, 0.20, 125.00)
		AbilityContainer.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		AbilityContainer.Position = UDim2.new(1.00, -100.00, 1.00, -110.00)
		AbilityContainer.BorderSizePixel = 0
		AbilityContainer.ZIndex = 0
		AbilityContainer.BackgroundTransparency = 1
		AbilityContainer.BackgroundColor3 = Color3.new(0.00, 0.00, 0.00)
		AbilityContainer.Parent = MainUI

		local CorruptNature = Instance.new("ImageButton")
		CorruptNature.Name = "CorruptNature"
		CorruptNature.ImageColor3 = Color3.new(0.39, 0.39, 0.39)
		CorruptNature.BorderSizePixel = 0
		CorruptNature.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		CorruptNature.AnchorPoint = Vector2.new(0.50, 0.50)
		CorruptNature.Image = "http://www.roblox.com/asset/?id=87036098416335"
		CorruptNature.Size = UDim2.new(0.30, 0.00, 0.30, 0.00)
		CorruptNature.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		CorruptNature.BackgroundTransparency = 1
		CorruptNature.Position = UDim2.new(0.10, 0.00, 0.38, 0.00)
		CorruptNature.LayoutOrder = 2
		CorruptNature.Parent = AbilityContainer

		local AbilityName = Instance.new("TextLabel")
		AbilityName.Name = "AbilityName"
		AbilityName.TextWrapped = true
		AbilityName.TextStrokeTransparency = 0
		AbilityName.ZIndex = 3
		AbilityName.BorderSizePixel = 0
		AbilityName.TextScaled = true
		AbilityName.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		AbilityName.FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		AbilityName.AnchorPoint = Vector2.new(0.50, 1.00)
		AbilityName.TextSize = 14
		AbilityName.Size = UDim2.new(1.00, 10.00, 0.25, 0.00)
		AbilityName.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		AbilityName.Text = "Corrupt Nature"
		AbilityName.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		AbilityName.BackgroundTransparency = 1
		AbilityName.Position = UDim2.new(0.50, 0.00, 1.00, 0.00)
		AbilityName.Parent = CorruptNature

		local KeybindName = Instance.new("TextLabel")
		KeybindName.Name = "KeybindName"
		KeybindName.TextWrapped = true
		KeybindName.TextStrokeTransparency = 0
		KeybindName.ZIndex = 3
		KeybindName.BorderSizePixel = 0
		KeybindName.TextScaled = true
		KeybindName.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		KeybindName.FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		KeybindName.AnchorPoint = Vector2.new(0.50, 0.00)
		KeybindName.TextSize = 14
		KeybindName.Size = UDim2.new(1.00, 10.00, 0.25, 0.00)
		KeybindName.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		KeybindName.Text = ""
		KeybindName.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		KeybindName.BackgroundTransparency = 1
		KeybindName.Position = UDim2.new(0.50, 0.00, 0.00, 0.00)
		KeybindName.Visible = false
		KeybindName.Parent = CorruptNature

		local CooldownTime = Instance.new("TextLabel")
		CooldownTime.Name = "CooldownTime"
		CooldownTime.TextWrapped = true
		CooldownTime.ZIndex = 3
		CooldownTime.BorderSizePixel = 0
		CooldownTime.TextScaled = true
		CooldownTime.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		CooldownTime.FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		CooldownTime.AnchorPoint = Vector2.new(0.50, 0.50)
		CooldownTime.TextSize = 14
		CooldownTime.Size = UDim2.new(0.80, 0.00, 0.50, 0.00)
		CooldownTime.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		CooldownTime.Text = ""
		CooldownTime.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		CooldownTime.BackgroundTransparency = 1
		CooldownTime.Position = UDim2.new(0.50, 0.00, 0.50, 0.00)
		CooldownTime.Parent = CorruptNature

		local UIStroke = Instance.new("UIStroke")
		UIStroke.Thickness = 3
		UIStroke.Transparency = 0.5
		UIStroke.Parent = CooldownTime

		local Clipping = Instance.new("Frame")
		Clipping.Name = "Clipping"
		Clipping.ClipsDescendants = true
		Clipping.AnchorPoint = Vector2.new(0.00, 1.00)
		Clipping.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
		Clipping.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Clipping.Position = UDim2.new(0.00, 0.00, 1.00, 0.00)
		Clipping.BorderSizePixel = 0
		Clipping.BackgroundTransparency = 1
		Clipping.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Clipping.Parent = CorruptNature

		local Top = Instance.new("ImageLabel")
		Top.Name = "Top"
		Top.BorderSizePixel = 0
		Top.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Top.AnchorPoint = Vector2.new(0.00, 1.00)
		Top.Image = "http://www.roblox.com/asset/?id=87036098416335"
		Top.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
		Top.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Top.BackgroundTransparency = 1
		Top.Position = UDim2.new(0.00, 0.00, 1.00, 0.00)
		Top.Parent = Clipping

		local Charges = Instance.new("TextLabel")
		Charges.Name = "Charges"
		Charges.TextWrapped = true
		Charges.TextStrokeTransparency = 0
		Charges.ZIndex = 3
		Charges.BorderSizePixel = 0
		Charges.TextScaled = true
		Charges.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Charges.FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Charges.AnchorPoint = Vector2.new(0.50, 1.00)
		Charges.TextSize = 14
		Charges.Size = UDim2.new(1.00, 10.00, 0.25, 0.00)
		Charges.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Charges.Text = ""
		Charges.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		Charges.BackgroundTransparency = 1
		Charges.Position = UDim2.new(0.50, 0.00, 0.00, -4.00)
		Charges.Parent = CorruptNature

		local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
		UIAspectRatioConstraint.Parent = CorruptNature

		local Override = Instance.new("ImageButton")
		Override.Name = "Override"
		Override.ImageColor3 = Color3.new(0.39, 0.39, 0.39)
		Override.BorderSizePixel = 0
		Override.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Override.AnchorPoint = Vector2.new(0.50, 0.50)
		Override.Image = "http://www.roblox.com/asset/?id=124520277203507"
		Override.Size = UDim2.new(0.30, 0.00, 0.30, 0.00)
		Override.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Override.BackgroundTransparency = 1
		Override.Position = UDim2.new(0.28, 0.00, 0.16, 0.00)
		Override.LayoutOrder = 3
		Override.Parent = AbilityContainer

		local AbilityName_1 = Instance.new("TextLabel")
		AbilityName_1.Name = "AbilityName"
		AbilityName_1.TextWrapped = true
		AbilityName_1.TextStrokeTransparency = 0
		AbilityName_1.ZIndex = 3
		AbilityName_1.BorderSizePixel = 0
		AbilityName_1.TextScaled = true
		AbilityName_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		AbilityName_1.FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		AbilityName_1.AnchorPoint = Vector2.new(0.50, 1.00)
		AbilityName_1.TextSize = 14
		AbilityName_1.Size = UDim2.new(1.00, 10.00, 0.25, 0.00)
		AbilityName_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		AbilityName_1.Text = "Walkspeed Override"
		AbilityName_1.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		AbilityName_1.BackgroundTransparency = 1
		AbilityName_1.Position = UDim2.new(0.50, 0.00, 1.00, 0.00)
		AbilityName_1.Parent = Override

		local KeybindName_1 = Instance.new("TextLabel")
		KeybindName_1.Name = "KeybindName"
		KeybindName_1.TextWrapped = true
		KeybindName_1.TextStrokeTransparency = 0
		KeybindName_1.ZIndex = 3
		KeybindName_1.BorderSizePixel = 0
		KeybindName_1.TextScaled = true
		KeybindName_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		KeybindName_1.FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		KeybindName_1.AnchorPoint = Vector2.new(0.50, 0.00)
		KeybindName_1.TextSize = 14
		KeybindName_1.Size = UDim2.new(1.00, 10.00, 0.25, 0.00)
		KeybindName_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		KeybindName_1.Text = ""
		KeybindName_1.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		KeybindName_1.BackgroundTransparency = 1
		KeybindName_1.Position = UDim2.new(0.50, 0.00, 0.00, 0.00)
		KeybindName_1.Visible = false
		KeybindName_1.Parent = Override

		local CooldownTime_1 = Instance.new("TextLabel")
		CooldownTime_1.Name = "CooldownTime"
		CooldownTime_1.TextWrapped = true
		CooldownTime_1.ZIndex = 3
		CooldownTime_1.BorderSizePixel = 0
		CooldownTime_1.TextScaled = true
		CooldownTime_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		CooldownTime_1.FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		CooldownTime_1.AnchorPoint = Vector2.new(0.50, 0.50)
		CooldownTime_1.TextSize = 14
		CooldownTime_1.Size = UDim2.new(0.80, 0.00, 0.50, 0.00)
		CooldownTime_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		CooldownTime_1.Text = ""
		CooldownTime_1.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		CooldownTime_1.BackgroundTransparency = 1
		CooldownTime_1.Position = UDim2.new(0.50, 0.00, 0.50, 0.00)
		CooldownTime_1.Parent = Override

		local UIStroke_1 = Instance.new("UIStroke")
		UIStroke_1.Thickness = 3
		UIStroke_1.Transparency = 0.5
		UIStroke_1.Parent = CooldownTime_1

		local Clipping_1 = Instance.new("Frame")
		Clipping_1.Name = "Clipping"
		Clipping_1.ClipsDescendants = true
		Clipping_1.AnchorPoint = Vector2.new(0.00, 1.00)
		Clipping_1.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
		Clipping_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Clipping_1.Position = UDim2.new(0.00, 0.00, 1.00, 0.00)
		Clipping_1.BorderSizePixel = 0
		Clipping_1.BackgroundTransparency = 1
		Clipping_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Clipping_1.Parent = Override

		local Top_1 = Instance.new("ImageLabel")
		Top_1.Name = "Top"
		Top_1.BorderSizePixel = 0
		Top_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Top_1.AnchorPoint = Vector2.new(0.00, 1.00)
		Top_1.Image = "http://www.roblox.com/asset/?id=124520277203507"
		Top_1.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
		Top_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Top_1.BackgroundTransparency = 1
		Top_1.Position = UDim2.new(0.00, 0.00, 1.00, 0.00)
		Top_1.Parent = Clipping_1

		local Charges_1 = Instance.new("TextLabel")
		Charges_1.Name = "Charges"
		Charges_1.TextWrapped = true
		Charges_1.TextStrokeTransparency = 0
		Charges_1.ZIndex = 3
		Charges_1.BorderSizePixel = 0
		Charges_1.TextScaled = true
		Charges_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Charges_1.FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Charges_1.AnchorPoint = Vector2.new(0.50, 1.00)
		Charges_1.TextSize = 14
		Charges_1.Size = UDim2.new(1.00, 10.00, 0.25, 0.00)
		Charges_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Charges_1.Text = ""
		Charges_1.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		Charges_1.BackgroundTransparency = 1
		Charges_1.Position = UDim2.new(0.50, 0.00, 0.00, -4.00)
		Charges_1.Parent = Override

		local UIAspectRatioConstraint_1 = Instance.new("UIAspectRatioConstraint")
		UIAspectRatioConstraint_1.Parent = Override

		local Punch = Instance.new("ImageButton")
		Punch.Name = "Punch"
		Punch.ImageColor3 = Color3.new(0.39, 0.39, 0.39)
		Punch.BorderSizePixel = 0
		Punch.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Punch.AnchorPoint = Vector2.new(0.50, 0.50)
		Punch.Image = "rbxassetid://90873227244620"
		Punch.Size = UDim2.new(0.30, 0.00, 0.30, 0.00)
		Punch.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Punch.BackgroundTransparency = 1
		Punch.Position = UDim2.new(0.06, 0.00, 0.68, 0.00)
		Punch.LayoutOrder = 1
		Punch.Parent = AbilityContainer

		local AbilityName_1 = Instance.new("TextLabel")
		AbilityName_1.Name = "AbilityName"
		AbilityName_1.TextWrapped = true
		AbilityName_1.TextStrokeTransparency = 0
		AbilityName_1.ZIndex = 3
		AbilityName_1.BorderSizePixel = 0
		AbilityName_1.TextScaled = true
		AbilityName_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		AbilityName_1.FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		AbilityName_1.AnchorPoint = Vector2.new(0.50, 1.00)
		AbilityName_1.TextSize = 14
		AbilityName_1.Size = UDim2.new(1.00, 10.00, 0.25, 0.00)
		AbilityName_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		AbilityName_1.Text = "Punch"
		AbilityName_1.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		AbilityName_1.BackgroundTransparency = 1
		AbilityName_1.Position = UDim2.new(0.50, 0.00, 1.00, 0.00)
		AbilityName_1.Parent = Punch

		local KeybindName_1 = Instance.new("TextLabel")
		KeybindName_1.Name = "KeybindName"
		KeybindName_1.TextWrapped = true
		KeybindName_1.TextStrokeTransparency = 0
		KeybindName_1.ZIndex = 3
		KeybindName_1.BorderSizePixel = 0
		KeybindName_1.TextScaled = true
		KeybindName_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		KeybindName_1.FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		KeybindName_1.AnchorPoint = Vector2.new(0.50, 0.00)
		KeybindName_1.TextSize = 14
		KeybindName_1.Size = UDim2.new(1.00, 10.00, 0.25, 0.00)
		KeybindName_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		KeybindName_1.Text = "Mouse 1"
		KeybindName_1.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		KeybindName_1.BackgroundTransparency = 1
		KeybindName_1.Position = UDim2.new(0.50, 0.00, 0.00, 0.00)
		KeybindName_1.Visible = false
		KeybindName_1.Parent = Punch

		local CooldownTime_1 = Instance.new("TextLabel")
		CooldownTime_1.Name = "CooldownTime"
		CooldownTime_1.TextWrapped = true
		CooldownTime_1.ZIndex = 3
		CooldownTime_1.BorderSizePixel = 0
		CooldownTime_1.TextScaled = true
		CooldownTime_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		CooldownTime_1.FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		CooldownTime_1.AnchorPoint = Vector2.new(0.50, 0.50)
		CooldownTime_1.TextSize = 14
		CooldownTime_1.Size = UDim2.new(0.80, 0.00, 0.50, 0.00)
		CooldownTime_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		CooldownTime_1.Text = ""
		CooldownTime_1.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		CooldownTime_1.BackgroundTransparency = 1
		CooldownTime_1.Position = UDim2.new(0.50, 0.00, 0.50, 0.00)
		CooldownTime_1.Parent = Punch

		local UIStroke_1 = Instance.new("UIStroke")
		UIStroke_1.Thickness = 3
		UIStroke_1.Transparency = 0.5
		UIStroke_1.Parent = CooldownTime_1

		local Clipping_1 = Instance.new("Frame")
		Clipping_1.Name = "Clipping"
		Clipping_1.ClipsDescendants = true
		Clipping_1.AnchorPoint = Vector2.new(0.00, 1.00)
		Clipping_1.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
		Clipping_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Clipping_1.Position = UDim2.new(0.00, 0.00, 1.00, 0.00)
		Clipping_1.BorderSizePixel = 0
		Clipping_1.BackgroundTransparency = 1
		Clipping_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Clipping_1.Parent = Punch

		local Top_1 = Instance.new("ImageLabel")
		Top_1.Name = "Top"
		Top_1.BorderSizePixel = 0
		Top_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Top_1.AnchorPoint = Vector2.new(0.00, 1.00)
		Top_1.Image = "rbxassetid://90873227244620"
		Top_1.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
		Top_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Top_1.BackgroundTransparency = 1
		Top_1.Position = UDim2.new(0.00, 0.00, 1.00, 0.00)
		Top_1.Parent = Clipping_1

		local Charges_1 = Instance.new("TextLabel")
		Charges_1.Name = "Charges"
		Charges_1.TextWrapped = true
		Charges_1.TextStrokeTransparency = 0
		Charges_1.ZIndex = 3
		Charges_1.BorderSizePixel = 0
		Charges_1.TextScaled = true
		Charges_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Charges_1.FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Charges_1.AnchorPoint = Vector2.new(0.50, 1.00)
		Charges_1.TextSize = 14
		Charges_1.Size = UDim2.new(1.00, 10.00, 0.25, 0.00)
		Charges_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Charges_1.Text = ""
		Charges_1.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		Charges_1.BackgroundTransparency = 1
		Charges_1.Position = UDim2.new(0.50, 0.00, 0.00, -4.00)
		Charges_1.Parent = Punch

		local UIAspectRatioConstraint_1 = Instance.new("UIAspectRatioConstraint")
		UIAspectRatioConstraint_1.Parent = Punch

		local Delivery = Instance.new("ImageButton")
		Delivery.Name = "Delivery"
		Delivery.ImageColor3 = Color3.new(0.39, 0.39, 0.39)
		Delivery.BorderSizePixel = 0
		Delivery.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Delivery.AnchorPoint = Vector2.new(0.50, 0.50)
		Delivery.Image = "rbxassetid://129376879745624"
		Delivery.Size = UDim2.new(0.30, 0.00, 0.30, 0.00)
		Delivery.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Delivery.BackgroundTransparency = 1
		Delivery.Position = UDim2.new(0.61, 0.00, 0.15, 0.00)
		Delivery.LayoutOrder = 4
		Delivery.Parent = AbilityContainer

		local AbilityName_1 = Instance.new("TextLabel")
		AbilityName_1.Name = "AbilityName"
		AbilityName_1.TextWrapped = true
		AbilityName_1.TextStrokeTransparency = 0
		AbilityName_1.ZIndex = 3
		AbilityName_1.BorderSizePixel = 0
		AbilityName_1.TextScaled = true
		AbilityName_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		AbilityName_1.FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		AbilityName_1.AnchorPoint = Vector2.new(0.50, 1.00)
		AbilityName_1.TextSize = 14
		AbilityName_1.Size = UDim2.new(1.00, 10.00, 0.25, 0.00)
		AbilityName_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		AbilityName_1.Text = "Pizza Delivery"
		AbilityName_1.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		AbilityName_1.BackgroundTransparency = 1
		AbilityName_1.Position = UDim2.new(0.50, 0.00, 1.00, 0.00)
		AbilityName_1.Parent = Delivery

		local KeybindName_1 = Instance.new("TextLabel")
		KeybindName_1.Name = "KeybindName"
		KeybindName_1.TextWrapped = true
		KeybindName_1.TextStrokeTransparency = 0
		KeybindName_1.ZIndex = 3
		KeybindName_1.BorderSizePixel = 0
		KeybindName_1.TextScaled = true
		KeybindName_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		KeybindName_1.FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		KeybindName_1.AnchorPoint = Vector2.new(0.50, 0.00)
		KeybindName_1.TextSize = 14
		KeybindName_1.Size = UDim2.new(1.00, 10.00, 0.25, 0.00)
		KeybindName_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		KeybindName_1.Text = ""
		KeybindName_1.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		KeybindName_1.BackgroundTransparency = 1
		KeybindName_1.Position = UDim2.new(0.50, 0.00, 0.00, 0.00)
		KeybindName_1.Visible = false
		KeybindName_1.Parent = Delivery

		local CooldownTime_1 = Instance.new("TextLabel")
		CooldownTime_1.Name = "CooldownTime"
		CooldownTime_1.TextWrapped = true
		CooldownTime_1.ZIndex = 3
		CooldownTime_1.BorderSizePixel = 0
		CooldownTime_1.TextScaled = true
		CooldownTime_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		CooldownTime_1.FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		CooldownTime_1.AnchorPoint = Vector2.new(0.50, 0.50)
		CooldownTime_1.TextSize = 14
		CooldownTime_1.Size = UDim2.new(0.80, 0.00, 0.50, 0.00)
		CooldownTime_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		CooldownTime_1.Text = ""
		CooldownTime_1.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		CooldownTime_1.BackgroundTransparency = 1
		CooldownTime_1.Position = UDim2.new(0.50, 0.00, 0.50, 0.00)
		CooldownTime_1.Parent = Delivery

		local UIStroke_1 = Instance.new("UIStroke")
		UIStroke_1.Thickness = 3
		UIStroke_1.Transparency = 0.5
		UIStroke_1.Parent = CooldownTime_1

		local Clipping_1 = Instance.new("Frame")
		Clipping_1.Name = "Clipping"
		Clipping_1.ClipsDescendants = true
		Clipping_1.AnchorPoint = Vector2.new(0.00, 1.00)
		Clipping_1.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
		Clipping_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Clipping_1.Position = UDim2.new(0.00, 0.00, 1.00, 0.00)
		Clipping_1.BorderSizePixel = 0
		Clipping_1.BackgroundTransparency = 1
		Clipping_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Clipping_1.Parent = Delivery

		local Top_1 = Instance.new("ImageLabel")
		Top_1.Name = "Top"
		Top_1.BorderSizePixel = 0
		Top_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Top_1.AnchorPoint = Vector2.new(0.00, 1.00)
		Top_1.Image = "rbxassetid://129376879745624"
		Top_1.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
		Top_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Top_1.BackgroundTransparency = 1
		Top_1.Position = UDim2.new(0.00, 0.00, 1.00, 0.00)
		Top_1.Parent = Clipping_1

		local Charges_1 = Instance.new("TextLabel")
		Charges_1.Name = "Charges"
		Charges_1.TextWrapped = true
		Charges_1.TextStrokeTransparency = 0
		Charges_1.ZIndex = 3
		Charges_1.BorderSizePixel = 0
		Charges_1.TextScaled = true
		Charges_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Charges_1.FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Charges_1.AnchorPoint = Vector2.new(0.50, 1.00)
		Charges_1.TextSize = 14
		Charges_1.Size = UDim2.new(1.00, 10.00, 0.25, 0.00)
		Charges_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Charges_1.Text = ""
		Charges_1.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		Charges_1.BackgroundTransparency = 1
		Charges_1.Position = UDim2.new(0.50, 0.00, 0.00, -4.00)
		Charges_1.Parent = Delivery

		local UIAspectRatioConstraint_1 = Instance.new("UIAspectRatioConstraint")
		UIAspectRatioConstraint_1.Parent = Delivery

		local UIAspectRatioConstraint_1 = Instance.new("UIAspectRatioConstraint")
		UIAspectRatioConstraint_1.Parent = AbilityContainer

		local InsaneVignette = Instance.new("ImageLabel")
		InsaneVignette.Name = "InsaneVignette"
		InsaneVignette.ImageColor3 = Color3.new(0.00, 0.00, 0.00)
		InsaneVignette.ZIndex = 1000000
		InsaneVignette.BorderSizePixel = 0
		InsaneVignette.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		InsaneVignette.ImageTransparency = 1
		InsaneVignette.AnchorPoint = Vector2.new(0.50, 0.50)
		InsaneVignette.Image = "rbxassetid://116578305212587"
		InsaneVignette.Size = UDim2.new(1.20, 0.00, 1.20, 0.00)
		InsaneVignette.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		InsaneVignette.BackgroundTransparency = 1
		InsaneVignette.Position = UDim2.new(0.50, 0.00, 0.50, 0.00)
		InsaneVignette.Parent = MainUI

		local ShiftLockButton = Instance.new("ImageButton")
		ShiftLockButton.Name = "ShiftLockButton"
		ShiftLockButton.ZIndex = 0
		ShiftLockButton.BorderSizePixel = 0
		ShiftLockButton.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		ShiftLockButton.AnchorPoint = Vector2.new(1.00, 1.00)
		ShiftLockButton.Image = "rbxassetid://77581797168866"
		ShiftLockButton.Size = UDim2.new(0.00, 60.00, 0.00, 60.00)
		ShiftLockButton.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		ShiftLockButton.BackgroundTransparency = 1
		ShiftLockButton.Position = UDim2.new(1.00, -135.00, 1.00, -4.00)
		ShiftLockButton.Parent = MainUI

		local SprintingButton = Instance.new("ImageButton")
		SprintingButton.Name = "SprintingButton"
		SprintingButton.ZIndex = 0
		SprintingButton.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		SprintingButton.AnchorPoint = Vector2.new(0.50, 0.50)
		SprintingButton.Image = "rbxassetid://132640025048316"
		SprintingButton.Size = UDim2.new(0.00, 125.00, 0.00, 125.00)
		SprintingButton.BorderColor3 = Color3.new(0.49, 0.49, 0.49)
		SprintingButton.BackgroundTransparency = 1
		SprintingButton.Position = UDim2.new(1.00, -100.00, 1.00, -110.00)
		SprintingButton.Parent = MainUI

		local UIAspectRatioConstraint_1 = Instance.new("UIAspectRatioConstraint")
		UIAspectRatioConstraint_1.Parent = SprintingButton

		local UICorner = Instance.new("UICorner")
		UICorner.CornerRadius = UDim.new(0.50, 0.00)
		UICorner.Parent = SprintingButton

		local PlayerInfo = Instance.new("ImageLabel")
		PlayerInfo.Name = "PlayerInfo"
		PlayerInfo.ImageColor3 = Color3.new(0.00, 0.00, 0.00)
		PlayerInfo.BorderSizePixel = 0
		PlayerInfo.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		PlayerInfo.ImageTransparency = 0.33000001311302185
		PlayerInfo.AnchorPoint = Vector2.new(0.00, 1.00)
		PlayerInfo.Image = "rbxassetid://18831294483"
		PlayerInfo.Size = UDim2.new(0.25, 0.00, 0.12, 0.00)
		PlayerInfo.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		PlayerInfo.BackgroundTransparency = 1
		PlayerInfo.Position = UDim2.new(0.00, 20.00, 1.00, -20.00)
		PlayerInfo.Parent = MainUI

		local PlayerIcon = Instance.new("ImageLabel")
		PlayerIcon.Name = "PlayerIcon"
		PlayerIcon.BorderSizePixel = 0
		PlayerIcon.BackgroundColor3 = Color3.new(0.00, 0.00, 0.00)
		PlayerIcon.Image = "rbxassetid://15317582625"
		PlayerIcon.Size = UDim2.new(0.17, 0.00, 0.72, 0.00)
		PlayerIcon.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		PlayerIcon.BackgroundTransparency = 0.4000000059604645
		PlayerIcon.Position = UDim2.new(0.07, 0.00, 0.15, 0.00)
		PlayerIcon.Parent = PlayerInfo

		local UIAspectRatioConstraint_1 = Instance.new("UIAspectRatioConstraint")
		UIAspectRatioConstraint_1.Parent = PlayerIcon

		local Outline = Instance.new("ImageLabel")
		Outline.Name = "Outline"
		Outline.ZIndex = 2
		Outline.BorderSizePixel = 0
		Outline.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Outline.AnchorPoint = Vector2.new(0.50, 0.50)
		Outline.Image = "rbxassetid://18818132015"
		Outline.Size = UDim2.new(1.13, 0.00, 1.15, 0.00)
		Outline.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Outline.BackgroundTransparency = 1
		Outline.Position = UDim2.new(0.48, 0.00, 0.50, 0.00)
		Outline.Parent = PlayerIcon

		local UICorner_1 = Instance.new("UICorner")
		UICorner_1.CornerRadius = UDim.new(100.00, 100.00)
		UICorner_1.Parent = PlayerIcon

		local CurrentSurvivors = Instance.new("Frame")
		CurrentSurvivors.Name = "CurrentSurvivors"
		CurrentSurvivors.AnchorPoint = Vector2.new(0.50, 1.00)
		CurrentSurvivors.Size = UDim2.new(1.00, 0.00, 0.75, 0.00)
		CurrentSurvivors.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		CurrentSurvivors.Position = UDim2.new(0.50, 0.00, -0.08, 0.00)
		CurrentSurvivors.BorderSizePixel = 0
		CurrentSurvivors.BackgroundTransparency = 1
		CurrentSurvivors.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		CurrentSurvivors.Parent = PlayerInfo

		local UIGridLayout = Instance.new("UIGridLayout")
		UIGridLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
		UIGridLayout.FillDirectionMaxCells = 4
		UIGridLayout.CellPadding = UDim2.new(0.01, 0.00, 0.25, 0.00)
		UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIGridLayout.CellSize = UDim2.new(0.20, 0.00, 1.00, 0.00)
		UIGridLayout.StartCorner = Enum.StartCorner.BottomLeft
		UIGridLayout.Parent = CurrentSurvivors

		local Bars = Instance.new("Frame")
		Bars.Name = "Bars"
		Bars.AnchorPoint = Vector2.new(0.00, 0.50)
		Bars.Size = UDim2.new(0.68, 0.00, 0.85, 0.00)
		Bars.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Bars.Position = UDim2.new(0.25, 0.00, 0.50, 0.00)
		Bars.BorderSizePixel = 0
		Bars.BackgroundTransparency = 1
		Bars.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Bars.Parent = PlayerInfo

		local Health = Instance.new("Frame")
		Health.Name = "Health"
		Health.Size = UDim2.new(1.00, 0.00, 0.50, 0.00)
		Health.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Health.BorderSizePixel = 0
		Health.BackgroundTransparency = 1
		Health.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Health.Parent = Bars

		local HardDamage = Instance.new("ImageLabel")
		HardDamage.Name = "HardDamage"
		HardDamage.ImageColor3 = Color3.new(0.57, 0.00, 0.00)
		HardDamage.ZIndex = 2
		HardDamage.BorderSizePixel = 0
		HardDamage.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		HardDamage.ImageTransparency = 1
		HardDamage.AnchorPoint = Vector2.new(0.00, 0.50)
		HardDamage.Image = "rbxassetid://18818548751"
		HardDamage.Size = UDim2.new(0.55, 0.00, 0.10, 4.00)
		HardDamage.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		HardDamage.BackgroundTransparency = 1
		HardDamage.Position = UDim2.new(0.20, 0.00, 0.50, 0.00)
		HardDamage.Parent = Health

		local Clipping_1 = Instance.new("Frame")
		Clipping_1.Name = "Clipping"
		Clipping_1.ClipsDescendants = true
		Clipping_1.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
		Clipping_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Clipping_1.BorderSizePixel = 0
		Clipping_1.BackgroundTransparency = 1
		Clipping_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Clipping_1.Parent = HardDamage

		local Top_1 = Instance.new("ImageLabel")
		Top_1.Name = "Top"
		Top_1.ImageColor3 = Color3.new(0.12, 0.00, 0.00)
		Top_1.BorderSizePixel = 0
		Top_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Top_1.AnchorPoint = Vector2.new(1.00, 0.00)
		Top_1.Image = "rbxassetid://87577631610763"
		Top_1.Size = UDim2.new(0.00, 0.00, 1.00, 0.00)
		Top_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Top_1.BackgroundTransparency = 1
		Top_1.Position = UDim2.new(1.00, 0.00, 0.00, 0.00)
		Top_1.Parent = Clipping_1

		local Overheal = Instance.new("TextLabel")
		Overheal.Name = "Overheal"
		Overheal.TextWrapped = true
		Overheal.TextStrokeTransparency = 0
		Overheal.BorderSizePixel = 0
		Overheal.TextScaled = true
		Overheal.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Overheal.FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Overheal.AnchorPoint = Vector2.new(0.50, 0.50)
		Overheal.TextSize = 14
		Overheal.Size = UDim2.new(0.50, 0.00, 0.22, 14.00)
		Overheal.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Overheal.Text = ""
		Overheal.TextColor3 = Color3.new(0.61, 0.61, 1.00)
		Overheal.BackgroundTransparency = 1
		Overheal.Position = UDim2.new(0.90, 0.00, -0.05, -4.00)
		Overheal.Visible = false
		Overheal.Parent = Health

		local Amount = Instance.new("TextLabel")
		Amount.Name = "Amount"
		Amount.TextWrapped = true
		Amount.BorderSizePixel = 0
		Amount.TextScaled = true
		Amount.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Amount.FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Amount.AnchorPoint = Vector2.new(1.00, 0.50)
		Amount.TextSize = 14
		Amount.Size = UDim2.new(0.22, 0.00, 0.30, 14.00)
		Amount.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Amount.Text = "N/A"
		Amount.TextColor3 = Color3.new(1.00, 0.44, 0.44)
		Amount.BackgroundTransparency = 1
		Amount.Position = UDim2.new(1.00, 0.00, 0.50, 0.00)
		Amount.Parent = Health

		local Bar = Instance.new("ImageLabel")
		Bar.Name = "Bar"
		Bar.ImageColor3 = Color3.new(0.57, 0.25, 0.25)
		Bar.BorderSizePixel = 0
		Bar.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Bar.AnchorPoint = Vector2.new(0.00, 0.50)
		Bar.Image = "rbxassetid://18818548751"
		Bar.Size = UDim2.new(0.55, 0.00, 0.10, 4.00)
		Bar.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Bar.BackgroundTransparency = 1
		Bar.Position = UDim2.new(0.20, 0.00, 0.50, 0.00)
		Bar.Parent = Health

		local Clipping_1 = Instance.new("Frame")
		Clipping_1.Name = "Clipping"
		Clipping_1.ClipsDescendants = true
		Clipping_1.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
		Clipping_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Clipping_1.BorderSizePixel = 0
		Clipping_1.BackgroundTransparency = 1
		Clipping_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Clipping_1.Parent = Bar

		local Top_1 = Instance.new("ImageLabel")
		Top_1.Name = "Top"
		Top_1.ImageColor3 = Color3.new(1.00, 0.44, 0.44)
		Top_1.BorderSizePixel = 0
		Top_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Top_1.Image = "rbxassetid://18818548751"
		Top_1.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
		Top_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Top_1.BackgroundTransparency = 1
		Top_1.Parent = Clipping_1

		local Icon = Instance.new("ImageLabel")
		Icon.Name = "Icon"
		Icon.ImageColor3 = Color3.new(1.00, 0.44, 0.44)
		Icon.BorderSizePixel = 0
		Icon.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Icon.AnchorPoint = Vector2.new(0.00, 0.50)
		Icon.Image = "rbxassetid://16181404460"
		Icon.Size = UDim2.new(0.20, 0.00, 1.00, 0.00)
		Icon.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Icon.BackgroundTransparency = 1
		Icon.Position = UDim2.new(0.03, 0.00, 0.55, 0.00)
		Icon.Parent = Health

		local UIAspectRatioConstraint_1 = Instance.new("UIAspectRatioConstraint")
		UIAspectRatioConstraint_1.Parent = Icon

		local Stamina = Instance.new("Frame")
		Stamina.Name = "Stamina"
		Stamina.AnchorPoint = Vector2.new(0.00, 1.00)
		Stamina.Size = UDim2.new(1.00, 0.00, 0.50, 0.00)
		Stamina.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Stamina.Position = UDim2.new(0.00, 0.00, 1.00, 0.00)
		Stamina.BorderSizePixel = 0
		Stamina.BackgroundTransparency = 1
		Stamina.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Stamina.Parent = Bars

		local Amount_1 = Instance.new("TextLabel")
		Amount_1.Name = "Amount"
		Amount_1.TextWrapped = true
		Amount_1.BorderSizePixel = 0
		Amount_1.TextScaled = true
		Amount_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Amount_1.FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Amount_1.AnchorPoint = Vector2.new(1.00, 0.50)
		Amount_1.TextSize = 14
		Amount_1.Size = UDim2.new(0.22, 0.00, 0.30, 14.00)
		Amount_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Amount_1.Text = "N/A"
		Amount_1.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		Amount_1.BackgroundTransparency = 1
		Amount_1.Position = UDim2.new(1.00, 0.00, 0.50, 0.00)
		Amount_1.Parent = Stamina

		local Bar_1 = Instance.new("ImageLabel")
		Bar_1.Name = "Bar"
		Bar_1.ImageColor3 = Color3.new(0.57, 0.57, 0.57)
		Bar_1.BorderSizePixel = 0
		Bar_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Bar_1.AnchorPoint = Vector2.new(0.00, 0.50)
		Bar_1.Image = "rbxassetid://18818548751"
		Bar_1.Size = UDim2.new(0.55, 0.00, 0.10, 4.00)
		Bar_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Bar_1.BackgroundTransparency = 1
		Bar_1.Position = UDim2.new(0.20, 0.00, 0.50, 0.00)
		Bar_1.Parent = Stamina

		local Clipping_1 = Instance.new("Frame")
		Clipping_1.Name = "Clipping"
		Clipping_1.ClipsDescendants = true
		Clipping_1.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
		Clipping_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Clipping_1.BorderSizePixel = 0
		Clipping_1.BackgroundTransparency = 1
		Clipping_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Clipping_1.Parent = Bar_1

		local Top_1 = Instance.new("ImageLabel")
		Top_1.Name = "Top"
		Top_1.BorderSizePixel = 0
		Top_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Top_1.Image = "rbxassetid://18818548751"
		Top_1.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
		Top_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Top_1.BackgroundTransparency = 1
		Top_1.Parent = Clipping_1

		local Icon_1 = Instance.new("ImageLabel")
		Icon_1.Name = "Icon"
		Icon_1.BorderSizePixel = 0
		Icon_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Icon_1.AnchorPoint = Vector2.new(0.00, 0.50)
		Icon_1.Image = "rbxassetid://12443244342"
		Icon_1.Size = UDim2.new(0.20, 0.00, 1.25, 0.00)
		Icon_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Icon_1.BackgroundTransparency = 1
		Icon_1.Position = UDim2.new(0.00, 0.00, 0.50, 0.00)
		Icon_1.Parent = Stamina

		local UIAspectRatioConstraint_1 = Instance.new("UIAspectRatioConstraint")
		UIAspectRatioConstraint_1.Parent = Icon_1

		local UIAspectRatioConstraint_1 = Instance.new("UIAspectRatioConstraint")
		UIAspectRatioConstraint_1.AspectRatio = 4.5
		UIAspectRatioConstraint_1.DominantAxis = Enum.DominantAxis.Height
		UIAspectRatioConstraint_1.AspectType = Enum.AspectType.ScaleWithParentSize
		UIAspectRatioConstraint_1.Parent = PlayerInfo

		local UISizeConstraint = Instance.new("UISizeConstraint")
		UISizeConstraint.MinSize = Vector2.new(200.00, 1.00)
		UISizeConstraint.Parent = PlayerInfo

		task.spawn(function()
			while task.wait(0.01) do
				if player.Character and player.Character:FindFirstChild("Humanoid") then
					local humanoid = player.Character:FindFirstChild("Humanoid")
					Amount.Text = humanoid.Health .."/".. humanoid.MaxHealth
					Amount_1.Text = math.clamp(math.round(stamina), 0, 110) .."/110"
					Bar.Clipping.Size = UDim2.fromScale(humanoid.Health / humanoid.MaxHealth, 1)
					Bar_1.Clipping.Size = UDim2.fromScale(math.clamp(math.round(stamina), 0, 110) / 110, 1)

					Punch.CooldownTime.Text = mainabilitycooldown
					if mainabilitycooldown == 0 then
						Punch.CooldownTime.Text = ""
					else
						Punch.CooldownTime.Text = math.round(mainabilitycooldown * 10) / 10
					end
					if corruptnaturecooldown == 0 then
						CorruptNature.CooldownTime.Text = ""
					else
						CorruptNature.CooldownTime.Text = math.round(corruptnaturecooldown * 10) / 10
					end
					if walkspeedoveridecooldown == 0 then
						Override.CooldownTime.Text = ""
					else
						Override.CooldownTime.Text = math.round(walkspeedoveridecooldown * 10) / 10
					end
				end
			end
		end)
	end
end


local speaker = player

local function startNoclip()
	Clip = false
	wait(0.1)
	local function NoclipLoop()
		if Clip == false and speaker.Character ~= nil then
			for _, child in pairs(speaker.Character:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
					child.CanCollide = false
				end
			end
		end
	end
	noclipping = RunService.Stepped:Connect(NoclipLoop)
end

local function stopNoclip()
	if noclipping then
		noclipping:Disconnect()
	end
	Clip = true
end

local function setPhysicalProperties()
	for _, part in pairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5)
		end
	end
end

local function resetPhysicalProperties()
	for _, part in pairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
		end
	end
end

local function stopFling()
	stopNoclip()
	if flingDied then
		flingDied:Disconnect()
	end
	flinging = false
	wait(.1)
	local speakerChar = speaker.Character
	if not speakerChar or not speakerChar:FindFirstChild("HumanoidRootPart") then return end
	for i,v in pairs(speakerChar:FindFirstChild("HumanoidRootPart"):GetChildren()) do
		if v.ClassName == 'BodyAngularVelocity' then
			v:Destroy()
		end
	end
	for _, child in pairs(speakerChar:GetDescendants()) do
		if child.ClassName == "Part" or child.ClassName == "MeshPart" then
			child.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
		end
	end
	stopNoclip()
end

local function startFling()
	flinging = false
	for _, child in pairs(speaker.Character:GetDescendants()) do
		if child:IsA("BasePart") then
			child.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5)
		end
	end
	startNoclip()
	wait(.1)
	bambam = Instance.new("BodyAngularVelocity")
	bambam.Name = math.random(-9993487214879,99923568273645)
	bambam.Parent = speaker.Character:FindFirstChild("HumanoidRootPart")
	bambam.AngularVelocity = Vector3.new(0,99999,0)
	bambam.MaxTorque = Vector3.new(0,math.huge,0)
	bambam.P = math.huge
	local Char = speaker.Character:GetChildren()
	for i, v in next, Char do
		if v:IsA("BasePart") then
			v.CanCollide = false
			v.Massless = true
			v.Velocity = Vector3.new(0, 0, 0)
		end
	end
	flinging = true
	local function flingDiedF()
		stopFling()
	end
	flingDied = speaker.Character:FindFirstChildOfClass('Humanoid').Died:Connect(flingDiedF)
	repeat
		bambam.AngularVelocity = Vector3.new(0,99999,0)
		wait(.2)
		bambam.AngularVelocity = Vector3.new(0,0,0)
		wait(.1)
	until flinging == false
end

local function moveForwardsAndFling()
	local hrp = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChild("Humanoid")
	if not hrp or not humanoid then return end

	local startPos = hrp.Position
	local targetPos = hrp.Position + (hrp.CFrame.LookVector * 154)
	local direction = (targetPos - startPos).Unit
	local stop = false

	task.spawn(function()
		startFling()
	end)
	task.wait(0.1)

	local touchedConn
	touchedConn = hrp.Touched:Connect(function(hit)
		stop = true
		if touchedConn then touchedConn:Disconnect() end
	end)

	-- Move loop
	while not stop do
		print("yuhh..??")
		local distanceTravelled = (hrp.Position - startPos).Magnitude
		if distanceTravelled >= 154 then
			if touchedConn then touchedConn:Disconnect() end
			break
		end
		-- Apply velocity
		hrp.CFrame = hrp.CFrame + direction
		RunService.Heartbeat:Wait()
	end
end

local function moveTowardsMouseAndFling(maxDistance)
	local lastgravity = workspace.Gravity
	workspace.Gravity = 0
	local mouse = player:GetMouse()
	local hrp = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChild("Humanoid")
	if not hrp or not humanoid then return end

	local startPos = hrp.Position
	local targetPos = mouse.Hit.Position
	local direction = (targetPos - startPos).Unit
	local stop = false

	startNoclip()

	local touchedConn
	touchedConn = hrp.Touched:Connect(function(hit)
		stop = true
		hrp.CFrame = hrp.CFrame
		task.spawn(function()
			startFling()
		end)
		task.wait(0.5)
		stopFling()
		if touchedConn then touchedConn:Disconnect() end

		hrp.CFrame = CFrame.new(startPos)
		workspace.Gravity = lastgravity
		stopNoclip()
	end)

	-- Move loop
	while not stop do
		local distanceTravelled = (hrp.Position - startPos).Magnitude
		if distanceTravelled >= maxDistance then
			hrp.CFrame = CFrame.new(startPos)
			if touchedConn then touchedConn:Disconnect() end
			workspace.Gravity = lastgravity
			stopNoclip()
			break
		end
		-- Apply velocity
		hrp.CFrame = hrp.CFrame + direction
		RunService.Heartbeat:Wait()
	end
end

UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end

	if input.KeyCode == Enum.KeyCode.E then
		if corruptnaturecooldown == 0 then
			corruptnaturecooldown = 12
			task.spawn(function()
				print("corrupt nature")
				moveTowardsMouseAndFling(100) -- move up to 100 studs
				task.wait(1)
				print("stoppp")
				stopNoclip()
			end)
		end
	end

	if input.KeyCode == Enum.KeyCode.Q then
		if walkspeedoveridecooldown == 0 then
			walkspeedoveridecooldown = 20
			task.spawn(function()
				stunned = true
				task.wait(0.54)
				moveForwardsAndFling()
				task.wait(1)
				stopFling()
				stopNoclip()
				task.wait(1)
				stunned = false
			end)
		end
	end

	if input.KeyCode == Enum.KeyCode.LeftShift then
		if character:FindFirstChild("Humanoid") then
			if stamina > 0 then
				running = true
			end
		end
	end

	if input.UserInputType == Enum.UserInputType.MouseButton1 and mainabilitycooldown <= 0 then
		mainabilitycooldown = 2
		task.spawn(function()
			startFling()
		end)
		task.wait(0.4)
		stopFling()
		local lastjumppower = humanoid.JumpPower
		humanoid.JumpPower = 1
		humanoid.Jump = true
		task.wait(0.1)
		humanoid.JumpPower = lastjumppower
	end
end)



UserInputService.InputEnded:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.LeftShift then
		running = false
	end
end)

RunService.Heartbeat:Connect(function(delta)
	if humanoid then
		humanoid.MaxHealth = 800
	end
	if mainabilitycooldown - delta > 0 then
		mainabilitycooldown -= delta
	else
		mainabilitycooldown = 0
	end
	if corruptnaturecooldown - delta > 0 then
		corruptnaturecooldown -= delta
	else
		corruptnaturecooldown = 0
	end
	if walkspeedoveridecooldown - delta > 0 then
		walkspeedoveridecooldown -= delta
	else
		walkspeedoveridecooldown = 0
	end
	if not stunned then
	if running then
		character.Humanoid.WalkSpeed = 28
		stamina -= (delta * 15)
		if stamina <= 0 then
			running = false
			stamina = -21
		end
	else
		if stamina <= 110 then
			stamina += delta * 21
		else
			stamina = 110
		end
		character.Humanoid.WalkSpeed = 7.5
		end
	else
		character.Humanoid.WalkSpeed = 0
	end
end)

humanoid.Died:Connect(stopFling)

player.CharacterAdded:Connect(function(char)
	character = char
	hrp = character:WaitForChild("HumanoidRootPart")
	humanoid = character:WaitForChild("Humanoid")
	humanoid.MaxHealth = 800
	humanoid.Health = 800
	flinging = false
	Clip = false
	if noclipping then
		noclipping:Disconnect()
		noclipping = nil
	end
end)
humanoid.MaxHealth = 800
humanoid.Health = 800
UI()