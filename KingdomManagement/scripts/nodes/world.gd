class_name World
extends Node2D

var regionA_tiles: Array[TileConfig] = [
	TileConfig.new([0, 0], Enums.Tiles.GRASS),
	TileConfig.new([-1, 1], Enums.Tiles.GRASS),
	TileConfig.new([1, 1], Enums.Tiles.GRASS),
	TileConfig.new([-4, 2], Enums.Tiles.GRASS),
	TileConfig.new([-2, 2], Enums.Tiles.GRASS),
	TileConfig.new([0, 2], Enums.Tiles.GRASS),
	TileConfig.new([2, 2], Enums.Tiles.GRASS),
	TileConfig.new([-3, 3], Enums.Tiles.GRASS),
	TileConfig.new([-1, 3], Enums.Tiles.GRASS),
	TileConfig.new([1, 3], Enums.Tiles.GRASS),
	TileConfig.new([3, 3], Enums.Tiles.GRASS),
	TileConfig.new([5, 3], Enums.Tiles.GRASS),
	TileConfig.new([-2, 4], Enums.Tiles.GRASS),
	TileConfig.new([-0, 4], Enums.Tiles.GRASS),
	TileConfig.new([2, 4], Enums.Tiles.GRASS),
	TileConfig.new([4, 4], Enums.Tiles.GRASS),
	TileConfig.new([-1, 5], Enums.Tiles.GRASS),
]

var regionB_tiles: Array[TileConfig] = [
	TileConfig.new([1, 5], Enums.Tiles.GRASS),
	TileConfig.new([3, 5], Enums.Tiles.GRASS),
	TileConfig.new([0, 6], Enums.Tiles.GRASS),
	TileConfig.new([2, 6], Enums.Tiles.GRASS),
	TileConfig.new([4, 6], Enums.Tiles.GRASS),
	TileConfig.new([6, 6], Enums.Tiles.GRASS),
	TileConfig.new([1, 7], Enums.Tiles.GRASS),
	TileConfig.new([3, 7], Enums.Tiles.GRASS),
	TileConfig.new([5, 7], Enums.Tiles.GRASS),
	TileConfig.new([7, 7], Enums.Tiles.GRASS),
	TileConfig.new([2, 8], Enums.Tiles.GRASS),
	TileConfig.new([4, 8], Enums.Tiles.GRASS),
]

var regionC_tiles: Array[TileConfig] = [
	TileConfig.new([-3, -7], Enums.Tiles.GRASS),
	TileConfig.new([-1, -7], Enums.Tiles.GRASS),
	TileConfig.new([-4, -6], Enums.Tiles.GRASS),
	TileConfig.new([-2, -6], Enums.Tiles.GRASS),
	TileConfig.new([0, -6], Enums.Tiles.GRASS),
	TileConfig.new([1, -5], Enums.Tiles.GRASS),
	TileConfig.new([3, -5], Enums.Tiles.GRASS),
	TileConfig.new([0, -4], Enums.Tiles.GRASS),
	TileConfig.new([2, -4], Enums.Tiles.GRASS),
	TileConfig.new([4, -4], Enums.Tiles.GRASS),
	TileConfig.new([6, -4], Enums.Tiles.GRASS),
	TileConfig.new([8, -4], Enums.Tiles.GRASS),
	TileConfig.new([-1, -3], Enums.Tiles.GRASS),
	TileConfig.new([1, -3], Enums.Tiles.GRASS),
	TileConfig.new([3, -3], Enums.Tiles.GRASS),
	TileConfig.new([5, -3], Enums.Tiles.GRASS),
	TileConfig.new([7, -3], Enums.Tiles.GRASS),
	TileConfig.new([9, -3], Enums.Tiles.GRASS),
	TileConfig.new([0, -2], Enums.Tiles.GRASS),
	TileConfig.new([2, -2], Enums.Tiles.GRASS),
	TileConfig.new([4, -2], Enums.Tiles.GRASS),
	TileConfig.new([6, -2], Enums.Tiles.GRASS),
	TileConfig.new([8, -2], Enums.Tiles.GRASS),
	TileConfig.new([10, -2], Enums.Tiles.GRASS),
	TileConfig.new([-1, -1], Enums.Tiles.GRASS),
	TileConfig.new([1, -1], Enums.Tiles.GRASS),
	TileConfig.new([3, -1], Enums.Tiles.GRASS),
	TileConfig.new([5, -1], Enums.Tiles.GRASS),
	TileConfig.new([7, -1], Enums.Tiles.GRASS),
	TileConfig.new([9, -1], Enums.Tiles.GRASS),
	TileConfig.new([11, -1], Enums.Tiles.GRASS),
	TileConfig.new([-2, 0], Enums.Tiles.GRASS),
	TileConfig.new([2, 0], Enums.Tiles.GRASS),
	TileConfig.new([4, 0], Enums.Tiles.GRASS),
	TileConfig.new([6, 0], Enums.Tiles.GRASS),
	TileConfig.new([8, 0], Enums.Tiles.GRASS),
	TileConfig.new([10, 0], Enums.Tiles.GRASS),
	TileConfig.new([3, 1], Enums.Tiles.GRASS),
	TileConfig.new([5, 1], Enums.Tiles.GRASS),
	TileConfig.new([7, 1], Enums.Tiles.GRASS),
	TileConfig.new([9, 1], Enums.Tiles.GRASS),
	TileConfig.new([4, 2], Enums.Tiles.GRASS),
	TileConfig.new([6, 2], Enums.Tiles.GRASS),
	TileConfig.new([8, 2], Enums.Tiles.GRASS),
]

var regionD_tiles: Array[TileConfig] = [
	TileConfig.new([12, -10], Enums.Tiles.GRASS),
	TileConfig.new([14, -10], Enums.Tiles.GRASS),
	TileConfig.new([11, -9], Enums.Tiles.GRASS),
	TileConfig.new([13, -9], Enums.Tiles.GRASS),
	TileConfig.new([15, -9], Enums.Tiles.GRASS),
	TileConfig.new([10, -8], Enums.Tiles.GRASS),
	TileConfig.new([12, -8], Enums.Tiles.GRASS),
	TileConfig.new([14, -8], Enums.Tiles.GRASS),
	TileConfig.new([16, -8], Enums.Tiles.GRASS),
	TileConfig.new([18, -8], Enums.Tiles.GRASS),
	TileConfig.new([9, -7], Enums.Tiles.GRASS),
	TileConfig.new([11, -7], Enums.Tiles.GRASS),
	TileConfig.new([13, -7], Enums.Tiles.GRASS),
	TileConfig.new([15, -7], Enums.Tiles.GRASS),
	TileConfig.new([17, -7], Enums.Tiles.GRASS),
	TileConfig.new([19, -7], Enums.Tiles.GRASS),
	TileConfig.new([8, -6], Enums.Tiles.GRASS),
	TileConfig.new([10, -6], Enums.Tiles.GRASS),
	TileConfig.new([12, -6], Enums.Tiles.GRASS),
	TileConfig.new([14, -6], Enums.Tiles.GRASS),
	TileConfig.new([16, -6], Enums.Tiles.GRASS),
	TileConfig.new([18, -6], Enums.Tiles.GRASS),
	TileConfig.new([20, -6], Enums.Tiles.GRASS),
	TileConfig.new([7, -5], Enums.Tiles.GRASS),
	TileConfig.new([9, -5], Enums.Tiles.GRASS),
	TileConfig.new([11, -5], Enums.Tiles.GRASS),
	TileConfig.new([13, -5], Enums.Tiles.GRASS),
	TileConfig.new([15, -5], Enums.Tiles.GRASS),
	TileConfig.new([17, -5], Enums.Tiles.GRASS),
	TileConfig.new([19, -5], Enums.Tiles.GRASS),
	TileConfig.new([10, -4], Enums.Tiles.GRASS),
	TileConfig.new([12, -4], Enums.Tiles.GRASS),
	TileConfig.new([14, -4], Enums.Tiles.GRASS),
	TileConfig.new([18, -4], Enums.Tiles.GRASS),
	TileConfig.new([11, -3], Enums.Tiles.GRASS),
	TileConfig.new([12, -2], Enums.Tiles.GRASS),
]

var regionE_tiles: Array[TileConfig] = [
	TileConfig.new([-12, -8], Enums.Tiles.GRASS),
	TileConfig.new([-10, -8], Enums.Tiles.GRASS),
	TileConfig.new([-11, -7], Enums.Tiles.GRASS),
	TileConfig.new([-9, -7], Enums.Tiles.GRASS),
	TileConfig.new([-7, -7], Enums.Tiles.GRASS),
	TileConfig.new([-5, -7], Enums.Tiles.GRASS),
	TileConfig.new([-12, -6], Enums.Tiles.GRASS),
	TileConfig.new([-10, -6], Enums.Tiles.GRASS),
	TileConfig.new([-8, -6], Enums.Tiles.GRASS),
	TileConfig.new([-6, -6], Enums.Tiles.GRASS),
	TileConfig.new([-9, -5], Enums.Tiles.GRASS),
	TileConfig.new([-7, -5], Enums.Tiles.GRASS),
	TileConfig.new([-5, -5], Enums.Tiles.GRASS),
	TileConfig.new([-3, -5], Enums.Tiles.GRASS),
	TileConfig.new([-1, -5], Enums.Tiles.GRASS),
	TileConfig.new([-10, -4], Enums.Tiles.GRASS),
	TileConfig.new([-8, -4], Enums.Tiles.GRASS),
	TileConfig.new([-6, -4], Enums.Tiles.GRASS),
	TileConfig.new([-4, -4], Enums.Tiles.GRASS),
	TileConfig.new([-2, -4], Enums.Tiles.GRASS),
	TileConfig.new([-9, -3], Enums.Tiles.GRASS),
	TileConfig.new([-7, -3], Enums.Tiles.GRASS),
	TileConfig.new([-5, -3], Enums.Tiles.GRASS),
	TileConfig.new([-3, -3], Enums.Tiles.GRASS),
	TileConfig.new([-10, -2], Enums.Tiles.GRASS),
	TileConfig.new([-8, -2], Enums.Tiles.GRASS),
	TileConfig.new([-6, -2], Enums.Tiles.GRASS),
	TileConfig.new([-4, -2], Enums.Tiles.GRASS),
	TileConfig.new([-2, -2], Enums.Tiles.GRASS),
	TileConfig.new([-9, -1], Enums.Tiles.GRASS),
	TileConfig.new([-7, -1], Enums.Tiles.GRASS),
	TileConfig.new([-5, -1], Enums.Tiles.GRASS),
	TileConfig.new([-3, -1], Enums.Tiles.GRASS),
	TileConfig.new([-10, 0], Enums.Tiles.GRASS),
	TileConfig.new([-8, 0], Enums.Tiles.GRASS),
	TileConfig.new([-6, 0], Enums.Tiles.GRASS),
	TileConfig.new([-4, 0], Enums.Tiles.GRASS),
	TileConfig.new([-9, 1], Enums.Tiles.GRASS),
	TileConfig.new([-7, 1], Enums.Tiles.GRASS),
	TileConfig.new([-5, 1], Enums.Tiles.GRASS),
	TileConfig.new([-3, 1], Enums.Tiles.GRASS),
]

var regionF_tiles: Array[TileConfig] = [
	TileConfig.new([-20, -8], Enums.Tiles.GRASS),
	TileConfig.new([-18, -8], Enums.Tiles.GRASS),
	TileConfig.new([-16, -8], Enums.Tiles.GRASS),
	TileConfig.new([-14, -8], Enums.Tiles.GRASS),
	TileConfig.new([-21, -7], Enums.Tiles.GRASS),
	TileConfig.new([-19, -7], Enums.Tiles.GRASS),
	TileConfig.new([-17, -7], Enums.Tiles.GRASS),
	TileConfig.new([-15, -7], Enums.Tiles.GRASS),
	TileConfig.new([-13, -7], Enums.Tiles.GRASS),
	TileConfig.new([-22, -6], Enums.Tiles.GRASS),
	TileConfig.new([-20, -6], Enums.Tiles.GRASS),
	TileConfig.new([-18, -6], Enums.Tiles.GRASS),
	TileConfig.new([-16, -6], Enums.Tiles.GRASS),
	TileConfig.new([-14, -6], Enums.Tiles.GRASS),
	TileConfig.new([-23, -5], Enums.Tiles.GRASS),
	TileConfig.new([-21, -5], Enums.Tiles.GRASS),
	TileConfig.new([-19, -5], Enums.Tiles.GRASS),
	TileConfig.new([-17, -5], Enums.Tiles.GRASS),
	TileConfig.new([-15, -5], Enums.Tiles.GRASS),
	TileConfig.new([-13, -5], Enums.Tiles.GRASS),
	TileConfig.new([-11, -5], Enums.Tiles.GRASS),
	TileConfig.new([-22, -4], Enums.Tiles.GRASS),
	TileConfig.new([-20, -4], Enums.Tiles.GRASS),
	TileConfig.new([-18, -4], Enums.Tiles.GRASS),
	TileConfig.new([-16, -4], Enums.Tiles.GRASS),
	TileConfig.new([-14, -4], Enums.Tiles.GRASS),
	TileConfig.new([-12, -4], Enums.Tiles.GRASS),
	TileConfig.new([-21, -3], Enums.Tiles.GRASS),
	TileConfig.new([-19, -3], Enums.Tiles.GRASS),
	TileConfig.new([-17, -3], Enums.Tiles.GRASS),
	TileConfig.new([-15, -3], Enums.Tiles.GRASS),
	TileConfig.new([-13, -3], Enums.Tiles.GRASS),
	TileConfig.new([-11, -3], Enums.Tiles.GRASS),
	TileConfig.new([-18, -2], Enums.Tiles.GRASS),
	TileConfig.new([-16, -2], Enums.Tiles.GRASS),
	TileConfig.new([-14, -2], Enums.Tiles.GRASS),
	TileConfig.new([-12, -2], Enums.Tiles.GRASS),
	TileConfig.new([-17, -1], Enums.Tiles.GRASS),
	TileConfig.new([-15, -1], Enums.Tiles.GRASS),
	TileConfig.new([-13, -1], Enums.Tiles.GRASS),
	TileConfig.new([-11, -1], Enums.Tiles.GRASS),
]


#func _init(name: String, selectable: bool, pos: Array, tiles: Array[TileConfig]) -> void:
func regionA() -> RegionConfig:
	var region = RegionConfig.new("RegionA", true, [0, 0], regionA_tiles)
	return region

func regionB() -> RegionConfig:
	var region = RegionConfig.new("RegionB", true, [0, 0], regionB_tiles)
	return region
	
func regionC() -> RegionConfig:
	var region = RegionConfig.new("RegionC", true, [0, 0], regionC_tiles)
	return region

func regionD() -> RegionConfig:
	var region = RegionConfig.new("RegionD", true, [0, 0], regionD_tiles)
	return region

func regionE() -> RegionConfig:
	var region = RegionConfig.new("RegionE", true, [0, 0], regionE_tiles)
	return region

func regionF() -> RegionConfig:
	var region = RegionConfig.new("RegionF", true, [0, 0], regionF_tiles)
	return region


const XMIN = -20
const XMAX = 20
const YMIN = -20
const YMAX = 20

func ocean() -> RegionConfig:
	var ocean_tiles: Array[TileConfig] = []
	for x in range(XMIN, XMAX):
		for y in range(YMIN, YMAX):
			var xpos = 2 * x + (y % 2)
			var ypos = y
			ocean_tiles.append(TileConfig.new([xpos, ypos], Enums.Tiles.OCEAN, null, -1))
	# loop over range and build up tile configs for ocean
	# use some sort of layer system to make sure oceans get overwritten by landmasses
	
	var region = RegionConfig.new("Ocean", false, [0,0], ocean_tiles)
	return region

func judgement_kingdom() -> Kingdom:
	return Kingdom.new("JudgementKingdom", Enums.BorderStyles.STYLE1, [regionA()])
	
func valor_kingdom() -> Kingdom:
	return Kingdom.new("ValorKingdom", Enums.BorderStyles.STYLE2, [regionB()])
	
func harmony_kingdom() -> Kingdom:
	return Kingdom.new("HarmonyKingdom", Enums.BorderStyles.STYLE5, [regionC(), regionD()])

func sagacity_kingdom() -> Kingdom:
	return Kingdom.new("SagacityKingdom", Enums.BorderStyles.STYLE3, [regionE(), regionF()])

func impassable_kingdom() -> Kingdom:
	return Kingdom.new("Impassable", Enums.BorderStyles.STYLE1, [ocean()])

# represent each tile config as:
# [[x, y], Tile texture, tile resource, tile type?]
# (the type may have the texture defined but also other stuff like oceans behave a certain way)] 

func build_map() -> void:
	self.add_child(judgement_kingdom()) # player kingdom?
	self.add_child(valor_kingdom())
	self.add_child(harmony_kingdom())
	self.add_child(sagacity_kingdom())
	self.add_child(impassable_kingdom())
	#var HarmonyKingdom = Kingdom.new()
	#var SagacityKingdom = Kingdom.new()
	#var FerocityKingdom = Kingdom.new()
	#var CunningKingdom = Kingdom.new()
	#var FortitudeKingdom = Kingdom.new()
	#var InspirationKingdom = Kingdom.new()
	#var ValorKingdom = Kingdom.new()
	

func _ready():
	self.build_map()

func _init() -> void:
	pass

