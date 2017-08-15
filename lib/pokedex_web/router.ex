defmodule PokedexWeb.Router do
  use PokedexWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PokedexWeb do
    pipe_through :api
  end
end
