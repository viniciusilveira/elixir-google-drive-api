defmodule ElixirGoogleDriveApi.Drive do
  alias File

  defp api_url(file_id), do:
    "https://www.googleapis.com/drive/v3/files/#{file_id}"

  defp copy_url(file_id), do: "#{api_url(file_id)}/copy"

  defp update_url(file_id), do: api_url(file_id)

  defp export_url(file_id, mime_type), do: "#{api_url(file_id)}/export?mimeType=#{mime_type}"

  defp update_permission_url(file_id, permission_id), do:
    "#{api_url(file_id)}/permissions/#{permission_id}"

  defp insert_permission_url(file_id), do: "#{api_url(file_id)}/permissions"

  defp mount_body(%{title: title}) do
    %{title: title}
    |> Poison.encode!
  end
  defp mount_body(_), do: %{} |> Poison.encode!

  def rename_file(file_id, opts = %{title: _title}, headers) do
    body = mount_body(opts)
    request(:patch, update_url(file_id), headers, body)
  end

  def copy_file(file_id, headers) do
    request(:post, copy_url(file_id), headers)
  end

  def export_file(file_id, headers, mime_type \\ "application/vnd.oasis.opendocument.text", download_dest \\ ".temp/doc_file.doc") do
    case HTTPoison.get export_url(file_id, mime_type), headers do
      {:ok, %HTTPoison.Response{body: response_body}} ->
        if String.valid?(response_body) do
          response_body
          |> Poison.decode!
        else
          File.write!(download_dest, response_body)
          {:ok, download_dest}
        end
      {:error, %HTTPoison.Error{reason: reason}} -> reason
    end
  end

  def update_permission_file(file_id, headers, permission_id) do
    request(:put, update_permission_url(file_id, permission_id), headers)
  end

  def insert_permission_file(file_id, headers, body \\ "") do
    request(:post, insert_permission_url(file_id), headers, body)
  end

  def share_file_with_link(file_id, headers) do
    body =
      %{
        role: "writer",
        type: "anyone"
      }
      |> Poison.encode!

    insert_permission_file(file_id, headers, body)
  end

  defp request(method, url, headers, body \\ "") do
    case HTTPoison.request(method, url, body, headers) do
      {:ok, %HTTPoison.Response{body: response_body}} ->
        response_body
        |> Poison.decode!
      {:error, %HTTPoison.Error{reason: reason}} -> reason
    end
  end
end
