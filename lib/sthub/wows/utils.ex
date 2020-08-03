defmodule StHub.Wows.Utils do
  def realm_to_tld(realm) do
    case realm do
      "na" ->
        "com"

      v ->
        v
    end
  end
end
