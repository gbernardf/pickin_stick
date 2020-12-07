defmodule Pickinsticks.Collision do
  alias Pickinsticks.Position, as: Pos
  alias Pickinsticks.State

  def check_collisions(state) do
    cond do
      player_on_stick?(state) -> {:stick, state}
      player_blocked?(state) -> {:blocked, state}
      player_out_of_bounds?(state) -> {:out_of_bounds, state}
      true -> {:ok, state}
    end
  end

  defp player_on_stick?(state) do
    Enum.any?(state.sticks, &Pos.same?(&1, state.player_position))
  end

  defp player_blocked?(%State{tiles: %{walls: walls}} = state) do
    Enum.any?(walls, &Pos.same?(&1, state.player_position))
  end

  defp player_out_of_bounds?(state) do
    cond do
      state.player_position.x == -1 -> true
      state.player_position.y == -1 -> true
      state.player_position.x > state.world_bounds.width -> true
      state.player_position.y > state.world_bounds.height -> true
      true -> false
    end
  end
end
