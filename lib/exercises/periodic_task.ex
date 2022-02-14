defmodule Exercises.PeriodictTask do
  @moduledoc """
  Use a GenServer to execute a periodic job.

  @first_job_time Schedules the time when the task should be executed for the first time
  @next_job_time  Used by schedule next job/0 to schedule the time the job should run after a previous run

  This values can be configured in the same way as enabled?/0.

  When de server is initialized by the Supervisor it schedule the initial execution by @first_job_time value.
  """

  use GenServer

  require Logger

  # 2 hours in ms
  @first_job_time 2 * 60 * 60 * 1000
  # 12 hours in ms
  @next_job_time 12 * 60 * 60 * 1000

  def start_link(_state) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(_) do
    schedule_initial_job()
    {:ok, nil}
  end

  # enabled? \\ true is used only for testing & convenience.
  def perform_job(enabled? \\ true) do
    Logger.debug("Performing PeriodicJob")

    if enabled?(enabled?) do
      IO.puts("Executing preiodic job...")
    else
      Logger.debug("PeriodicJob is disabled")
      IO.puts("Preiodic job is disabled")
      :disabled
    end
  end

  def handle_info(:perform, state) do
    perform_job()
    schedule_next_job()
    {:noreply, state}
  end

  defp schedule_initial_job() do
    Logger.debug("Executing initial job")
    Process.send_after(self(), :perform, @first_job_time)
  end

  defp schedule_next_job() do
    Logger.debug("Scheduling next execution")
    Process.send_after(self(), :perform, @next_job_time)
  end

  @doc """
  This job can be configured with a database value, feature flag, or any other tool to persist the config values.

  enabled? \\ true is used only for testing & convenience in this example.
  """
  @spec enabled?(boolean) :: boolean
  def enabled?(enabled? \\ true) do
    enabled?
  end
end
