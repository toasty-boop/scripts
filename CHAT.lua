-- for the people who don't want to give their face to a random ahh AI!!

local plr = game.Players.LocalPlayer
if not plr then return end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = plr:WaitForChild("PlayerGui")

local TextBox = Instance.new("TextBox")
TextBox.BorderSizePixel = 0
TextBox.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
TextBox.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextBox.AnchorPoint = Vector2.new(0.50, 0.50)
TextBox.TextSize = 14
TextBox.Size = UDim2.new(0.28, 0.00, 0.12, 0.00)
TextBox.TextColor3 = Color3.new(0.00, 0.00, 0.00)
TextBox.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
TextBox.Text = ""
TextBox.Position = UDim2.new(0.50, 0.00, 0.76, 0.00)
TextBox.Parent = ScreenGui

TextBox.FocusLost:Connect(function(enter)
	if enter then
		game.TextChatService.TextChannels.RBXGeneral:SendAsync(TextBox.Text)
		TextBox.Text = ""
	end
end)
