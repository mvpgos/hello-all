if GetObjectName(GetMyHero()) ~= "Gragas" then return end

require('DamageLib')

local GragasMenu = Menu("Gragas", "Gragas")
GragasMenu:SubMenu("Combo", "Combo")
GragasMenu.Combo:Boolean("Q", "Use Q", true)
GragasMenu.Combo:Boolean("W", "Use W", true)
GragasMenu.Combo:Boolean("E", "Use E", true)
GragasMenu.Combo:Boolean("R", "Use R", true)

GragasMenu:Menu("Harass", "Harass")
GragasMenu.Harass:Boolean("Q", "Use Q", true)
GragasMenu.Harass:Boolean("E", "Use E", true)
GragasMenu.Harass:Slider("Mana", "if Mana % >", 30, 0, 80, 1)


GragasMenu:Menu("Killsteal", "Killsteal")
GragasMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)




		
OnTick(function (myHero)
	 
	local target = GetCurrentTarget()
	
	if IOW:Mode() == "Combo" then
		
		if GragasMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, 550) then
			CastSpell(_W)
		end
		
		
		if GragasMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target,850) then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero), target, GetMoveSpeed(target), 1200, 132, 850, 100, false, true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q,QPred.PredPos)
			end
		end

		if GragasMenu.Combo.R:Value() and Ready(_R) and ValidTarget(target,1150) then
			local RPred = GetPredictionForPlayer(GetOrigin(myHero), target, GetMoveSpeed(target), 1200, 132, 1150, 100, false, true)
			if RPred.HitChance == 1 then
				CastSkillShot(_R,RPred.PredPos)
			end
		end
		
		
		if GragasMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target,600) then
			CastSkillShot(_E,GetOrigin(target))
		end
		
		
		
	end
	
	if IOW:Mode() == "Harass" and GetPercentMP(myHero) >= GragasMenu.Harass.Mana:Value() then
	
		if GragasMenu.Harass.Q:Value() and Ready(_Q) and ValidTarget(target,850) then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero), target, GetMoveSpeed(target), 1200, 132, 850, 100, false, true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q,QPred.PredPos)
			end
		end
		
		if GragasMenu.Harass.E:Value() and Ready(_E) and ValidTarget(target,600) then
			CastSkillShot(_E,GetOrigin(target))
		end
	end
	
	for i,enemy in pairs(GetEnemyHeroes()) do

		if GragasMenu.Killsteal.Q:Value() and Ready(_Q) and ValidTarget(enemy, 850) and GetCurrentHP(enemy)+GetDmgShield(enemy) < getdmg("Q",enemy ,myHero) then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero), target, GetMoveSpeed(target), 1200, 132, 850, 100, false, true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q,QPred.PredPos)
			end
		end
		
	end	
end)

print("Toxic Gragas Loaded, Have Fun!")	
