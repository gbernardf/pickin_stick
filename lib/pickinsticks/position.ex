defmodule Pickinsticks.Position do
  alias Pickinsticks.Position, as: Pos

  defstruct x: 0, y: 0

  def at(x, y), do: %Pos{x: x, y: y}

  def same?(%Pos{} = this, %Pos{} = that), do: this == that
  def same_x?(%Pos{} = this, %Pos{} = that), do: this.x == that.x
  def same_y?(%Pos{} = this, %Pos{} = that), do: this.y == that.y

  def above?(%Pos{} = this, %Pos{} = that), do: this.y < that.y
  def below?(%Pos{} = this, %Pos{} = that), do: this.y > that.y
  def left_from?(%Pos{} = this, %Pos{} = that), do: this.x < that.x
  def right_from?(%Pos{} = this, %Pos{} = that), do: this.x > that.x
end
