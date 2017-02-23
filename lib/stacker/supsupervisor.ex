defmodule Stacker.SubSupervisor do
  use Supervisor

  def start_link stash_id do
    {:ok, _pid} = Supervisor.start_link(__MODULE__, stash_id)
  end

  def init stash_id do
    children = [
      worker(Stacker.Server, [stash_id])
    ]
    supervise(children, strategy: :one_for_one)
  end
end
