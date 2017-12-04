defmodule ElixirGoogleDriveApi.Drive do
  alias File

  defp copy_url(file_id), do: "https://www.googleapis.com/drive/v3/files/#{file_id}/copy"

  defp update_url(file_id), do: "https://www.googleapis.com/drive/v2/files/#{file_id}"

  defp export_url(file_id, mime_type), do:
    "https://www.googleapis.com/drive/v3/files/#{file_id}/export?mimeType=#{mime_type}"

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

  def export_file(file_id, headers, mime_type \\ "application/vnd.oasis.opendocument.text", download_dest \\ ".temp/doc_file.doc") do
    case HTTPoison.get export_url(file_id, mime_type), headers do
      {:ok, %HTTPoison.Response{body: response_body}} ->
        if(!String.valid?(response_body)) do
          File.write!(download_dest, response_body)
          {:ok, download_dest}
        else
          response_body
          |> Poison.decode!
        end
      {:error, %HTTPoison.Error{reason: reason}} -> reason
    end
  end
end
