defmodule Pickinsticks.State do
  alias Pickinsticks.Position, as: Pos

  defstruct(
    sticks: [],
    player_position: %Pos{},
    world_bounds: %{width: 18, height: 9},
    sticks_found: 0,
    won: false
  )
end
