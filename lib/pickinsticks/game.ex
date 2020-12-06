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
    |> move(direction)
    |> check_colisions
    |> update_state(state)
    |> check_win
  end

  defp move(%State{player_position: pp} = state, :up), do: move_player_at(state, pp.x, pp.y - 1)
  defp move(%State{player_position: pp} = state, :down), do: move_player_at(state, pp.x, pp.y + 1)
  defp move(%State{player_position: pp} = state, :left), do: move_player_at(state, pp.x - 1, pp.y)

  defp move(%State{player_position: pp} = state, :right),
    do: move_player_at(state, pp.x + 1, pp.y)

  defp move(state, _), do: state

  defp move_player_at(state, x, y), do: %State{state | player_position: Pos.at(x, y)}

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

  defp update_state({:stick, state}, _current_state), do: pick_stick(state)
  defp update_state({:blocked, _}, current_state), do: current_state
  defp update_state({:out_of_bounds, _}, current_state), do: current_state
  defp update_state({:ok, state}, _), do: state

  defp pick_stick(%State{player_position: ppos, sticks_found: count} = state) do
    %State{
      state
      | sticks: Enum.reject(state.sticks, fn x -> x == ppos end),
        sticks_found: count + 1
    }
  end

  defp check_win(%State{sticks: []} = state), do: %State{state | won: true}
  defp check_win(state), do: state
end
