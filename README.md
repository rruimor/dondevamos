# Dondevamos

Simple Elixir app that uses [IATACodes API](http://iatacodes.org/) and [Kiwi API](http://docs.skypickerpublicapi.apiary.io/#) to aggregate flights searches

## Installation

First, add Dondevamos to your `mix.exs` dependencies:

```elixir
def deps do
  [{:dondevamos, "~> 0.1.0"}]
end
```

and run `$ mix deps.get`

You will also need to get an [IATACodes API key](http://iatacodes.org/), and place  it in your `config/secret.exs` file (see config/secrets.exs.example).

## Usage

You can get the all common connections to the list of airport codes provided by
```elixir
~w(AGP AMS MAD SXF POZ) |>
Dondevamos.get_common_destinations()
```

If you want to find the possible destinations given a list of origins and the
departure and return dates:
```elixir
~w(AGP AMS MAD SXF POZ) |>
Dondevamos.find_flights("23/11/2017", "27/11/2017")
```
