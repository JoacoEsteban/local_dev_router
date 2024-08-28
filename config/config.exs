import Config

config :logger, level: :debug
config :tesla, adapter: {Tesla.Adapter.Hackney, [recv_timeout: 30_000]}

# Configure by copying and modifying this line in config/dev.exs
config :http, :hosts_map, %{"example.local" => 3000}

conf_file = Path.expand("#{config_env()}.exs", "config")

if File.exists?(conf_file) do
  IO.puts("Importing config from " <> conf_file)
  import_config conf_file
end
