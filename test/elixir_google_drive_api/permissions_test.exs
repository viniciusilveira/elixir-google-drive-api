defmodule ElixirGoogleDriveApi.PermissionsTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias ElixirGoogleDriveApi.Permissions

  import Mock

  @file_id "12BbXrA627UzddYJWK3qww1yvWl_aKuvEeSv-qkPtz68"
  @headers [
    "Content-Type": "application/json",
    "Authorization": "Bearer ya29.Glv3BDWcd49KSskqCfSKgd_DURWF7VAbtr_b_tLneBgJZE-TCkZgwauSBIM1rf_tt344YaIgP_na-Xt5U0azKjSFTmt9_YwgfweC_b_ndyZ6Nz1PtdHXaFpOO50C"
  ]

  describe "update_permission_file" do
    @permission_id "anyoneWithLink"
    @invalid_permission_id "anyone"
    @update_permission_url "https://www.googleapis.com/drive/v3/files/#{@file_id}/permissions/#{@permission_id}"
    @invalid_update_permission_url "https://www.googleapis.com/drive/v3/files/#{@file_id}/permissions/#{@invalid_permission_id}"
    @body "./test/fixtures/drive_update_permission_file_body_test.json" |> File.read!
    @response_body {:ok, %HTTPoison.Response{body: @body}}
    @error_body "./test/fixtures/drive_update_permission_file_error_body_test.json" |> File.read!
    @error_response_body {:error, %HTTPoison.Error{reason: @error_body}}

    test "with success" do
      with_mock HTTPoison, [request: fn(:put, @update_permission_url, "", @headers) -> @response_body end] do
        response = Permissions.update_permission_file(@file_id, @headers, @permission_id)
        assert response == {:ok, @body |> Poison.decode!}
      end
    end

    test "with error" do
      with_mock HTTPoison, [request: fn(:put, @invalid_update_permission_url, "", @headers) -> @error_response_body end] do
        response = Permissions.update_permission_file(@file_id, @headers, @invalid_permission_id)
        assert response == {:error, @error_body}
      end
    end
  end

  describe "share_file_with_link" do
    @invalid_file_id 'invalid'
    @insert_permission_url "https://www.googleapis.com/drive/v3/files/#{@file_id}/permissions"
    @invalid_insert_permission_url "https://www.googleapis.com/drive/v3/files/#{@invalid_file_id}/permissions"
    @request_body %{
        role: "writer",
        type: "anyone"
      }
      |> Poison.encode!
    @body "./test/fixtures/drive_share_file_with_link_body_test.json" |> File.read!
    @response_body {:ok, %HTTPoison.Response{body: @body}}
    @error_body "./test/fixtures/drive_share_file_with_link_error_body_test.json" |> File.read!
    @error_response_body {:error, %HTTPoison.Error{reason: @error_body}}

    test "with success" do
      with_mock HTTPoison, [request: fn(:post, @insert_permission_url, @request_body, @headers) -> @response_body end] do
        response = Permissions.share_file_with_link(@file_id, @headers)
        assert response == {:ok, @body |> Poison.decode!}
      end
    end

    test "with error" do
      with_mock HTTPoison, [request: fn(:post, @invalid_insert_permission_url, @request_body, @headers) -> @error_response_body end] do
        response = Permissions.share_file_with_link(@invalid_file_id, @headers)
        assert response == {:error, @error_body}
      end
    end
  end
end
