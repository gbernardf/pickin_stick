defmodule Pickinsticks.Map.Window do
  alias Pickinsticks.Position, as: Pos
  alias Pickinsticks.Map.Window
  alias Pickinsticks.Geometry

  @view_w 5
  @view_h 5

  defstruct(
    size: %{w: @view_w, h: @view_h},
    data: %{
      player: %{pos: Pos.at(1, 1)},
      sticks_found: 0,
      won: false,
      tiles: %{},
      sticks: []
    }
  )

  def build(state) do
    view = view_rectangle(state.player_position, @view_w, @view_h)

    with tiles <- filter_tiles(state.tiles, view),
         sticks <-
           filter_sticks(state.sticks, view) |> Enum.map(&position_to_tuple(&1)) do
      %Window{
        data: %{
          player: state.player_position |> position_to_tuple(),
          sticks_found: state.sticks_found,
          won: state.won,
          sticks: sticks,
          tiles: tiles
        }
      }
    end
  end

  defp view_rectangle(center, width, height) do
    Geometry.Rectangle.build(center.x, center.y, width, height)
  end

  defp filter_tiles(tiles, view) do
    with walls <- keep_in_view(tiles.walls, view) |> Enum.map(&position_to_tuple(&1)),
         grass <- keep_in_view(tiles.ground.grass, view) |> Enum.map(&position_to_tuple(&1)),
         gravel <-
           keep_in_view(tiles.ground.gravel, view) |> Enum.map(&position_to_tuple(&1)) do
      %{
        walls: walls,
        ground: %{
          grass: grass,
          gravel: gravel
        }
      }
    end
  end

  defp filter_sticks(sticks, view) do
    keep_in_view(sticks, view)
  end

  defp keep_in_view(items, view) do
    Enum.filter(items, &Geometry.in_rectangle(&1, view))
  end

  defp position_to_tuple(%Pos{x: x, y: y}), do: {x, y}
end
