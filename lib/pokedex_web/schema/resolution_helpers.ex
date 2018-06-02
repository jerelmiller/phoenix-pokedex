defmodule PokedexWeb.Schema.ResolutionHelpers do
  import Absinthe.Resolution.Helpers, only: [on_load: 2]

  def load_related_field(source, relationship, field) do
    fn parent, args, %{context: %{loader: loader}} ->
      loader
      |> Dataloader.load(source, {relationship, args}, parent)
      |> on_load(fn loader ->
        data =
          loader
          |> Dataloader.get(source, {relationship, args}, parent)
          |> Map.fetch!(field)

        {:ok, data}
      end)
    end
  end
end
