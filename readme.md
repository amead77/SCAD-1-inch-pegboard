# Pegboard tool holders in OpenSCAD


I designed this because I have 1" spaced pegboard, but wanted to be able to also do other peg spacing.

### It can be easily adapted to metric 25mm, or any other size, right within the customiser, so long as the holes are circular and in a square grid.

Everything about it is customisable. Maybe even for skadis, but I don't have any to test against. It would require offsetting each row of pegs though, because skadis offsets the rows from each other.

All the parts can be created from assembly.scad, by default it loads an overview.
By choosing which part to create, you can make any of the parts I've designed, in any size you want.

Before printing a bunch of stuff, I recommend doing a small print first to check the tolerances. My 0.4mm nozzle created nice 'n' tight fitting pegs, my 0.6mm created loose fitting pegs. 


Anyway, if you like the design, you're welcome to buy me a coffee:

<a href="https://buymeacoffee.com/amead77"><img src="images/bmc-button.png" alt="Buy Me a Coffee" width="50%" /></a>



![overview](images/overview-assembly.png)

A look at the back. The number of pegs is defined by the peg units.
The width and height of the back panel is defined by peg units and peg spacing. If you change to a 25mm peg spacing, it'll be smaller than my 25.4mm spaced ones.
The thickness of the peg panel back is in MM.

![overview-rear](images/overview-rear.png)

A small double box.

![doublebox](images/box-double_small.png)

A pot holder with a front cutout

![pot](images/pot_holder-with_cutout.png)

A small screwdriver rail

![screwd](images/screwdriver-small.png)

The same rail, but with a cutout for inserting stuff from the front

![screwdc](images/screwdriver-chop.png)

How about some lips?

![screwdd](images/screwdriver-lips.png)

Some hooks for hooky stuff, looks a bit jank because I didn't want to math out a curve, plus printing a upwards curve means supports for overhang.

![hooks](images/hooks.png)

Spirit level holder - this comes from the same model as the box, just by having the sides open.

![level](images/spirit-level-1.png)

By choosing a side, endcaps, and levels, you can create multi holders, some with openings, some without, at the same time if you want.

![level2](images/spirit-level-2.png)

You can also set step_level in mm, to offset each part

![level3](images/stepped.png)

Side support, this is for supporting stuff from the side, can be angled. Stuff like laptops could be supported this way. Can be supported either or both sides, with or without the base.

![sidesup](images/side-support.png)

![sidesip1](images/side-supports-both.png)

How about a custon pegboard? As many 'oles as you like.

![pegboard](images/pegboard.png)

Want a reinforced back to it? Sure!

![pegboard2](images/pegboard-back.png)


Licence is CC-non commerical

AI used was co-pilot to refactor and fix my mistakes. co-pilot is very good at that, but cannot create a openscad model from scratch.