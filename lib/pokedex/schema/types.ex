defmodule Pokedex.Schema.Types do
  use Absinthe.Schema.Notation

  object :pokemon do
    field :id, :id
    field :name, :string
    field :number, :string
  end
end
