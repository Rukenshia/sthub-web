defmodule StHub.Wows.ApiTest do
  use StHub.DataCase

  alias StHub.Wows.Api

  test "test get_warships/0 returns a map of all ships returned by the api" do
    map = Api.get_warships()

    assert Map.has_key?(map, "3763255248")
    assert Map.has_key?(map, "3763255248")
  end
end
