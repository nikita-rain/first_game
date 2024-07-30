extends Resource
class_name GameConstant

var frame_time := 1.0/60.0


var speed_dist = {
	"default_state": {
		"on_ground": {
			"horizontal": [150, 50*60, 50*60],
			"vertical": [0,0,0],
			"falling": [0,0,0],
			"takeoff": [0,0,0], 
			"jumping": [400, 400*60, 100*60],
			"jump_time": [3 * frame_time, 5 * frame_time],
		},
		"on_air": {
			"horizontal": [150, 50*60, 100*60], #TODO: поиграть с значениями движения в воздухе
			"vertical": [0,0,0],
			"falling": [400,100*60,150*60], #
			"takeoff": [0,0,0],
			"jumping": [400, 400*60, 100*60],
			"jump_time": [0 * frame_time, 0 * frame_time],
		},
		"on_water": { #TODO: сделать чтобы можно было немного двигаться вниз воды но она выталкивала, возможно прийдется добавить везде еще один параметр
			"horizontal": [70, 30, 70],
			"vertical": [0,0,0],
			"falling": [0,0,0],
			"takeoff": [0,0,0],
			"jumping": [50, 50, 50], #TODO: сделать более вязкий прыжок
			"jump_time": [5 * frame_time, 5 * frame_time],
		},
		"on_underwater": { #TODO: сделать чтобы можно было немного двигаться вниз воды но она выталкивала, возможно прийдется добавить везде еще один параметр
			"horizontal": [100, 50, 50],
			"vertical": [100,50,50],
			"falling": [10,10,10],
			"takeoff": [0,0,0],
			"jumping": [50, 50, 50], #TODO: сделать более вязкий прыжок
			"jump_time": [5 * frame_time, 5 * frame_time],
		},
		"on_ladder": { #TODO: сделать чтобы можно было немного двигаться вниз воды но она выталкивала, возможно прийдется добавить везде еще один параметр
			"horizontal": [100, 100*60, 100*60],
			"vertical": [100,100*60,100*60],
			"falling": [0,0,0],
			"takeoff": [0,0,0],
			"jumping": [400, 400*60, 100*60], #TODO: сделать более вязкий прыжок
			"jump_time": [3 * frame_time, 5 * frame_time],
		},
	},
	"easy_state": {
		"on_ground": {
			"horizontal": [150, 50*60, 50*60],
			"vertical": [0,0,0],
			"falling": [0,0,0],
			"takeoff": [0,0,0], 
			"jumping": [400, 400*60, 100*60],
			"jump_time": [3 * frame_time, 5 * frame_time],
		},
		"on_air": {
			"horizontal": [150, 50*60, 100*60], #TODO: поиграть с значениями движения в воздухе
			"vertical": [0,0,0],
			"falling": [400,100*60,150*60], #
			"takeoff": [0,0,0],
			"jumping": [400, 400*60, 100*60],
			"jump_time": [0 * frame_time, 0 * frame_time],
		},
		"on_water": {
			"horizontal": [70, 30, 70],
			"vertical": [0,0,0],
			"falling": [0,0,0],
			"takeoff": [0,0,0],
			"jumping": [50, 50, 50], 
			"jump_time": [20 * frame_time, 5 * frame_time],
		},
		"on_underwater": { 
			"horizontal": [100, 50, 50],
			"vertical": [100,50,50],
			"falling": [10,10,10],
			"takeoff": [0,0,0],
			"jumping": [50, 50, 50], 
			"jump_time": [20 * frame_time, 5 * frame_time],
		},
		"on_ladder": { #TODO: сделать чтобы можно было немного двигаться вниз воды но она выталкивала, возможно прийдется добавить везде еще один параметр
			"horizontal": [100, 100*60, 100*60],
			"vertical": [100,100*60,100*60],
			"falling": [0,0,0],
			"takeoff": [0,0,0],
			"jumping": [400, 400*60, 100*60], #TODO: сделать более вязкий прыжок
			"jump_time": [3 * frame_time, 5 * frame_time],
		},
	},
	"middle_state": {
		"on_ground": {
			"horizontal": [150, 50, 50],
			"vertical": [0,0,0],
			"falling": [0,0,0],
			"takeoff": [0,0,0], 
			"jumping": [400, 400, 100],
			"jump_time": [3 * frame_time, 5 * frame_time],
		},
		"on_air": {
			"horizontal": [150, 50, 100], #TODO: поиграть с значениями движения в воздухе
			"vertical": [0,0,0],
			"falling": [400,100,150], #
			"takeoff": [0,0,0],
			"jumping": [400, 400, 100],
			"jump_time": [0 * frame_time, 0 * frame_time],
		},
		"on_water": {
			"horizontal": [70, 30, 70],
			"vertical": [0,0,0],
			"falling": [0,0,0],
			"takeoff": [0,0,0],
			"jumping": [50, 50, 50], 
			"jump_time": [20 * frame_time, 5 * frame_time],
		},
		"on_underwater": { 
			"horizontal": [100, 50, 50],
			"vertical": [100,50,50],
			"falling": [10,10,10],
			"takeoff": [0,0,0],
			"jumping": [50, 50, 50], 
			"jump_time": [20 * frame_time, 5 * frame_time],
		},
		"on_ladder": { #TODO: сделать чтобы можно было немного двигаться вниз воды но она выталкивала, возможно прийдется добавить везде еще один параметр
			"horizontal": [100, 100*60, 100*60],
			"vertical": [100,100*60,100*60],
			"falling": [0,0,0],
			"takeoff": [0,0,0],
			"jumping": [400, 400*60, 100*60], #TODO: сделать более вязкий прыжок
			"jump_time": [3 * frame_time, 5 * frame_time],
		},
	},
	"hard_state": {
		"on_ground": {
			"horizontal": [150, 50*60, 50*60],
			"vertical": [0,0,0],
			"falling": [0,0,0],
			"takeoff": [0,0,0], 
			"jumping": [200, 400*60, 100*60],
			"jump_time": [3 * frame_time, 5 * frame_time],
		},
		"on_air": {
			"horizontal": [150, 50*60, 100*60], #TODO: поиграть с значениями движения в воздухе
			"vertical": [0,0,0],
			"falling": [400,100*60,150*60], #
			"takeoff": [0,0,0],
			"jumping": [400, 400*60, 100*60],
			"jump_time": [0 * frame_time, 0 * frame_time],
		},
		"on_water": {
			"horizontal": [70, 30, 70],
			"vertical": [0,0,0],
			"falling": [0,0,0],
			"takeoff": [0,0,0],
			"jumping": [50, 50, 50], 
			"jump_time": [20 * frame_time, 5 * frame_time],
		},
		"on_underwater": { 
			"horizontal": [100, 50, 50],
			"vertical": [100,50,50],
			"falling": [10,10,10],
			"takeoff": [0,0,0],
			"jumping": [50, 50, 50], 
			"jump_time": [20 * frame_time, 5 * frame_time],
		},
		"on_ladder": { #TODO: сделать чтобы можно было немного двигаться вниз воды но она выталкивала, возможно прийдется добавить везде еще один параметр
			"horizontal": [100, 100*60, 100*60],
			"vertical": [100,100*60,100*60],
			"falling": [0,0,0],
			"takeoff": [0,0,0],
			"jumping": [400, 400*60, 100*60], #TODO: сделать более вязкий прыжок
			"jump_time": [3 * frame_time, 5 * frame_time],
		},
	},
	"hover_state": {
		"on_ground": {
			"horizontal": [150, 50, 50],
			"vertical": [0,0,0],
			"falling": [0,0,0],
			"takeoff": [0,0,0], 
			"jumping": [400, 400, 100],
			"jump_time": [3 * frame_time, 5 * frame_time],
		},
		"on_air": {
			"horizontal": [150, 50, 100], #TODO: поиграть с значениями движения в воздухе
			"vertical": [0,0,0],
			"falling": [400,100,150], #
			"takeoff": [0,0,0],
			"jumping": [400, 400, 100],
			"jump_time": [0 * frame_time, 0 * frame_time],
		},
		"on_water": {
			"horizontal": [70, 30, 70],
			"vertical": [0,0,0],
			"falling": [0,0,0],
			"takeoff": [0,0,0],
			"jumping": [50, 50, 50], 
			"jump_time": [20 * frame_time, 5 * frame_time],
		},
		"on_underwater": { 
			"horizontal": [100, 50, 50],
			"vertical": [100,50,50],
			"falling": [10,10,10],
			"takeoff": [0,0,0],
			"jumping": [50, 50, 50], 
			"jump_time": [20 * frame_time, 5 * frame_time],
		},
		"on_ladder": { #TODO: сделать чтобы можно было немного двигаться вниз воды но она выталкивала, возможно прийдется добавить везде еще один параметр
			"horizontal": [100, 100*60, 100*60],
			"vertical": [100,100*60,100*60],
			"falling": [0,0,0],
			"takeoff": [0,0,0],
			"jumping": [400, 400*60, 100*60], #TODO: сделать более вязкий прыжок
			"jump_time": [3 * frame_time, 5 * frame_time],
		},
	},
	"water_state": {
		"on_ground": {
			"horizontal": [150, 50, 50],
			"vertical": [0,0,0],
			"falling": [0,0,0],
			"takeoff": [0,0,0], 
			"jumping": [400, 400, 100],
			"jump_time": [3 * frame_time, 5 * frame_time],
		},
		"on_air": {
			"horizontal": [150, 50, 100], #TODO: поиграть с значениями движения в воздухе
			"vertical": [0,0,0],
			"falling": [400,100,150], #
			"takeoff": [0,0,0],
			"jumping": [400, 400, 100],
			"jump_time": [0 * frame_time, 0 * frame_time],
		},
		"on_water": {
			"horizontal": [70, 30, 70],
			"vertical": [0,0,0],
			"falling": [0,0,0],
			"takeoff": [0,0,0],
			"jumping": [50, 50, 50], 
			"jump_time": [20 * frame_time, 5 * frame_time],
		},
		"on_underwater": { 
			"horizontal": [100, 50, 50],
			"vertical": [100,50,50],
			"falling": [10,10,10],
			"takeoff": [0,0,0],
			"jumping": [50, 50, 50], 
			"jump_time": [20 * frame_time, 5 * frame_time],
		},
		"on_ladder": { #TODO: сделать чтобы можно было немного двигаться вниз воды но она выталкивала, возможно прийдется добавить везде еще один параметр
			"horizontal": [100, 100*60, 100*60],
			"vertical": [100,100*60,100*60],
			"falling": [0,0,0],
			"takeoff": [0,0,0],
			"jumping": [400, 400*60, 100*60], #TODO: сделать более вязкий прыжок
			"jump_time": [3 * frame_time, 5 * frame_time],
		},
	},
	"underwater_state": {
		"on_ground": {
			"horizontal": [150, 50, 50],
			"vertical": [0,0,0],
			"falling": [0,0,0],
			"takeoff": [0,0,0], 
			"jumping": [400, 400, 100],
			"jump_time": [3 * frame_time, 5 * frame_time],
		},
		"on_air": {
			"horizontal": [150, 50, 100], #TODO: поиграть с значениями движения в воздухе
			"vertical": [0,0,0],
			"falling": [400,100,150], #
			"takeoff": [0,0,0],
			"jumping": [400, 400, 100],
			"jump_time": [0 * frame_time, 0 * frame_time],
		},
		"on_water": {
			"horizontal": [70, 30, 70],
			"vertical": [0,0,0],
			"falling": [0,0,0],
			"takeoff": [0,0,0],
			"jumping": [50, 50, 50], 
			"jump_time": [20 * frame_time, 5 * frame_time],
		},
		"on_underwater": { 
			"horizontal": [100, 50, 50],
			"vertical": [100,50,50],
			"falling": [10,10,10],
			"takeoff": [0,0,0],
			"jumping": [50, 50, 50], 
			"jump_time": [20 * frame_time, 5 * frame_time],
		},
		"on_ladder": { 
			"horizontal": [100, 100, 100],
			"vertical": [50,50,50],
			"falling": [0,0,0],
			"takeoff": [0,0,0],
			"jumping": [50, 50, 50],
			"jump_time": [20 * frame_time, 5 * frame_time],
		},
	},
}
