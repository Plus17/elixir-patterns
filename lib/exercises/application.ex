defmodule Exercises.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Exercises.Worker.start_link(arg)
      # {Exercises.Worker, arg}
      {Exercises.PeriodictTask, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Exercises.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
