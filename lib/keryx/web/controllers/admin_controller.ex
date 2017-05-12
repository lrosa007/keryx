defmodule Keryx.Web.AdminController do
  use Keryx.Web, :controller

  alias Keryx.Staff
  alias Keryx.Staff.Admin

  action_fallback Keryx.Web.FallbackController

  def index(conn, _params) do
    admins = Staff.list_admins()
    render(conn, "index.json", admins: admins)
  end

  def create(conn, %{"admin" => admin_params}) do
    with {:ok, %Admin{} = admin} <- Staff.create_admin(admin_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", admin_path(conn, :show, admin))
      |> render("show.json", admin: admin)
    end
  end

  def show(conn, %{"id" => id}) do
    admin = Staff.get_admin!(id)
    render(conn, "show.json", admin: admin)
  end

  def update(conn, %{"id" => id, "admin" => admin_params}) do
    admin = Staff.get_admin!(id)

    with {:ok, %Admin{} = admin} <- Staff.update_admin(admin, admin_params) do
      render(conn, "show.json", admin: admin)
    end
  end

  def delete(conn, %{"id" => id}) do
    admin = Staff.get_admin!(id)
    with {:ok, %Admin{}} <- Staff.delete_admin(admin) do
      send_resp(conn, :no_content, "")
    end
  end
end
