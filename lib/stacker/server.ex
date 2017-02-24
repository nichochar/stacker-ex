defmodule Stacker.Server do
  use GenServer

  @vsn "0" # Version the data (the state)

  def start_link stash_id do
    GenServer.start_link(__MODULE__, stash_id, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push value do
    GenServer.cast(__MODULE__, {:push, value})
  end

  def handle_call(:pop, _from, {stash_id, [head | tail]}) do
    {:reply, head, {stash_id, tail}}
  end

  def handle_call(:pop, _from, {stash_id, []}) do
    {:reply, nil, {stash_id, []}}
  end

  def handle_cast({:push, value}, {stash_id, state}) do
    {:noreply, {stash_id, [value | state]}}
  end

  def init stash_id do
    IO.puts "Initializing the Server"
    result = Stacker.Stash.get(stash_id)
    IO.puts result
    {:ok, {stash_id, result}}
  end

  def terminate _reason, {stash_id, stash_value} do
    Stacker.Stash.set stash_id, stash_value
  end
end
