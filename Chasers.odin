package chase_in_space

import "core:fmt"
import "core:math/linalg"
import "vendor:sdl2"

// i want to create 2 pixels 1 blue and 1 red,, the red will chase the blue, and the blue will avoid red.

/*
    Maxwell's Daemon, in Gnipahellir's depths, plays a cunning game,
    With points of memory as his pawns, in entropy's endless frame.
    Garm, the guardian fierce at Gnipahellir's gate, snarls at each move,
    Yet the Daemon defies, weaving past and present, in Gnipahellir's groove.
 
     Those who dare to fail miserably can achieve greatly
*/

Game :: struct {
	renderer: ^sdl2.Renderer,
	keyboard: []u8,
	time:     f64,
	dt:       f64,
	entities: [dynamic]Entity,
}

EntityType :: enum {
	BLUE,
	RED,	
}

Entity :: struct {
	type:           EntityType,
	hp:             int,
	pos:            [2]f32,
	vel:            [2]f32,
	reload_counter: f32,
	bullet_decay:   f32,
	dash_counter:   f32,
}

render_entity :: proc(entity: ^Entity, game: ^Game) {
	switch entity.type {
	case .BLUE:
		sdl2.SetRenderDrawColor(game.renderer, 0, 0, 255, 0)
		sdl2.RenderDrawRectF(
			game.renderer,
			&sdl2.FRect{x = entity.pos.x, y = entity.pos.y, w = 10, h = 10},
		)
	case .RED:
		sdl2.SetRenderDrawColor(game.renderer, 255, 0, 0, 0)
		sdl2.RenderDrawRectF(
			game.renderer,
			&sdl2.FRect{x = entity.pos.x, y = entity.pos.y, w = 10, h = 10},
		)
    }
}

find_entity :: proc(type: EntityType, game: ^Game) -> ^Entity {
	for _, i in game.entities {
		if game.entities[i].type == type {
			return &game.entities[i]
		}
	}
	return nil
}

get_time :: proc() -> f64 {
	return f64(sdl2.GetPerformanceCounter()) * 1000 / f64(sdl2.GetPerformanceFrequency())
}

main :: proc() {
	assert(sdl2.Init(sdl2.INIT_VIDEO) == 0, sdl2.GetErrorString())
	defer sdl2.Quit()

	window := sdl2.CreateWindow(
		"Odin Game",
		sdl2.WINDOWPOS_CENTERED,
		sdl2.WINDOWPOS_CENTERED,
		640,
		480,
		sdl2.WINDOW_SHOWN,
	)
	assert(window != nil, sdl2.GetErrorString())
	defer sdl2.DestroyWindow(window)

	// Must not do VSync because we run the tick loop on the same thread as rendering.
	renderer := sdl2.CreateRenderer(window, -1, sdl2.RENDERER_ACCELERATED)
	assert(renderer != nil, sdl2.GetErrorString())
	defer sdl2.DestroyRenderer(renderer)

	tickrate := 240.0
	ticktime := 1000.0 / tickrate

	game := Game {
		renderer = renderer,
		time     = get_time(),
		dt       = ticktime,
		entities = make([dynamic]Entity),
	}

	defer delete(game.entities)

	append(&game.entities, Entity{type = .BLUE, pos = { 50.0, 400.0}, hp = 10})

	dt := 0.0

	for {
		event: sdl2.Event
		for sdl2.PollEvent(&event) {
			#partial switch event.type {
			case .QUIT:
				return
			case .KEYDOWN:
				if event.key.keysym.scancode == sdl2.SCANCODE_ESCAPE {
					return
				}
			}
		}

		time := get_time()
		dt += time - game.time

		game.keyboard = sdl2.GetKeyboardStateAsSlice()
		game.time = time

		// Running on the same thread as rendering so in the end still limited by the rendering FPS.
		for dt >= ticktime {
			dt -= ticktime

			for _, i in game.entities {
			 
                // we do what?
                //screamers vs whisperers
                //screamers are the ones that yell here is my x and y, in a large range
                //whisperers are the ones that listen to the screamers, and they have a low range on creating sound
              
			}

			for i := 0; i < len(game.entities); {
				if game.entities[i].hp <= 0 {
					ordered_remove(&game.entities, i)
				} else {
					i += 1
				}
			}
		}

		sdl2.SetRenderDrawColor(renderer, 0, 0, 0, 0)
		sdl2.RenderClear(renderer)
		for _, i in game.entities {
			render_entity(&game.entities[i], &game)
		}
		sdl2.RenderPresent(renderer)
	}
}