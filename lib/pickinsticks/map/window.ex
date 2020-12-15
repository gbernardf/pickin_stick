defmodule Pickinsticks.Map.Window do
  alias Pickinsticks.Position, as: Pos
  alias Pickinsticks.Map.{Window, Tile}
  alias Pickinsticks.Geometry

  @view_w 5
  @view_h 5

  defstruct(
    size: %{w: @view_w, h: @view_h},
    data: %{
      player: %{pos: Pos.at(1, 1)},
      sticks_found: 0,
      won: false,
      tiles: %{colliders: [], ground: []},
      sticks: []
    }
  )

  def build(state) do
    view = view_rectangle(state.player_position, @view_w, @view_h)

    with tiles <- filter_tiles(state.tiles, view),
         sticks <-
           filter_sticks(state.sticks, view) |> Enum.map(&tile_to_tuple(&1)) do
      %Window{
        data: %{
          player: {state.player_position.x, state.player_position.y},
          sticks_found: state.sticks_found,
          won: state.won,
          sticks: sticks,
          tiles: tiles
        }
      }
    end
  end

  defp view_rectangle(center, width, height) do
    with x_offset <- div(width, 2),
         y_offset <- div(height, 2) do
      Geometry.Rectangle.build(center.x - x_offset, center.y - y_offset, width, height)
    end
  end

  defp filter_tiles(tiles, view) do
    with colliders <- keep_in_view(tiles.colliders, view) |> Enum.map(&tile_to_tuple(&1)),
         ground <- keep_in_view(tiles.ground, view) |> Enum.map(&tile_to_tuple(&1)) do
      %{
        colliders: colliders,
        ground: ground
      }
    end
  end

  defp filter_sticks(sticks, view) do
    keep_in_view(sticks, view)
  end

  defp keep_in_view(items, view) do
    Enum.filter(items, &Geometry.in_rectangle(&1.position, view))
  end

  defp tile_to_tuple(%Tile{position: %Pos{x: x, y: y}, type: t}), do: {x, y, t}
end
