defmodule Pickinsticks.Game do

  alias Pickinsticks.State

  def new_game, do: %State{}
  def handle_input(input, state) do
    input
    |> make_move(state)
    |> check_colisions
    |> check_win
  end

  def make_move("k", %State{player_position: {_, y}} = state) do
    cond do
      y > 0 -> %State{state | player_position: move_up(state.player_position)}
      true -> state
    end
  end

  def make_move("j", %State{world_bounds: {_, h}, player_position: {_, y}} = state) do
    cond do
      y <= h -> %State{state | player_position: move_down(state.player_position)}
      true -> state
    end
  end

  def make_move("h", %State{player_position: {x, _}} = state) do
    cond do
      x > 0 -> %State{state | player_position: move_left(state.player_position)}
      true -> state
    end
  end

  def make_move("l", %State{world_bounds: {w, _}, player_position: {x, _}} = state) do
    cond do
      x <= w -> %State{state | player_position: move_right(state.player_position)}
      true -> state
    end
  end
  def make_move(_, state), do: state

  def move_up({x,y}),    do: {x, y - 1}
  def move_down({x,y}),  do: {x, y + 1}
  def move_left({x,y}),  do: {x - 1, y}
  def move_right({x,y}), do: {x + 1, y}

  def check_colisions(state) do
    cond do
      Enum.any?(state.sticks, fn x -> x == state.player_position end) -> pick_stick(state)
      true -> state
    end
  end

  def pick_stick(%State{player_position: ppos, sticks_found: count} = state) do
    %State{
      state |
      sticks: Enum.reject(state.sticks, fn x -> x == ppos end),
      sticks_found: count + 1
    }
  end

  def check_win(%State{sticks: []} = state), do: %State{ state | won: true }
  def check_win(state), do: state

end
