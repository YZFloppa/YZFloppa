warn('Wait Until Fully Loaded')
local players = game:GetService("Players")
local plr = players.LocalPlayer
local cd = false
getgenv().Settings = {
	Autoparry = {
		Toggle = true, Range = 25, Delay = 0,Fov = 140, Facing = false, Dodgerange = 3, Aimhelper = false, enemy = nil
	}
}

local m1s = {
--YZFloppa
	["rbxassetid://10469493270"] = { [1] = 0, [2] = 0.30 },
	["rbxassetid://10469630950"] = { [1] = 0, [2] = 0.30 },
	["rbxassetid://10469639222"] = { [1] = 0, [2] = 0.30 },
	["rbxassetid://10469643643"] = { [1] = 0, [2] = 0.30 },
--YZFloppa's minion
	["rbxassetid://13532562418"] = { [1] = 0, [2] = 0.30 },
	["rbxassetid://13532600125"] = { [1] = 0, [2] = 0.30 },
	["rbxassetid://13532604085"] = { [1] = 0, [2] = 0.30 },
	["rbxassetid://13294471966"] = { [1] = 0, [2] = 0.30 },
--mcdonald's frying machine
	["rbxassetid://13491635433"] = { [1] = 0, [2] = 0.30 },
	["rbxassetid://13296577783"] = { [1] = 0, [2] = 0.30 },
	["rbxassetid://13295919399"] = { [1] = 0, [2] = 0.30 },
	["rbxassetid://13295936866"] = { [1] = 0, [2] = 0.30 },
--mcdonald's fastest work
	["rbxassetid://13370310513"] = { [1] = 0, [2] = 0.30 },
	["rbxassetid://13390230973"] = { [1] = 0, [2] = 0.30 },
	["rbxassetid://13378751717"] = { [1] = 0, [2] = 0.30 },
	["rbxassetid://13378708199"] = { [1] = 0, [2] = 0.30 },
--nigga got brain issue
	['rbxassetid://14004222985'] = { [1] = 0, [2] = 0.40 },
	['rbxassetid://13997092940'] = { [1] = 0, [2] = 0.40 },
	['rbxassetid://14001963401'] = { [1] = 0, [2] = 0.40 },
	['rbxassetid://14136436157'] = { [1] = 0, [2] = 0.45 },
--bro think he's good at cutting shit
	['rbxassetid://15259161390'] = { [1] = 0, [2] = 0.30 }, 
	['rbxassetid://15240216931'] = { [1] = 0, [2] = 0.30 },
	['rbxassetid://15240176873'] = { [1] = 0, [2] = 0.30 },
	['rbxassetid://15162694192'] = { [1] = 0, [2] = 0.30 },
--omg a child with telekinesis
	['rbxassetid://16515503507'] = { [1] = 0, [2] = 0.30 },
	['rbxassetid://16515520431'] = { [1] = 0, [2] = 0.30 },
	['rbxassetid://16515448089'] = { [1] = 0, [2] = 0.30 },
	['rbxassetid://16552234590'] = { [1] = 0, [2] = 0.30 },
	abilities = {}
}
local dashes = {
	["rbxassetid://10479335397"] = { [1] = 0, [2] = 0.50 },
	["rbxassetid://13380255751"] = { [1] = 0, [2] = 0.50 },
	['rbxassetid://13380255751'] = { [1] = 0, [2] = 0.50 },
	['rbxassetid://13380255751'] = { [1] = 0, [2] = 0.50 },
	
}
local barrages = {
	["rbxassetid://10466974800"] = { [1] = 0.20, [2] = 1.80 },
	["rbxassetid://12534735382"] = { [1] = 0.20, [2] = 1.80 }
}
local abilities = {
	["rbxassetid://10468665991"] = { [1] = 0.15, [2] = 0.60 },
	["rbxassetid://13376869471"] = { [1] = 0.05, [2] = 1 },
	["rbxassetid://13376962659"] = { [1] = 0, [2] = 2 },
	["rbxassetid://12296882427"] = { [1] = 0.05, [2] = 1 },--sonic
	["rbxassetid://13309500827"] = { [1] = 0.05, [2] = 1 },--sonic
	["rbxassetid://13365849295"] = { [1] = 0, [2] = 1 },--sonic
	["rbxassetid://13377153603"] = { [1] = 0, [2] = 1 },--sonik
	["rbxassetid://12509505723"] = { [1] = 0.09, [2] = 2 }, -- dash for gemoss
}

local closestplr, m1, plrDirection, unit, value,dash
local plr = game.Players.LocalPlayer

function lookatlol(player)
	if not player or not player:IsA("Player") or not player.Character then
		return false
	end
	local plrChar = player.Character
	if not plrChar or not plrChar:FindFirstChild("Head") or plrChar.Humanoid.Health == 0 then
		return false
	end
	local lplrChar = plr.Character
	if not lplrChar or not lplrChar:FindFirstChild("Head") or lplrChar.Humanoid.Health == 0 then
		return false
	end
	local charDirection = (plrChar.Head.Position - lplrChar.Head.Position).unit
	local charLook = lplrChar.Head.CFrame.LookVector
	local dp = charDirection:Dot(charLook)
	return dp > 0.5
end
function closest()
	local closestplr = {}
	for _, v in next, players:GetPlayers() do
		if v:IsA("Player") and v ~= plr and v.Character and plr.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
			local distance = (v.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
			if distance < getgenv().Settings.Autoparry.Range then
				local isLooking = lookatlol(v)
				if isLooking then
					table.insert(closestplr, v)
				end
			end
		end
	end
	return closestplr
end

function attackchecker()
	for i,Anim in next, plr.Character.Humanoid.Animator:GetPlayingAnimationTracks() do
		z = m1s[Anim.Animation.AnimationId]
		q = dashes[Anim.Animation.AnimationId]
		j = abilities[Anim.Animation.AnimationId]
		k = barrages[Anim.Animation.AnimationId]
		if z or q or j or k then return true
		else return false
		end
	end
end

function isfacing(object)
	if getgenv().Settings.Autoparry.Toggle then
		if getgenv().Settings.Autoparry.Facing then
			plrDirection = plr.Character.Head.CFrame.LookVector
			unit = (object.Head.CFrame.p - plr.Character.Head.CFrame.p).Unit
			value = math.pow((plrDirection - unit).Magnitude / 2, 2)
			if value >= getgenv().Settings.Autoparry.Fov / 360 then
				return false
			else
				return true
			end
		else
			return true
		end
	end
end

function allowed(enemy)
	if not plr.Character:FindFirstChild("M1ing") and not attackchecker() and isfacing(enemy) then
		return true
	end
end

local durations = {
	["m1"] = 0.3,
	["dash"] = 0.3,
	["barrage"] = 0.9,
	["ability"] = 0.6,
}

function def(action)
	if cd then
		return
	end
	task.wait(getgenv().Settings.Autoparry.Delay)
	print("parry attempt".."|"..action)
	cd = true
	plr.Character.Communicate:FireServer({["Goal"] = "KeyPress", ["Key"] = Enum.KeyCode.F })
	task.wait(durations[action])
	plr.Character.Communicate:FireServer({["Goal"] = "KeyRelease",["Key"] = Enum.KeyCode.F })
	cd = false
end

function barragechecker(enemy)
	if enemy:FindFirstChild("BarrageBind") then
		return true
	else
		return false
	end
end

function lookat(enemy)
	if getgenv().Settings.Autoparry.Aimhelper then
		plr.Character.HumanoidRootPart.CFrame = CFrame.lookAt(plr.Character.HumanoidRootPart.Position, enemy.HumanoidRootPart.Position)
	end
end

function parry()
	for i, c in closest() do
		if c and plr.Character:WaitForChild("HumanoidRootPart", 2) and c.Character and c.Character:FindFirstChild("Humanoid") and c.Character.Humanoid:FindFirstChild("Animator") then
			for i, v in next, c.Character.Humanoid.Animator:GetPlayingAnimationTracks() do
				m1 = m1s[v.Animation.AnimationId]
				dash = dashes[v.Animation.AnimationId]
				ability = abilities[v.Animation.AnimationId]
				barrage = barrages[v.Animation.AnimationId]
				if allowed(c.Character) and m1 and v.TimePosition >= m1[1] and v.TimePosition <= m1[2] then
					task.spawn(function()
						def("m1")
						getgenv().Settings.Autoparry.enemy = c.Character
						lookat(c.Character)
					end)
				elseif allowed(c.Character) and dash and v.TimePosition > dash[1] and v.TimePosition < dash[2] then
					task.spawn(function()
						def("dash")
						getgenv().Settings.Autoparry.enemy = c.Character
						lookat(c.Character)
					end)
				elseif allowed(c.Character) and barrage and v.TimePosition > barrage[1] and v.TimePosition < barrage[2] then
					task.spawn(function()
						def("barrage")
						getgenv().Settings.Autoparry.enemy = c.Character
						lookat(c.Character)
					end)
				elseif allowed(c.Character) and ability and v.TimePosition > ability[1] and v.TimePosition < ability[2] then
					task.spawn(function()
						def("ability")
						getgenv().Settings.Autoparry.enemy = c.Character
						lookat(c.Character)
					end)
				end
			end
		end
	end
end

task.spawn(function()
	game:GetService("RunService").RenderStepped:Connect(function()
		if getgenv().Settings.Autoparry.Toggle then
			parry()
		end
	end)
end)

warn("Executed")
