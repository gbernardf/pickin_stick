defmodule Pickinsticks.Game do

  alias Pickinsticks.Game

  defstruct(
    sticks:          [{2,2}, {3,0}, {5,7}, {8,2}],
    player_position: {0, 0},
    world_bounds:    {18, 9},
    sticks_found:    0,
    won:             false
  )

  def new_game, do: %Game{}
  def handle_input(input, state) do
    input
    |> make_move(state)
    |> check_colisions
    |> check_win
  end

  def make_move("k", %Game{player_position: {_, y}} = state) when y > 0 do
    move_up(state)
  end

  def make_move("j", %Game{world_bounds: {_, h}, player_position: {_, y}} = state) when y < h do
    move_down(state)
  end

  def make_move("h", %Game{player_position: {x, _}} = state) when x > 0 do
    move_left(state)
  end

  def make_move("l", %Game{world_bounds: {w, _}, player_position: {x, _}} = state) when x < w do
    move_right(state)
  end

  def make_move(_, state), do: state

  def move_up(%Game{player_position: {x,y}} = state),    do: %Game{state | player_position: {x, y - 1}}
  def move_down(%Game{player_position: {x,y}} = state),  do: %Game{state | player_position: {x, y + 1}}
  def move_left(%Game{player_position: {x,y}} = state),  do: %Game{state | player_position: {x - 1, y}}
  def move_right(%Game{player_position: {x,y}} = state), do: %Game{state | player_position: {x + 1, y}}

  def check_colisions(state) do
    cond do
      Enum.any?(state.sticks, fn x -> x == state.player_position end) -> pick_stick(state)
      true -> state
    end
  end

  def pick_stick(%Game{player_position: ppos, sticks_found: count} = state) do
    %Game{
      state |
      sticks: Enum.reject(state.sticks, fn x -> x == ppos end),
      sticks_found: count + 1
    }
  end

  def check_win(%Game{sticks: []} = state), do: %Game{ state | won: true }
  def check_win(state), do: state

end
