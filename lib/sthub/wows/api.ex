defmodule StHub.Wows.Api do
  require Logger

  @application_id Application.get_env(:sthub, StHub.Wows.Api)[:application]
  @http_client Application.get_env(:sthub, :http_adapter)

  def get_warships(page, ships) do
    %{status_code: 200} =
      response =
      @http_client.get!("https://api.worldofwarships.eu/wows/encyclopedia/ships/", [],
        params: %{application_id: @application_id, page_no: page}
      )

    %{"status" => "ok"} = data = Jason.decode!(response.body)

    new_ships = data["data"]

    ships =
      ships
      |> Map.merge(new_ships)

    if data["meta"]["page"] < data["meta"]["page_total"] do
      get_warships(data["meta"]["page"] + 1, ships)
    else
      ships
    end
  end

  def get_warships() do
    %{status_code: 200} =
      response =
      @http_client.get!("https://api.worldofwarships.eu/wows/encyclopedia/ships/", [],
        params: %{application_id: @application_id}
      )

    %{"status" => "ok"} = data = Jason.decode!(response.body)

    ships = data["data"]

    if data["meta"]["page"] < data["meta"]["page_total"] do
      get_warships(data["meta"]["page"] + 1, ships)
    else
      ships
    end
  end

  def get_game_version() do
    ConCache.get_or_store(:wows_api, :game_version, fn ->
      %{status_code: 200} =
        response =
        @http_client.get!("https://api.worldofwarships.eu/wows/encyclopedia/info/", [],
          params: %{application_id: @application_id, fields: "game_version"}
        )

      %{"status" => "ok"} = data = Jason.decode!(response.body)

      %ConCache.Item{ttl: :timer.hours(1), value: data["data"]["game_version"]}
    end)
  end
end
