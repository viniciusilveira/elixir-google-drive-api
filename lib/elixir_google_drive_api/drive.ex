defmodule ElixirGoogleDriveApi.Drive do
  defp copy_url(file_id), do: "https://www.googleapis.com/drive/v3/files/#{file_id}/copy"

  defp update_url(file_id), do: "https://www.googleapis.com/drive/v2/files/#{file_id}"

  def update_permission_url(file_id, permission_id), do: "https://www.googleapis.com/drive/v2/files/#{file_id}/permissions/#{permission_id}"

  defp mount_body(%{title: title}) do
    %{title: title}
    |> Poison.encode!
  end
  defp mount_body(_), do: %{} |> Poison.encode!

  def rename_file(file_id, opts = %{title: _title}, headers) do
    body = mount_body(opts)

    case HTTPoison.patch update_url(file_id), body, headers do
      {:ok, %HTTPoison.Response{body: response_body}} ->
        response_body
        |> Poison.decode!
      {:error, %HTTPoison.Error{reason: reason}} -> reason
    end
  end

  def copy_file(file_id, headers) do
    case HTTPoison.post copy_url(file_id), "", headers do
      {:ok, %HTTPoison.Response{body: response_body}} ->
        response_body
        |> Poison.decode!
      {:error, %HTTPoison.Error{reason: reason}} -> reason
    end
  end

  def update_permission_file(file_id, headers, permission_id) do
    case HTTPoison.put update_permission_url(file_id, permission_id), "", headers do
      {:ok, %HTTPoison.Response{body: response_body}} ->
        response_body
        |> Poison.decode!
      {:error, %HTTPoison.Error{reason: reason}} -> reason
    end
  end
end
