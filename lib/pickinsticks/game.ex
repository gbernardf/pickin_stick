defmodule Pickinsticks.Game do
  alias Pickinsticks.{State, Colision}
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
    |> Colision.check_colisions()
    |> State.update_state(state)
    |> State.check_win()
  end
end
