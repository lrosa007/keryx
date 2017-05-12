defmodule Keryx.Web.Router do
  use Keryx.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Keryx.Web do
    pipe_through :api

    resources "/organizations", OrganizationController, except: [:edit, :new]
    resources "/users", UserController, except: [:edit, :new]
    resources "/staffs", StaffController, except: [:edit, :new]
    resources "/messages", MessageController, except: [:edit, :new]
    resources "/rooms", RoomController, except: [:edit, :new]
  end
end
