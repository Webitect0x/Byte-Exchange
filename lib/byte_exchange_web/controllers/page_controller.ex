defmodule ByteExchangeWeb.PageController do
  use ByteExchangeWeb, :controller

  def home(conn, _params) do
    redirect(conn, to: "/home")
  end
end
