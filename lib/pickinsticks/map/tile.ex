defmodule Pickinsticks.Map.Tile do
  alias Pickinsticks.Position, as: Pos
  alias Pickinsticks.Map.Tile, as: Tile

  defstruct position: %Pos{}, type: nil

  def grass_at(x, y), do: %Tile{position: Pos.at(x, y), type: :grass}
  def wall_at(x, y), do: %Tile{position: Pos.at(x, y), type: :wall}
  def gravel_at(x, y), do: %Tile{position: Pos.at(x, y), type: :gravel}
end
