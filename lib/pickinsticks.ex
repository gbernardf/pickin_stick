defmodule Pickinsticks do
  alias Pickinsticks.{Game, Server}

  def new_game(stick_count \\ 1) do
    Server.start_link(stick_count)
  end

  def make_move(game_pid, direction) do
    GenServer.call(game_pid, {:make_move, direction})
  end

  def state(game_pid) do
    GenServer.call(game_pid, {:state})
  end
end
