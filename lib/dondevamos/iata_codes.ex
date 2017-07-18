defmodule Dondevamos.IATACodes do
  use HTTPoison.Base

  def process_url(url) do
    "http://iatacodes.org/api/v6" <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
  end

  def get_direct_destinations_from!(departure) do
    get!("/routes", [], [{:params, get_params(departure)}]).body["response"]
    |> Enum.map(fn %{"arrival" => destination} -> destination end)
    |> Enum.uniq
    |> Enum.sort
  end

  defp get_params(departure) do
    [
      {:api_key, Dondevamos.iata_codes_api_key()},
      {:departure, departure}
    ]
  end
end
