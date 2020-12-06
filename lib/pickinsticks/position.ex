defmodule Pickinsticks.Position do
  alias Pickinsticks.Position, as: Pos

  defstruct x: 0, y: 0

  def at(x, y), do: %Pos{x: x, y: y}
  def same?(%Pos{} = this, %Pos{} = that), do: this == that
end
