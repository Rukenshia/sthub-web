defmodule StHub.Http.Response do
  defstruct body: nil, status_code: nil

  @type t :: %__MODULE__{
          status_code: integer,
          body: term
        }
end
