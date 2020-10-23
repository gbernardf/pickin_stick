defmodule GameTest do
  use ExUnit.Case

  alias Pickinsticks.Game

  test "new_game returns a new game state" do
    game = Game.new_game()

    assert game.won == false
    assert game.sticks_found == 0
    assert game.player_position == {0,0}
  end

  test "invalid input should not change the state" do
    game = Game.new_game()

    assert ^game = Game.handle_input("invalid", game)
  end

  test "can't go up when y is 0" do
    game = Game.new_game()

    assert ^game = Game.handle_input("k", game)
  end


end

