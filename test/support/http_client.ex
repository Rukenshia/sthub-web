defmodule StHub.Http.MockClient do
  def get!(
        "https://api.worldofwarships.eu/wows/encyclopedia/ships/",
        [],
        [params: %{page_no: page_no}] = options
      ) do
    ship = StHub.Wows.Api.TestData.encyclopedia_ships() |> Map.get(:"3761190896")

    %StHub.Http.Response{
      status_code: 200,
      body:
        Jason.encode!(%{
          status: "ok",
          meta: %{
            page: 2,
            page_total: 2
          },
          data: %{
            "#{ship[:ship_id]}": ship
          }
        })
    }
  end

  def get!(
        "https://api.worldofwarships.eu/wows/encyclopedia/ships/",
        headers \\ [],
        options \\ []
      ) do
    ship = StHub.Wows.Api.TestData.encyclopedia_ships() |> Map.get(:"3763255248")

    %StHub.Http.Response{
      status_code: 200,
      body:
        Jason.encode!(%{
          status: "ok",
          meta: %{
            page: 1,
            page_total: 2
          },
          data: %{
            "#{ship[:ship_id]}": ship
          }
        })
    }
  end
end
