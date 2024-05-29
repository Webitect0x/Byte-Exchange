defmodule ByteExchangeWeb.Navbar do
  use Phoenix.Component

  alias Phoenix.LiveView.JS

  import ByteExchangeWeb.CoreComponents

  def navbar(assigns) do
    ~H"""
    <nav class="border border-slate-800 shadow-xl m-2 p-4 rounded-lg flex items-center gap-4 justify-between">
      <div>
        <.link href="/home">Byte Exchange</.link>
      </div>
      <div class="flex gap-4">
        <%= if @current_user do %>
          <div class="text-[0.8125rem] leading-6 ">
            <div class="flex gap-5 items-center">
              <div class="text-s space-x-3">
                <.icon name="hero-envelope" />
                <.icon name="hero-bell-alert" />
              </div>
              <.button phx-click={JS.toggle(to: "#user-menu")}>
                <.icon name="hero-user-circle" />
                <%= @current_user.email %>
                <.icon class="ml-4" name="hero-chevron-down" />
              </.button>
            </div>
          </div>
          <ul
            id="user-menu"
            hidden
            class="absolute mt-14 right-5 p-4 shadow-xl rounded-b-xl z-10 bg-slate-950 w-[17rem]"
          >
            <li>
              <.link
                href="/users/settings"
                class="text-[0.8125rem] leading-6 font-semibold hover:text-zinc-700"
              >
                Settings
              </.link>
            </li>
            <li>
              <.link
                href="/users/log_out"
                method="delete"
                class="text-[0.8125rem] leading-6 font-semibold hover:text-zinc-700"
              >
                Log out
              </.link>
            </li>
          </ul>
        <% else %>
          <div>
            <.link
              href="/users/register"
              class="text-[0.8125rem] leading-6 font-semibold hover:text-zinc-700"
            >
              Register
            </.link>

            <.link
              href="/users/log_in"
              class="text-[0.8125rem] leading-6 font-semibold hover:text-zinc-700"
            >
              Log in
            </.link>
          </div>
        <% end %>
      </div>
    </nav>
    """
  end
end
