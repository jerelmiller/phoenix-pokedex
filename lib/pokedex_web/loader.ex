defmodule PokedexWeb.Loader do
  alias Pokedex.GenericLoader

  def define(context) do
    Dataloader.new()
    |> Dataloader.add_source(:move_methods, GenericLoader.source(context))
    |> Dataloader.add_source(:moves, GenericLoader.source(context))
    |> Dataloader.add_source(:strengths, GenericLoader.source(context))
  end
end
