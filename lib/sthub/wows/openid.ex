defmodule StHub.Wows.OpenId do
  @application_id Application.get_env(:sthub, StHub.Wows.OpenId)[:application]

  defp realm_to_tld(realm) do
    case realm do
      "na" ->
        "com"
      v ->
        v
    end
  end

  def get_login_url(realm, redirect_uri) do
    "https://api.worldoftanks.#{realm_to_tld(realm)}/wot/auth/login/?application_id=#{@application_id}&redirect_uri=#{redirect_uri}"
  end
end
