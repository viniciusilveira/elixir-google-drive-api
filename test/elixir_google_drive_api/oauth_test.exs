defmodule ElixirGoogleDriveApi.OauthTest do
  use ExUnit.Case, async: true

  alias ElixirGoogleDriveApi.Oauth

  import Mock

  describe "token/0" do
    @token "1pdACPWuN4BSKgD4Yjv3IpJEbubIiC0ON9rTZWIhDsPE"
    @auth_scope "https://www.googleapis.com/auth/drive"
    test "get new token" do
      with_mock Goth.Token, [for_scope: fn(@auth_scope) -> {:ok, %{token: @token}} end] do
        assert @token == Oauth.token
      end
    end
  end
end
