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
    {view, state} = Game.make_move(state, direction)
    # replies to caller. 2d arg is response, 3rd is new state
    # call with GenServer.call(pid, {:make_move, direction})
    # TODO: make an update so the server keeps its state private
    # and only returns enough info for the game to be displayed
    {:reply, view, state}
  end
end
