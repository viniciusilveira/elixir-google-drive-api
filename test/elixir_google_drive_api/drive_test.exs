defmodule ElixirGoogleDriveApi.DriveTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias ElixirGoogleDriveApi.Drive

  import Mock

  @file_id "12BbXrA627UzddYJWK3qww1yvWl_aKuvEeSv-qkPtz68"
  @headers [
    "Content-Type": "application/json",
    "Authorization": "Bearer ya29.Glv3BDWcd49KSskqCfSKgd_DURWF7VAbtr_b_tLneBgJZE-TCkZgwauSBIM1rf_tt344YaIgP_na-Xt5U0azKjSFTmt9_YwgfweC_b_ndyZ6Nz1PtdHXaFpOO50C"
  ]

  describe "copy_file" do
    @copy_url "https://www.googleapis.com/drive/v3/files/#{@file_id}/copy"
    @body "./test/fixtures/drive_copy_file_body_test.json" |> File.read!
    @response_body {:ok, %HTTPoison.Response{body: @body}}
    @error_body "./test/fixtures/drive_copy_file_error_body_test.json" |> File.read!
    @error_response_body {:error, %HTTPoison.Error{reason: @error_body}}

    test "with success" do
      with_mock HTTPoison, [request: fn(:post, @copy_url, "", @headers) -> @response_body end] do
        response = Drive.copy_file(@file_id, @headers)
        assert response == {:ok, @body |> Poison.decode!}
      end
    end

    test "with error" do
      with_mock HTTPoison, [request: fn(:post, @copy_url, "", @headers) -> @error_response_body end] do
        response = Drive.copy_file(@file_id, @headers)
        assert response == {:error, @error_body}
      end
    end
  end

  describe "rename_file" do
    @update_url "https://www.googleapis.com/drive/v3/files/#{@file_id}"
    @body "./test/fixtures/drive_rename_file_body_test.json" |> File.read!
    @error_body "./test/fixtures/drive_rename_file_body_test.json" |> File.read!

    @response_body {:ok, %HTTPoison.Response{body: @body}}
    @error_response_body {:error, %HTTPoison.Error{reason: @error_body}}

    @request_body %{name: "Renamed"} |> Poison.encode!

    test "with success" do
      with_mock HTTPoison, [request: fn(:patch, @update_url, @request_body, @headers) -> @response_body end] do
        response = Drive.rename_file(@file_id,  %{title: "Renamed"}, @headers)
        assert response == {:ok, @body |> Poison.decode!}
      end
    end

    test "with error" do
      with_mock HTTPoison, [request: fn(:patch, @update_url, @request_body, @headers) -> @error_response_body end] do
        response = Drive.rename_file(@file_id,  %{title: "Renamed"}, @headers)
        assert response == {:error, @error_body}
      end
    end
  end

  describe "export_file" do
    @headers [
      "Content-Type": "application/json",
      "Authorization": "Bearer ya29.Glv3BDWcd49KSskqCfSKgd_DURWF7VAbtr_b_tLneBgJZE-TCkZgwauSBIM1rf_tt344YaIgP_na-Xt5U0azKjSFTmt9_YwgfweC_b_ndyZ6Nz1PtdHXaFpOO50C"
    ]
    @export_url "https://www.googleapis.com/drive/v3/files/#{@file_id}/export?mimeType=application/vnd.oasis.opendocument.text"
    @invalid_export_url "https://www.googleapis.com/drive/v3/files/#{@file_id}/export?mimeType=application/invalid.mime.type"
    @body <<80, 75, 3, 4, 20, 0, 0, 8, 0, 0, 10, 175, 132, 75, 94, 198, 50, 12, 39, 0, 0,
    0, 39, 0, 0, 0, 8, 0, 0, 0, 109, 105, 109, 101, 116, 121, 112, 101, 97, 112,
    112, 108, 105, 99, 97, 116, 105, 111, 110, 47>>

    @response_body {:ok, %HTTPoison.Response{body: @body}}
    @error_body "./test/fixtures/drive_export_file_error_body_test.json" |> File.read!
    @error_response_body {:error, %HTTPoison.Error{reason: @error_body}}

    test "with success" do
      with_mock HTTPoison, [get: fn(@export_url, @headers) -> @response_body end] do
        response = Drive.export_file(@file_id, @headers, "application/vnd.oasis.opendocument.text")
        assert response == {:ok, ".temp/doc_file.doc"}
      end
    end

    test "with error" do
      with_mock HTTPoison, [get: fn(@invalid_export_url, @headers) -> @error_response_body end] do
        response = Drive.export_file(@file_id, @headers, "application/invalid.mime.type")
        assert response == {:error, @error_body}
      end
    end
  end

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
        response = Drive.update_permission_file(@file_id, @headers, @permission_id)
        assert response == {:ok, @body |> Poison.decode!}
      end
    end

    test "with error" do
      with_mock HTTPoison, [request: fn(:put, @invalid_update_permission_url, "", @headers) -> @error_response_body end] do
        response = Drive.update_permission_file(@file_id, @headers, @invalid_permission_id)
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
        response = Drive.share_file_with_link(@file_id, @headers)
        assert response == {:ok, @body |> Poison.decode!}
      end
    end

    test "with error" do
      with_mock HTTPoison, [request: fn(:post, @invalid_insert_permission_url, @request_body, @headers) -> @error_response_body end] do
        response = Drive.share_file_with_link(@invalid_file_id, @headers)
        assert response == {:error, @error_body}
      end
    end
  end
end
