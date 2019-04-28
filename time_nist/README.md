# TimeNist

Il DAYTIME è un servizio ormai superato dal NTP ma ancora supportato da molti server NIST.
Lo scopo di questo eservizio è quello di relaizzare un GenServer che una volta sponato fornisca un metodo per
ottenere il DAYTIME corrente in formato stringa.

## Requirements stringenti sul GenServer (TimeNist.Client):
- una sola API deve essere esposta
- è accettabile usare un solo server ("time.nist.gov")
- non è possibile fare più di una richichesta ogni 7 secondi al server NIST
- il GenServer deve usare la funzione TimeNist.request (tramite l'alias @api_nist fornito), dunque per avere il daytime corrente è sufficiente chiamare la @api_nist.request(...)

## Il progetto deve:

- compilare (mix compile)
- mix credo deve riportare zero errori
- i test devono passare (mix test)
- il dylizer è sempre di aiuto (mix dialyzer)

Nota:

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `time_nist` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:time_nist, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/time_nist](https://hexdocs.pm/time_nist).

