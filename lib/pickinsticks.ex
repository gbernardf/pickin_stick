defmodule Pickinsticks do

  alias Pickinsticks.TextClient

  defdelegate new_game, to: TextClient.run/0
end
