defmodule Pokedex.Resolver do
  defmacro __using__(_) do
    quote do
      alias Pokedex.Repo
      import Ecto.Query
    end
  end
end
