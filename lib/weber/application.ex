defmodule Weber.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Weber.Entry
      # Starts a worker by calling: Weber.Worker.start_link(arg)
      # {Weber.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Weber.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
