defmodule Http.Proxy do
  require Logger
  use Tesla
  import Plug.Conn

  def proxy(conn, port) do
    port = Integer.to_string(port)
    url = "http://127.0.0.1:#{port}#{conn.request_path <> "?" <> conn.query_string}"

    {:ok,
     %{
       body: body,
       headers: headers,
       status: status
       #  method: method,
       #  opts: opts,
       #  query: query,
       #  url: url
     }} =
      Tesla.request(
        method: conn.method,
        url: url,
        headers: conn.req_headers
        # opts: [adapter: [response: :stream]]
      )

    conn
    |> put_resp_headers(headers)
    |> send_resp(status, body)
  end

  defp put_resp_headers(conn, headers) do
    Enum.reduce(headers, conn, fn {key, value}, acc ->
      case key do
        "transfer-encoding" ->
          # TODO fix chunked responses
          acc

        _ ->
          put_resp_header(acc, key, value)
      end
    end)
  end
end
