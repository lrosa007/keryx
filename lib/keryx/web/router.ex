defmodule Keryx.Web.Router do
  use Keryx.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Keryx.Web do
    pipe_through :api
  end
end
