defmodule Dondevamos.FlightsAggregator do

  import Dondevamos.Parallel, only: [pmap: 2]

  def find_flights(origins, departure_date, return_date) do
    destinations = get_common_destinations(origins)
    origins
    |> pmap(&(find_flights(&1, destinations, departure_date, return_date)))
    |> Enum.map(&(List.flatten/1))
  end

  def get_common_destinations(origins) do
    origins
    |> Enum.map(&(Dondevamos.IATACodes.get_direct_destinations_from!(&1)))
    |> Dondevamos.EnumHelper.intersections
  end

  defp find_flights(origin, destinations, departure_date, return_date) do
    params = %{
      fly_from: origin,
      to: Enum.join(destinations, ","),
      date_from: departure_date,
      date_to: departure_date,
      return_from: return_date,
      return_to: return_date,
      type_flight: "return",
      oneforcity: 1,
      direct_flights: 1,
    }
    Dondevamos.KiwiClient.get_flights(params)
  end

end
