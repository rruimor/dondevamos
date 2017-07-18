defmodule Dondevamos do
  @moduledoc """
  Documentation for Dondevamos.
  """

  alias Dondevamos.FlightsAggregator

  def iata_codes_api_key, do: Application.get_env :dondevamos, :iata_codes_api_key

  @doc """
  Return the list of common destinations given a list of airport codes.

  ## Examples

    iex> ~w(AGP AMS MAD SXF POZ) |> Dondevamos.get_common_destinations()

  """
  defdelegate get_common_destinations(origins), to: FlightsAggregator

  @doc """
  It returns a list of available return flights for the common destinations
  given a list of origins and departure and return dates.

  Dates must be specified in "dd/mm/yy" format.

  ## Examples

    iex> Dondevamos.find_flights(~w(AGP AMS SXF), "23/11/2017",  "26/11/2017")

  """
  defdelegate find_flights(origins, departure_date, return_date), to: FlightsAggregator

end
