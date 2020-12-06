defmodule Pickinsticks.State do
  alias Pickinsticks.State
  alias Pickinsticks.Position, as: Pos

  defstruct(
    sticks: [],
    player_position: %Pos{},
    world_bounds: %{width: 18, height: 9},
    sticks_found: 0,
    won: false
  )

  def update_state({:stick, state}, _current_state), do: pick_stick(state)
  def update_state({:blocked, _}, current_state), do: current_state
  def update_state({:out_of_bounds, _}, current_state), do: current_state
  def update_state({:ok, state}, _), do: state

  defp pick_stick(%State{player_position: pp, sticks_found: count} = state) do
    %State{
      state
      | sticks: Enum.reject(state.sticks, fn x -> x == pp end),
        sticks_found: count + 1
    }
  end

  def move(%State{player_position: pp} = state, :up), do: move_player_at(state, pp.x, pp.y - 1)
  def move(%State{player_position: pp} = state, :down), do: move_player_at(state, pp.x, pp.y + 1)
  def move(%State{player_position: pp} = state, :left), do: move_player_at(state, pp.x - 1, pp.y)

  def move(%State{player_position: pp} = state, :right),
    do: move_player_at(state, pp.x + 1, pp.y)

  def move(state, _), do: state

  defp move_player_at(state, x, y), do: %State{state | player_position: Pos.at(x, y)}

  def check_win(%State{sticks: []} = state), do: %State{state | won: true}
  def check_win(state), do: state
end
