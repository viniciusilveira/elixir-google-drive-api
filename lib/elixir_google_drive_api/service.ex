defmodule ElixirGoogleDriveApi.Service do

  def api_url(file_id), do:
    "https://www.googleapis.com/drive/v3/files/#{file_id}"

  def request(method, url, headers, body \\ "") do
    case HTTPoison.request(method, url, body, headers) do
      {:ok, %HTTPoison.Response{body: response_body}} ->
        response = response_body
        |> Poison.decode!
        {:ok, response}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end
end
