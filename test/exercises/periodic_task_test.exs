defmodule Exercises.PeriodictTaskTest do
	use ExUnit.Case

	alias Exercises.PeriodictTask

  test "perform task if job is enabled" do
    PeriodictTask.start_link(:test_task)

    assert PeriodictTask.perform_job(true) == :ok
  end

  test "perform task return disabled" do
    PeriodictTask.start_link(:test_task)

    assert PeriodictTask.perform_job(false) == :disabled
  end
end
