defmodule Keryx.Web.StaffView do
  use Keryx.Web, :view
  alias Keryx.Web.StaffView

  def render("index.json", %{staffs: staffs}) do
    %{data: render_many(staffs, StaffView, "staff.json")}
  end

  def render("show.json", %{staff: staff}) do
    %{data: render_one(staff, StaffView, "staff.json")}
  end

  def render("staff.json", %{staff: staff}) do
    %{id: staff.id,
      name: staff.name}
  end
end
