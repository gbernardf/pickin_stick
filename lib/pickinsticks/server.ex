defmodule Pickinsticks.Server do
  use GenServer

  alias Pickinsticks.Game

  def start_link(stick_count) do
    GenServer.start_link(__MODULE__, Game.new_game(stick_count))
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call({:make_move, direction}, _form, state) do
    state = Game.make_move(state, direction)
    view = Game.build_view(state)

    {:reply, view, state}
  end

  def handle_call({:state}, _form, state) do
    {:reply, Game.build_view(state), state}
  end
end
