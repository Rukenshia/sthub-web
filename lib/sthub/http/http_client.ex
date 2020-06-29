defmodule StHub.Http.Client do
  @behaviour StHub.Http.Adapter

  def get!(url, headers \\ [], options \\ []) do
    %{status_code: status_code, body: body} = HTTPoison.get!(url, headers, options)

    %StHub.Http.Response{
      status_code: status_code,
      body: body
    }
  end
end
