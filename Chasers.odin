package Chaser

import "core:fmt"

// i want to create 2 pixels 1 blue and 1 red,, the red will chase the blue, and the blue will avoid red.

WINDOW_WIDTH :: 800
WINDOW_HEIGHT :: 600
pixel_size :: 10            // 1 shold be the size of 1 pixel so N will just be the deafult number x and y for length and width 
CENTER_X :: WINDOW_WIDTH / 2
CENTER_Y :: WINDOW_HEIGHT / 2

Pixel :: struct{
    loc_x : int,
    loc_y : int,
    heigth : int,
    width : int,
    color : string 
}

pixel_array := make([dynamic]^Pixel)

main :: proc(){
    fmt.println("here we go boys, hold on to your seats")   
}