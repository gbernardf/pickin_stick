defmodule Pickinsticks.Map.Tile do
  alias Pickinsticks.Position, as: Pos
  alias Pickinsticks.Map.Tile, as: Tile

  defstruct position: %Pos{}, type: nil

  defmodule Grass do
    defstruct []
  end

  defmodule Wall do
    defstruct []
  end

  defmodule Gravel do
    defstruct []
  end

  def grass_at(x, y), do: %Tile{position: Pos.at(x, y), type: %Grass{}}
  def wall_at(x, y), do: %Tile{position: Pos.at(x, y), type: %Wall{}}
  def gravel_at(x, y), do: %Tile{position: Pos.at(x, y), type: %Gravel{}}
end
