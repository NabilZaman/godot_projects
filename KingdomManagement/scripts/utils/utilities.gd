class_name Utilities
extends Resource

static func aggregate_resources(resources: Array[GameResource]) -> Array[GameResource]:
	var aggregates := {}
	for resource in resources:
		if resource.type not in aggregates:
			aggregates[resource.type] = 0
		aggregates[resource.type] += resource.qty
	var result: Array[GameResource] = []
	for type in aggregates:
		result.append(GameResource.new(type, aggregates[type])) 
	return result
