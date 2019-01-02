defmodule ElixirGoogleDriveApi.Permissions do
  @moduledoc """
  This module for managing files permissions
  """
  alias File

  import ElixirGoogleDriveApi.Service

  defp update_permission_url(file_id, permission_id), do:
    "#{api_url(file_id)}/permissions/#{permission_id}"

  defp insert_permission_url(file_id), do: "#{api_url(file_id)}/permissions"

  @doc"""
  Update permission for one file

  ## Examples

    iex> update_permission_file(
      "12BbXrA627UzddYJWK3qww1yvWl_aKuvEeSv-qkPtz68",
      [
        "Content-Type": "application/json",
        "Authorization": "Bearer ya29.Glv3BDWcd49KSskqCfSKgd_DURWF7VAbtr_b_tLneBgJZE-TCkZgwauSBIM1rf_tt344YaIgP_na-Xt5U0azKjSFTmt9_YwgfweC_b_ndyZ6Nz1PtdHXaFpOO50C"
      ],
      writer
    )
    {:ok, response_body}

  """
  def update_permission_file(file_id, headers, permission_id) do
    request(:put, update_permission_url(file_id, permission_id), headers)
  end

  @doc"""
  Insert new file permission

  ## Examples

    iex> insert_permission_file(
      "12BbXrA627UzddYJWK3qww1yvWl_aKuvEeSv-qkPtz68",
      [
        "Content-Type": "application/json",
        "Authorization": "Bearer ya29.Glv3BDWcd49KSskqCfSKgd_DURWF7VAbtr_b_tLneBgJZE-TCkZgwauSBIM1rf_tt344YaIgP_na-Xt5U0azKjSFTmt9_YwgfweC_b_ndyZ6Nz1PtdHXaFpOO50C"
      ],
      "{\"type\":\"anyone\",\"role\":\"writer\"}"
    )
    {:ok, response_body}

  """
  def insert_permission_file(file_id, headers, body \\ "") do
    request(:post, insert_permission_url(file_id), headers, body)
  end

  @doc"""
  Share file for everyone with link

  ## Examples

    iex> share_file_with_link(
      "12BbXrA627UzddYJWK3qww1yvWl_aKuvEeSv-qkPtz68",
      [
        "Content-Type": "application/json",
        "Authorization": "Bearer ya29.Glv3BDWcd49KSskqCfSKgd_DURWF7VAbtr_b_tLneBgJZE-TCkZgwauSBIM1rf_tt344YaIgP_na-Xt5U0azKjSFTmt9_YwgfweC_b_ndyZ6Nz1PtdHXaFpOO50C"
      ],
    )
    {:ok, response_body}

  """
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
