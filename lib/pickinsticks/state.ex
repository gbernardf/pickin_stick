defmodule Pickinsticks.State do

  defstruct(
    sticks:          [{2,2}, {3,0}, {5,7}, {8,2}],
    player_position: {0, 0},
    world_bounds:    {18, 9},
    sticks_found:    0,
    won:             false
  )

end
