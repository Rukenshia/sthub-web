defmodule StHub.Http.Adapter do
  @callback get!(url :: String.t(), headers :: list(), options :: list()) ::
              StHub.Http.Response.t()
end
