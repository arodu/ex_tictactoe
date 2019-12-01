defmodule TictactoeWeb.CounterLive do
  use Phoenix.LiveView

  require Logger

  def mount(_session, socket) do
    socket = assign(socket, :counter, 0 )
    {:ok, socket}
  end

  def render(assigns) do

    ~L"""
    <label>Counter: <%= @counter %></label>
    <button id="7" phx-click="incr">+</button>
    """
  end

  def handle_event("incr", event, socket) do

    #socket |> IO.inspect

    socket = update(socket, :counter, &(&1 + 1))
    {:noreply, socket}
  end

end