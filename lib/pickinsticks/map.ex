defmodule Pickinsticks.Map do
  alias Pickinsticks.Map.Tile

  defstruct colliders: [], ground: []
  #     0123456789012345678
  #    0###################
  #    1#,,,,,,,,,,,,,,,,,#
  #    2#,,,,,,,,,,,,,,,,,#
  #    3#,,,,,,,,,,,,,,,,,#
  #    4#,,,,,,,,,,,,,,,,,#
  #    5#,,,,,,,,,,,,,,,,,#
  #    6#,,,,,,,,,,,,...,,#
  #    7#,,,,,,,,##.......#
  #    8#,,,,,,,,##.......#
  #    9###################

  def build_map() do
    %Pickinsticks.Map{}
    |> add_walls
    |> add_grass
    |> add_gravel
  end

  defp add_walls(%Pickinsticks.Map{} = map) do
    top_walls = 0..18 |> Enum.map(fn x -> Tile.wall_at(x, 0) end)
    bot_walls = 0..18 |> Enum.map(fn x -> Tile.wall_at(x, 9) end)
    lef_walls = 0..9 |> Enum.map(fn y -> Tile.wall_at(0, y) end)
    rig_walls = 0..9 |> Enum.map(fn y -> Tile.wall_at(18, y) end)
    bot_block = 9..10 |> Enum.flat_map(fn x -> Enum.map(7..8, fn y -> Tile.wall_at(x, y) end) end)

    %Pickinsticks.Map{
      map
      | colliders: map.colliders ++ top_walls ++ bot_walls ++ lef_walls ++ rig_walls ++ bot_block
    }
  end

  defp add_grass(%Pickinsticks.Map{} = map) do
    top_grass = Enum.flat_map(1..17, fn x -> Enum.map(1..5, fn y -> Tile.grass_at(x, y) end) end)

    bot_lef_grass =
      Enum.flat_map(1..8, fn x -> Enum.map(6..8, fn y -> Tile.grass_at(x, y) end) end)

    other_grass =
      Enum.map(9..13, fn x -> Tile.grass_at(x, 6) end) ++
        [Tile.grass_at(16, 6)] ++ [Tile.grass_at(17, 6)]

    %Pickinsticks.Map{
      map
      | ground: map.ground ++ top_grass ++ bot_lef_grass ++ other_grass
    }
  end

  def add_gravel(%Pickinsticks.Map{} = map) do
    bot_gravel =
      Enum.flat_map(11..17, fn x -> Enum.map(7..8, fn y -> Tile.gravel_at(x, y) end) end)

    last_gravel = Enum.map(13..15, fn x -> Tile.gravel_at(x, 6) end)

    %Pickinsticks.Map{
      map
      | ground: map.ground ++ bot_gravel ++ last_gravel
    }
  end
end
