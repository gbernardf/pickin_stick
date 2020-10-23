defmodule Pickinsticks.TextClient do

  alias Pickinsticks.Game

  def run(), do: Game.new_game |> run

  def run(%Game{won: true} = state) do
    clear_screen()
    draw_grid(state)
    print_victory_and_exit(state.sticks_found)
  end

  def run(%Game{won: false} = state) do
    clear_screen()
    draw_grid(state)
    IO.gets("Where do you move [h,j,k,l] ? : ")
    |> String.trim
    |> handle_input(state)
  end

  def clear_screen(), do: IO.write IO.ANSI.reset() <> IO.ANSI.clear() <> IO.ANSI.home()
  def draw_grid(state) do
    IO.puts "\n*****************************"
    draw(state)
    IO.puts "*****************************\n"
  end

  def handle_input("q", _), do: "User stopped the game."
  def handle_input(input, state) do
    input
    |> Game.handle_input(state)
    |> run
  end

  def draw(state) do
    build_grid(state.world_bounds)
    |> place_sticks(state.sticks)
    |> place_player(state.player_position)
    |> render(state.world_bounds)
  end

  def build_grid({width, height}) do
    0..height |> Enum.reduce(%{}, fn x, acc -> 0..width |> Enum.reduce(acc, fn y, acc -> Map.put(acc, {x,y}, ".") end) end )
  end

  def place_sticks(grid, sticks) do
    sticks
    |> Enum.map(&patch_position/1)
    |> Enum.reduce(grid, fn pos, acc -> %{ acc | pos => "/" } end)
  end

  def place_player(grid, player_position) do
    %{ grid | patch_position(player_position) => "@" }
  end

  def render(grid, {width,_}) do
    grid
    |> Enum.to_list
    |> Enum.sort(fn({key1, _}, {key2, _}) -> key1 < key2 end)
    |> Enum.map(fn {_,x} -> x end)
    |> Enum.chunk_every(width + 1)
    |> Enum.map(fn xs -> Enum.join(xs) end)
    |> Enum.map(fn x -> "     " <> x end)
    |> Enum.join("\n")
    |> IO.puts
  end

  def print_victory_and_exit(sticks_found) do
    IO.puts "\n*****************************"
    IO.puts "       CONGRATULATIONS !"
    IO.puts "           YOU WON"
    IO.puts "       Sticks found: #{sticks_found}"
    IO.puts "*****************************\n"
    exit(:normal)
  end

  def patch_position({x,y}), do: {y,x}
end
