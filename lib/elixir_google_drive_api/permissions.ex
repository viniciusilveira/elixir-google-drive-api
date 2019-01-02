defmodule ElixirGoogleDriveApi.Permissions do
  alias File

  import ElixirGoogleDriveApi.Service

  defp update_permission_url(file_id, permission_id), do:
    "#{api_url(file_id)}/permissions/#{permission_id}"

  defp insert_permission_url(file_id), do: "#{api_url(file_id)}/permissions"

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
end
