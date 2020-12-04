defmodule Pickinsticks do
  alias Pickinsticks.Game

  defdelegate new_game, to: Game
end
