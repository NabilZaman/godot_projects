class_name CombatCalculator
extends Resource

static func run_test(my_troops, enemy_troops) -> void:
	print(str(my_troops) + ", " + str(enemy_troops) + ": " + str(win_pct(my_troops, enemy_troops)))

static func test() -> void:
	run_test(500, 200)
	run_test(1000, 2000)
	run_test(2000, 1000)
	run_test(800, 550)
	run_test(600, 500)
	run_test(299, 100)

# takes a point between 0.0 and 1.0 and returns a new point between 0.0 and 1.0 in the transformed space
static func ease_sin_tranf(x: float) -> float:
	return sin(x * PI / 2.0)

# takes a value between 0.0 and 1.0 and returns a new point between 0.0 and 1.0 in the transformed space
static func ease_quad_tranf(x: float) -> float:
	return 1 - (1 - x) * (1 - x);

# Calculates the odds of winning a combat
static func win_pct(my_troops: int, enemy_troops: int) -> float:
	var my_advantage := true
	if my_troops < enemy_troops:
		my_advantage = false
	
	var a: int = max(my_troops, enemy_troops)
	var b: int = min(my_troops, enemy_troops)
	
	var diff = clamp(a - b, 0, 1000)
	
	var linear = clamp(diff / (2.0 * b), 0.0, 1.0)
	
	#var pct_linear = linear / 2.0
	#var pct_sin = ease_sin_tranf(linear) / 2.0
	var pct_quad = ease_quad_tranf(linear) / 2.0
	
	if my_advantage:
		#print(diff, " ", 0.5 + pct_linear, ", ", 0.5 + pct_sin, ", ", 0.5 + pct_quad)
		return 0.5 + pct_quad
	else:
		#print(diff, " ", 0.5 - pct_linear, ", ", 0.5 - pct_sin, ", ", 0.5 - pct_quad)
		return 0.5 - pct_quad

