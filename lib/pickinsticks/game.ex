defmodule Pickinsticks.Game do
  alias Pickinsticks.State
  alias Pickinsticks.Position, as: Pos

  def new_game, do: new_game(1)

  def new_game(sticks_count) do
    Enum.map(1..sticks_count, &random_stick/1)
    |> build_game
  end

  def random_stick(_) do
    Pos.at(Enum.random(0..18), Enum.random(0..9))
  end

  def build_game, do: %State{}

  def build_game(sticks) do
    %State{sticks: sticks}
  end

  def make_move(state, direction) do
    state
    |> State.move(direction)
    |> check_colisions
    |> State.update_state(state)
    |> State.check_win()
  end

  defp check_colisions(state) do
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

  defp player_blocked?(_state), do: false

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
