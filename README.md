# ca-cave.rb

## About

Ruby implementation of [Cellular Automata Method for Generating Random
Cave-Like Levels][algo].

## Example

    > ruby ./ca-cave.rb 60 15
    ############################################################
    ########..........##############....########################
    #######...............###....###....######.########..##.####
    ######.......................##.....####....###..........###
    #####..........##............##......##....###..........####
    ###............###...........###...........###..........####
    ###............##............###..........###...........####
    ##...........................####........####...........####
    ##...........................####.......####............####
    #........###......###....#..#####......#####...........#####
    #....#######.....####...#########......####............#####
    ##..#######.....####...###########....####.............#####
    ###########....#####..############...#####.###........######
    ##########....######.############################....#######
    ###########..###############################################

## Usage

Command-line usage:

`ca-cave.rb [width] [height]`

* `width`: map width (defaults to 80)
* `height`: map height (defaults to 30)

[algo]: http://roguebasin.roguelikedevelopment.org/index.php?title=Cellular_Automata_Method_for_Generating_Random_Cave-Like_Levels
  "Cellular Automata Method for Generating Random Cave-Like Levels"