defmodule Pickinsticks.Map.Window do
  alias Pickinsticks.Position, as: Pos
  alias Pickinsticks.Map.{Window, Tile}
  alias Pickinsticks.Geometry

  @view_w 5
  @view_h 5

  defstruct(
    won: false,
    player: %{pos: Pos.at(1, 1)},
    sticks_found: 0,
    tiles: %{colliders: [], ground: []},
    sticks: [],
    size: %{w: @view_w, h: @view_h}
  )

  def build(state) do
    view = view_rectangle(state.player_position, @view_w, @view_h)

    with tiles <- filter_tiles(state.tiles, view),
         sticks <-
           filter_sticks(state.sticks, view)
           |> Enum.map(&to_tile(&1, :stick))
           |> Enum.map(&tile_to_tuple(&1)) do
      %Window{
        player: {state.player_position.x, state.player_position.y},
        sticks_found: state.sticks_found,
        won: state.won,
        sticks: sticks,
        tiles: tiles,
        size: %{w: @view_w, h: @view_h}
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
    with colliders <- keep_tile_in_view(tiles.colliders, view) |> Enum.map(&tile_to_tuple(&1)),
         ground <- keep_tile_in_view(tiles.ground, view) |> Enum.map(&tile_to_tuple(&1)) do
      %{
        colliders: colliders,
        ground: ground
      }
    end
  end

  defp filter_sticks(sticks, view) do
    Enum.filter(sticks, &Geometry.in_rectangle(&1, view))
  end

  defp to_tile(%Pos{} = pos, type), do: %Tile{position: pos, type: type}

  defp keep_tile_in_view(items, view) do
    Enum.filter(items, &Geometry.in_rectangle(&1.position, view))
  end

  defp tile_to_tuple(%Tile{position: %Pos{x: x, y: y}, type: t}), do: {x, y, t}
end
