defmodule Stacker.Stash do
  use GenServer

  def start_link state do
    GenServer.start_link(__MODULE__, state)
  end

  def get stash_id do
    GenServer.call(stash_id, :get)
  end

  def set stash_id, value do
    GenServer.cast(stash_id, {:set, value})
  end

  # Internal GenServer
  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:set, value}, _previous_state) do
    {:noreply, value}
  end

  def init _state do
    IO.puts "Initializing the stack"
    {:ok, []}
  end
end
