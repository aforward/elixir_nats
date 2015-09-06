defmodule Nats.Connection do
  @moduledoc ~S"""
  This module contains functions to connect to a NATS server.

  The defaults are oriented around getting new people to NATS
  up and running quickly.  Please overwrite for your production
  environment.
  """

  @default_verbose false
  @default_pedantic false

  @doc """
  Returns the current version of this client libary.

  # Examples
    Connection.version #=> "0.0.1"
  """
  def version(), do: Nats.Mixfile.version

  @doc """
  Returns a JSON representation of the NATS options

  The following configurations should not be changed,
  but could be if you know what you are doing

    * `:lang`     - The client language, which is "elixir"
    * `:version`  - The client version, which is found in mix.exs

  Available configurations that you can overwrite:

    * `:verbose`  - Do you want verbose outputs?  Defaults to false
    * `:pedantic` - Do you have a schtickler or not? Defaults to false
    * `:user`     - The user that is accessing the NATS server.
                    This is omitted by default
    * `:password` - The user's password for accessing the NATS server.
                    This is omitted by default

  ## Examples

    Connection.configs #=> "{\"lang\":\"elixir\",\"version\":\"0.0.1\",\"verbose\":false,\"pedantic\":false}"

    Connection.configs([verbose: true, user: \"aforward\"]) #=> "{\"lang\":\"elixir\",\"version\":\"0.0.1\",\"verbose\":true,\"pedantic\":false,\"user\":\"aforward\"}"
  """
  def configs(), do: configs([])
  def configs(opts) do
    default_options
    |> Keyword.merge(opts)
    |> encode
  end

  @doc """
  Returns the NATS server URL

  The following options can be overwritten
    * `:host`     - Which IP or Hostname to connect to (default: localhost)
    * `:port`     - On which port (default: 4222)

  ## Examples

    Connection.url #=> "tcp://localhost:4222"
    Connection.url([host: "myhost", port: 3333]) #=> "tcp://myhost:3333"
  """
  def url(), do: url([])
  def url(opts), do: default_url |> Keyword.merge(opts) |> _url
  defp _url(opts), do: "tcp://#{opts[:host]}:#{opts[:port]}"

  defp encode(answer), do: JSON.encode!(answer)
  defp default_options do
    [lang: "elixir",
     version: version,
     verbose: @default_verbose,
     pedantic: @default_pedantic]
  end

  defp default_url, do: [host: "localhost", port: 4222]


end
