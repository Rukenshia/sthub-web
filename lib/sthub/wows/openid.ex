defmodule StHub.Wows.OpenId do
  alias StHub.Wows.Utils

  @application_id Application.get_env(:sthub, StHub.Wows.OpenId)[:application]

  def get_login_url(realm, redirect_uri) do
    "https://api.worldoftanks.#{Utils.realm_to_tld(realm)}/wot/auth/login/?application_id=#{
      @application_id
    }&redirect_uri=#{redirect_uri}"
  end
end
