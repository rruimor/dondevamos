defmodule Dondevamos.KiwiClient do
  use HTTPoison.Base

  # @expected_flight_fields ~w()

  def process_url(url) do
    "https://api.skypicker.com" <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> ProperCase.to_snake_case
  end

  @doc """
    date_from: "dd/mm/YYYY"
  """
  def get_flights(fly_from, to, date_from, date_to, extra_params \\ %{}) do
    params = %{
      fly_from: fly_from,
      to: to,
      date_from: date_from,
      date_to: date_to
    }
    params = Map.merge(params, extra_params) |> prepare_params()
    get!("/flights", [], [params: params]).body["data"]
  end

  def get_flights(params) do
    get!("/flights", [], [params: prepare_params(params)]).body["data"]
  end

  defp prepare_params(params) do
    params
    |> Enum.map(fn({k, v}) -> {Atom.to_string(k), v} end)
    |> Enum.into(%{})
    |> ProperCase.to_camel_case
  end

end
