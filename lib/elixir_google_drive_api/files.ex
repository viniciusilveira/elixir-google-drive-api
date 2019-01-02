defmodule ElixirGoogleDriveApi.Files do
  alias File

  import ElixirGoogleDriveApi.Service

  defp copy_url(file_id), do: "#{api_url(file_id)}/copy"

  defp update_url(file_id), do: api_url(file_id)

  defp export_url(file_id, mime_type), do: "#{api_url(file_id)}/export?mimeType=#{mime_type}"

  defp mount_body(%{title: name}) do
    %{name: name}
    |> Poison.encode!
  end
  defp mount_body(_), do: %{} |> Poison.encode!

  def rename_file(file_id, opts = %{title: _name}, headers) do
    body = mount_body(opts)
    request(:patch, update_url(file_id), headers, body)
  end

  def copy_file(file_id, headers) do
    request(:post, copy_url(file_id), headers)
  end

  def export_file(file_id, headers, mime_type \\ "application/vnd.oasis.opendocument.text", download_dest \\ ".temp/doc_file.doc") do
    case HTTPoison.get export_url(file_id, mime_type), headers do
      {:ok, %HTTPoison.Response{body: "Not Found"}} -> {:error, :not_found}
      {:ok, %HTTPoison.Response{body: response_body}} ->
        if is_binary(response_body) do
          File.write!(download_dest, response_body)
          {:ok, download_dest}
        else
          response_body
          |> Poison.decode!
        end
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end
end
