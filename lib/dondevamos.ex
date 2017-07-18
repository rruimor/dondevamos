defmodule Dondevamos do
  @moduledoc """
  Documentation for Dondevamos.
  """

  def iata_codes_api_key, do: Application.get_env :dondevamos, :iata_codes_api_key
end
