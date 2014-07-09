expressionist
=============

A ruby arithmetics parser and converter to reverse polish notation, just for fun

Usage
-----

    > parser = Expressionist::Parser.new
    > parser.parse "(1 + 3) * 7 + 4 * (5 / 3)"
    > puts parser.to_f
    34.666666666666664
    > puts parser.to_rpn
    1 3 + 7 * 4 5 3 / * +
    > puts parser.to_tree
                           +
                           │
               ┌───────────┴───────────┐
               *                       *
               │                       │
         ┌─────┴─────┐           ┌─────┴─────┐
         +           7           4           /
         │                                   │
      ┌──┴──┐                             ┌──┴──┐
      1     3                             5     3
