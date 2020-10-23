defmodule Pickinsticks do

  alias Pickinsticks.TextClient

  defdelegate new_game, to: TextClient, as: :run
end
