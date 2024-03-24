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
    fmt.println("the beginning")   

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


}