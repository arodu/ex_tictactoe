defmodule TictactoeWeb.TictactoeLive do
  use Phoenix.LiveView

  require Logger


  def mount(_session, socket) do
    socket = assign(socket, :board, %{} )
    socket = assign(socket, :player, "X" )
    socket = assign(socket, :flash, "" )
    socket = assign(socket, :pause, false )
    {:ok, socket}
  end


  def render(assigns) do
    ~L"""
    <label>Next player <%= @player %></label>
    <div class="board">
      <div class="square" phx-value-id='0' phx-click="move"><%= @board["0"] %></div>
      <div class="square" phx-value-id='1' phx-click="move"><%= @board["1"] %></div>
      <div class="square" phx-value-id='2' phx-click="move"><%= @board["2"] %></div>
      <div class="square" phx-value-id='3' phx-click="move"><%= @board["3"] %></div>
      <div class="square" phx-value-id='4' phx-click="move"><%= @board["4"] %></div>
      <div class="square" phx-value-id='5' phx-click="move"><%= @board["5"] %></div>
      <div class="square" phx-value-id='6' phx-click="move"><%= @board["6"] %></div>
      <div class="square" phx-value-id='7' phx-click="move"><%= @board["7"] %></div>
      <div class="square" phx-value-id='8' phx-click="move"><%= @board["8"] %></div>
    </div>
    <label><%= @flash %></label>
    <br/>
    <button phx-click="reset">Reset</button>
    """
  end


  def handle_event("move", event, socket) do
    id = event["id"]
    player = socket.assigns.player
    board = socket.assigns.board
    pause = socket.assigns.pause

    {new_board, new_player, pause} = move(id, board, player, pause)

    flash = case pause do
      true -> "Winner player #{player}"
      false -> ""
    end
    
    socket = assign(socket, :flash, flash)
    socket = assign(socket, :pause, pause)
    socket = assign(socket, :board, new_board)
    socket = assign(socket, :player, new_player)

    {:noreply, socket}
  end


  def handle_event("reset", event, socket) do
    socket = assign(socket, :board, %{} )
    # socket = assign(socket, :player, "X" )
    socket = assign(socket, :flash, "" )
    socket = assign(socket, :pause, false )
    {:noreply, socket}
  end


  def move(id, board, player, pause) when pause == false do
    
    case Map.get(board, id) do
       nil -> 
            board = Map.put(board, id, player)
            case checkWinner(board) do
              true -> {board, player, true}
              false -> {board, changePlayer(player), false}
            end

       _ -> {board, player, false}
    end
    
  end


  def move(id, board, player, pause) do
    {board, player, pause}
  end


  defp changePlayer(player) do
    case player do
      "X" -> "O"
      "O" -> "X"
    end
  end


  defp checkWinner(board) do
    to_check = [
      {"0","1","2"},
      {"3","4","5"},
      {"6","7","8"},
      {"0","3","6"},
      {"1","4","7"},
      {"2","5","8"},
      {"0","4","8"},
      {"2","4","6"},
    ]

    Enum.any?(to_check, fn(x) ->
      {x1, x2, x3} = x
      (Map.get(board, x1)!=nil and Map.get(board, x1)==Map.get(board, x2)  and Map.get(board, x2)==Map.get(board, x3))
    end)
  end

end
