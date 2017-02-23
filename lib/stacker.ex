defmodule Stacker do
  use Application
  use Supervisor

  def start(_type, empty_stack) do
    # Start Stash
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [empty_stack])

    # Start the stash, then initialize the sub supervisor with it
    {:ok, stash_id} = Supervisor.start_child(sup, worker(Stacker.Stash, [empty_stack]))
    Supervisor.start_child(sup, worker(Stacker.SubSupervisor, [stash_id]))

    result
  end

  def init(_) do
    supervise([], strategy: :one_for_one)
  end
end
