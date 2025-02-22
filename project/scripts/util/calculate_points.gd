extends Resource

func distanceEuclidean(list1: Array[int], list2: Array[int]):
	var squared: float = 0
	for i in range(0, len(list1)):
		squared = (list1[i] - list2[i])**2
	return sqrt(squared)

func getPointMultiplier(x: int):
	if x>=20: return 0
	if x<=0: return 1
	return (1-1/20*x)**2

func calculateQuality(inputListOfIngredientRunes : Array[RecipeIngredientRune], recipePotion: RecipePotion) -> int:
#	Initialize points to max
	var points = recipePotion.points
	var multiplier = 1
#	for every reference ingredient
	var listRef = recipePotion.listOfIngredientRunes
	for refIngredientRune in listRef:
		var minDistance = 1000
		var minDistanceIngredientRune: RecipeIngredientRune = null
		for inputIngredientRune in inputListOfIngredientRunes:
			var newDistance = distanceEuclidean(inputIngredientRune.getVector(), refIngredientRune.getVector())
			if newDistance < minDistance:
				minDistance = newDistance
				minDistanceIngredientRune = inputIngredientRune
		multiplier *= getPointMultiplier(minDistance)
		inputListOfIngredientRunes.erase(minDistanceIngredientRune)
	return points * multiplier

func getGrade(quality: int, recipePotion: RecipePotion):
	var refPoints = recipePotion.points
	if quality == refPoints:
		return "S"
	if quality > 0.75*refPoints:
		return "A"
	if quality > 0.5*refPoints:
		return "B"
	else:
		return "F"
