# LocalDevRouter

## What's this?

A simple service that listens for incoming HTTP requests on `127.0.0.1` port `80` and forwards them to a local service.
It's written in `Elixir` using `Plug`, `Bandit` and `Tesla`.

| From                     | To               |
| ------------------------ | ---------------- |
| `my-app.local.api:80`    | `127.0.0.1:5500` |
| `my-app.local.client:80` | `127.0.0.1:4500` |

So if you go to `http://my-app.local.api` it will forward the request to your service running on port `5500` and if you go to `http://my-app.local.client` it will forward the request to your service running on port `4500`.

## Config

Assuming you have configured your hosts file to point `my-app.local.api` and `my-app.local.client` to `127.0.0.1` you just need to map the hostnames to the ports in the `config/dev.exs` file.

```elixir
import Config

config :http, :hosts_map, %{"my-app.local.api" => 5500, "my-app.local.client" => 4500}
```

## Run it

- `mix deps.get`
- `mix run --no-halt`

## Contributing

Just fork it and open a PR and I'll take a look at it as soon as possible.
