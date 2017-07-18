defmodule Dondevamos.FlightsAggregator do

  import Dondevamos.Parallel, only: [pmap: 2]

  def find_by_origins_and_date(origins, departure_date) do
    destinations = get_common_destinations(origins)
    IO.inspect destinations
    destinations
    |> pmap(&(find_by_origins_destination_and_date(origins, &1, departure_date)))
    # |> pmap(fn(destination) ->
    #   {destination, (find_by_origins_destination_and_date(origins, destination, departure_date) |> Enum.map(fn(x) -> x["price"] end) |> Statistics.mean) }
    # end)
  end

  def find_flights(origins, date_from, date_to, return_from, return_to) do
    destinations = get_common_destinations(origins)
    IO.inspect destinations
    origins
    |> pmap(&(find_flights(&1, destinations, date_from, date_to, return_from, return_to)))
    |> Enum.map(&(List.flatten/1))
  end

  def find_flights(origin, destinations, date_from, date_to, return_from, return_to) do
    params = %{
      fly_from: origin,
      to: Enum.join(destinations, ","),
      date_from: date_from,
      date_to: date_to,
      return_from: return_from,
      return_to: return_to,
      type_flight: "return",
      oneforcity: 1,
      direct_flights: 1,
    }
    Dondevamos.KiwiClient.get_flights(params)
  end

  def find_by_origins_destination_and_date(origins, destination, departure_date) do
    IO.puts "Calculating from #{Enum.join(origins, ", ")} to #{destination} on #{departure_date}"
    origins
    # |> Enum.flat_map(&(Dondevamos.KiwiClient.get_flights(&1, destination, departure_date, %{limit: 1})))
    |> pmap(&(Dondevamos.KiwiClient.get_flights(&1, destination, departure_date, %{limit: 1})))
    |> Enum.map(&(List.flatten/1))
  end

  def get_common_destinations(origins) do
    origins
    |> Enum.map(&(Dondevamos.IATACodes.get_direct_destinations_from!(&1)))
    # |> pmap(&(Dondevamos.IATACodes.get_direct_destinations_from!(&1)))
    |> Dondevamos.EnumHelper.intersections
  end
end
