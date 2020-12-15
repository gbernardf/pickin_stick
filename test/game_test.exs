defmodule GameTest do
  use ExUnit.Case, async: true

  alias Pickinsticks.Game
  alias Pickinsticks.Position, as: Pos

  test "new_game returns a new game state" do
    game = Game.new_game(1)

    assert game.won == false
    assert game.sticks_found == 0
    assert game.player_position == Pos.at(1, 1)
  end

  test "invalid input should not change the state" do
    game = Game.new_game(1)

    assert {_, ^game} = Game.make_move(game, :lol)
  end

  test "can't go up when y is 0" do
    game = Game.new_game(1)

    assert {_, ^game} = Game.make_move(game, :up)
  end
end
