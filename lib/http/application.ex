# lib/http/application.ex
defmodule Http.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    hosts_map = Application.get_env(:http, :hosts_map)

    children = [
      {Bandit, plug: {Http.Plug, [:hosts_map, hosts_map]}, port: 80}
    ]

    opts = [strategy: :one_for_one, name: Http.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
