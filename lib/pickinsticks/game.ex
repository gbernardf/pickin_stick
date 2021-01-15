defmodule Pickinsticks.Game do
  alias Pickinsticks.{State, Collision, StickGenerator, Window}
  alias Pickinsticks.Map.Window

  def new_game(sticks_count) do
    %State{}
    |> add_sticks(sticks_count)
  end

  defp add_sticks(state, sticks_count) do
    %State{state | sticks: StickGenerator.build(state, sticks_count)}
  end

  def make_move(state, direction) do
    state
    |> State.move(direction)
    |> Collision.check_collisions()
    |> State.update_state(state)
    |> State.check_win()
  end

  def build_view(state) do
    Window.build(state)
  end
end
