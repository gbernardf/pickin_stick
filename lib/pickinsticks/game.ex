defmodule Pickinsticks.Game do
  alias Pickinsticks.Game

  defstruct(
    sticks: [{2, 2}, {3, 0}, {5, 7}, {8, 2}],
    player_position: {0, 0},
    world_bounds: {18, 9},
    sticks_found: 0,
    won: false
  )

  def new_game, do: %Game{}

  def new_game(sticks_count) do
    Enum.map(1..sticks_count, &random_stick/1)
    |> build_game
  end

  def random_stick(_) do
    {Enum.random(0..18), Enum.random(0..9)}
  end

  def build_game, do: %Game{}

  def build_game(sticks) do
    %Game{sticks: sticks}
  end

  def handle_input(input, state) do
    input
    |> make_move(state)
    |> check_colisions
    |> check_win
  end

  defp make_move("k", %Game{player_position: {_, y}} = state) when y > 0 do
    move_up(state)
  end

  defp make_move("j", %Game{world_bounds: {_, h}, player_position: {_, y}} = state) when y < h do
    move_down(state)
  end

  defp make_move("h", %Game{player_position: {x, _}} = state) when x > 0 do
    move_left(state)
  end

  defp make_move("l", %Game{world_bounds: {w, _}, player_position: {x, _}} = state) when x < w do
    move_right(state)
  end

  defp make_move(_, state), do: state

  defp move_up(%Game{player_position: {x, y}} = state),
    do: %Game{state | player_position: {x, y - 1}}

  defp move_down(%Game{player_position: {x, y}} = state),
    do: %Game{state | player_position: {x, y + 1}}

  defp move_left(%Game{player_position: {x, y}} = state),
    do: %Game{state | player_position: {x - 1, y}}

  defp move_right(%Game{player_position: {x, y}} = state),
    do: %Game{state | player_position: {x + 1, y}}

  defp check_colisions(state) do
    cond do
      player_on_stick?(state) -> pick_stick(state)
      true -> state
    end
  end

  defp player_on_stick?(state) do
    Enum.any?(state.sticks, fn x -> x == state.player_position end)
  end

  defp pick_stick(%Game{player_position: ppos, sticks_found: count} = state) do
    %Game{
      state
      | sticks: Enum.reject(state.sticks, fn x -> x == ppos end),
        sticks_found: count + 1
    }
  end

  defp check_win(%Game{sticks: []} = state), do: %Game{state | won: true}
  defp check_win(state), do: state
end
