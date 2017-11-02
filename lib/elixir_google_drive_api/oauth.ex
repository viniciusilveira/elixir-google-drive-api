defmodule ElixirGoogleDriveApi.Oauth do
  @auth_scope "https://www.googleapis.com/auth/drive"

  def token do
    {:ok, %{token: token}} = Goth.Token.for_scope(@auth_scope)
    token
  end
end
