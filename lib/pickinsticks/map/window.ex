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
           filter_sticks(state.sticks, view) do
      %Window{
        data: %{
          player: state.player_position,
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

  def filter_tiles(tiles, view) do
    with walls <- keep_in_view(tiles.walls, view),
         grass <- keep_in_view(tiles.ground.grass, view),
         gravel <-
           keep_in_view(tiles.ground.gravel, view) do
      %{
        walls: walls,
        ground: %{
          grass: grass,
          gravel: gravel
        }
      }
    end
  end

  def filter_sticks(sticks, view) do
    keep_in_view(sticks, view)
  end

  def keep_in_view(items, view) do
    Enum.filter(items, &Geometry.in_rectangle(&1, view))
  end
end
