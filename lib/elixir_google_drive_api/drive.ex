defmodule ElixirGoogleDriveApi.Drive do
  alias ElixirGoogleDriveApi.Oauth

  @headers ["Content-Type": "application/json", "Authorization": "Bearer #{Oauth.token}"]

  defp copy_url(file_id), do: "https://www.googleapis.com/drive/v3/files/#{file_id}/copy"

  defp update_url(file_id), do: "https://www.googleapis.com/drive/v2/files/#{file_id}"

  defp mount_body(%{title: title}) do
    %{ title: title}
    |> Poison.encode!
  end
  defp mount_body(_), do: nil

  def update_file(file_id, opts \\%{}) do
    body = mount_body(opts)

    case HTTPoison.patch update_url(file_id), body, @headers do
      {:ok, %HTTPoison.Response{status_code: 200, body: response_body}} -> response_body
      {:error, %HTTPoison.Error{reason: reason}} -> reason
    end
  end

  def copy_file(file_id, opts \\ %{}) do
    case HTTPoison.post copy_url(file_id), "", @headers do
      {:ok, %HTTPoison.Response{status_code: 200, body: response_body}} ->
        body =
          response_body
          |> Poison.decode!
        update_file(body["id"], opts)
        body["id"]
      {:error, %HTTPoison.Error{reason: reason}} -> reason
    end
  end
end
