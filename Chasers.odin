package Chaser

import "core:fmt"
import "vendor:sdl2"

// i want to create 2 pixels 1 blue and 1 red,, the red will chase the blue, and the blue will avoid red.

/*
    Maxwell's Daemon, in Gnipahellir's depths, plays a cunning game,
    With points of memory as his pawns, in entropy's endless frame.
    Garm, the guardian fierce at Gnipahellir's gate, snarls at each move,
    Yet the Daemon defies, weaving past and present, in Gnipahellir's groove.

    Those who dare to fail miserably can achieve greatly
*/

WINDOW_WIDTH :: 800
WINDOW_HEIGHT :: 600
pixel_size :: 10                    // 1 shold be the size of 1 pixel so N will just be the deafult number x and y for length and width 
CENTER_X :: WINDOW_WIDTH / 2
CENTER_Y :: WINDOW_HEIGHT / 2

Pixel :: struct{
    loc_x : int,
    loc_y : int,
    heigth : int,
    width : int,
    color : string 
}

Game :: struct {
    renderer:   ^sdl2.Renderer,
    keyboard:   []u8,
    time:       f64,
    dt:         f64,
    pixels:     [dynamic]^Pixel,
}

pixel_array := make([dynamic]^Pixel)

main :: proc(){
    fmt.println("the beginning")   

    assert(sdl2.Init(sdl2.INIT_VIDEO) == 0, sdl2.GetErrorString())
	defer sdl2.Quit()

    window := sdl2.CreateWindow(
		"Odin Game",
		sdl2.WINDOWPOS_CENTERED,
		sdl2.WINDOWPOS_CENTERED,
		WINDOW_WIDTH,
		WINDOW_HEIGHT,
		sdl2.WINDOW_SHOWN,
	)

    assert(window != nil, sdl2.GetErrorString())
	defer sdl2.DestroyWindow(window)

    renderer := sdl2.CreateRenderer(window, -1, sdl2.RENDERER_ACCELERATED)
	assert(renderer != nil, sdl2.GetErrorString())
	defer sdl2.DestroyRenderer(renderer)

	tickrate := 240.0
	ticktime := 1000.0 / tickrate

	game := Game {
		renderer = renderer,
		time     = get_time(),
		dt       = ticktime,
		pixels = make([dynamic]^Pixel),
	}
	defer delete(game.pixels)

    pixel_red := new(Pixel)
    pixel_red.loc_x = 100
    pixel_red.loc_y = 100
    pixel_red.heigth = pixel_size
    pixel_red.width = pixel_size
    pixel_red.color = "red" 
    
    pixel_blue := new(Pixel)
    pixel_blue.loc_x = 200
    pixel_blue.loc_y = 200
    pixel_blue.heigth = pixel_size
    pixel_blue.width = pixel_size
    pixel_blue.color = "blue"

    append(&pixel_array, pixel_red)
    append(&pixel_array, pixel_blue)

    // print the memory address of the pixel array
    fmt.println(&pixel_array)
    fmt.println("how many mem objects in array:", len(pixel_array))
    
    // print the memory address of the 2 pixels
    fmt.println("Red Pixel mem adress:" , &pixel_array[0])
    fmt.println("Blue Pixel mem adress:", &pixel_array[1])
    
    // and print the object values
    fmt.println("Red pixel obj:",  pixel_array[0])
    fmt.println("Blue pixel obj:", pixel_array[1])


    fmt.println("the end")
}