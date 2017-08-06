defmodule Attend.FakeEmailer do

  def start_link do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def send_email(args) do
    Agent.update(__MODULE__, fn emails ->
      [ args | emails ]
    end)
  end

  def get_emails do
    Agent.get(__MODULE__, fn emails -> emails end)
  end

end
