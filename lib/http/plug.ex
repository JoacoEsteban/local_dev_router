defmodule Http.Plug do
  @behaviour Plug
  import Plug.Conn
  require Logger

  def init(opts) do
    opts
  end

  def call(conn, [:hosts_map, hosts_map]) do
    [host] =
      conn
      |> Plug.Conn.get_req_header("host")

    Logger.info("Proxying " <> host <> conn.request_path <> "?" <> conn.query_string)

    case Map.get(hosts_map, host) do
      nil ->
        resp(conn, 404, "Unknown host")

      port ->
        Http.Proxy.proxy(conn, port)
    end
  end
end
