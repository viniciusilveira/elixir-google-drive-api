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
    @body "{\n \"kind\": \"drive#file\",\n \"id\": \"1pdACPWuN4BSKgD4Yjv3IpJEbubIiC0ON9rTZWIhDsPE\",\n \"name\": \"Copy of Questão 1 - Revisão 1\",\n \"mimeType\": \"application/vnd.google-apps.document\"\n}\n"
    @response_body {:ok, %HTTPoison.Response{body: @body}}
    @error_body "{\n \"error\": {\n  \"errors\": [\n   {\n    \"domain\": \"global\",\n    \"reason\": \"notFound\",\n    \"message\": \"File not found: aldfkjakdjfakjfjdksssk.\",\n    \"locationType\": \"parameter\",\n    \"location\": \"fileId\"\n   }\n  ],\n  \"code\": 404,\n  \"message\": \"File not found: aldfkjakdjfakjfjdksssk.\"\n }\n}\n"
    @error_response_body {:error, %HTTPoison.Error{reason: @error_body}}

    test "with success" do
      with_mock HTTPoison, [post: fn(@copy_url, "", @headers) -> @response_body end] do
        response = Drive.copy_file(@file_id, @headers)
        assert response == @body |> Poison.decode!
      end
    end

    test "with error" do
      with_mock HTTPoison, [post: fn(@copy_url, "", @headers) -> @error_response_body end] do
        response = Drive.copy_file(@file_id, @headers)
        assert response == @error_body
      end
    end
  end

  describe "rename_file" do
    @update_url "https://www.googleapis.com/drive/v2/files/#{@file_id}"
    @body "{\n \"kind\": \"drive#file\",\n \"id\": \"1pdACPWuN4BSKgD4Yjv3IpJEbubIiC0ON9rTZWIhDsPE\",\n \"etag\": \"\\\"rOX0fJzgyZU36BYOEcGKIYxPCtI/MTUwOTY0NTQyNTExOQ\\\"\",\n \"selfLink\": \"https://www.googleapis.com/drive/v2/files/1pdACPWuN4BSKgD4Yjv3IpJEbubIiC0ON9rTZWIhDsPE\",\n \"alternateLink\": \"https://docs.google.com/document/d/1pdACPWuN4BSKgD4Yjv3IpJEbubIiC0ON9rTZWIhDsPE/edit?usp=drivesdk\",\n \"embedLink\": \"https://docs.google.com/document/d/1pdACPWuN4BSKgD4Yjv3IpJEbubIiC0ON9rTZWIhDsPE/preview\",\n \"iconLink\": \"https://drive-thirdparty.googleusercontent.com/16/type/application/vnd.google-apps.document\",\n \"thumbnailLink\": \"https://docs.google.com/feeds/vt?gd=true&id=1pdACPWuN4BSKgD4Yjv3IpJEbubIiC0ON9rTZWIhDsPE&v=3&s=AMedNnoAAAAAWft4kcBSI8xl-7lx7zSQUl9dJ2IP-l8Y&sz=s220\",\n \"title\": \"Renomeado\",\n \"mimeType\": \"application/vnd.google-apps.document\",\n \"labels\": {\n  \"starred\": false,\n  \"hidden\": false,\n  \"trashed\": false,\n  \"restricted\": false,\n  \"viewed\": true\n },\n \"createdDate\": \"2017-11-02T17:25:00.910Z\",\n \"modifiedDate\": \"2017-11-02T17:57:05.119Z\",\n \"modifiedByMeDate\": \"2017-11-02T17:57:05.119Z\",\n \"lastViewedByMeDate\": \"2017-11-02T17:57:05.119Z\",\n \"markedViewedByMeDate\": \"1970-01-01T00:00:00.000Z\",\n \"version\": \"9\",\n \"parents\": [\n  {\n   \"kind\": \"drive#parentReference\",\n   \"id\": \"0AMDaYQPF88wUUk9PVA\",\n   \"selfLink\": \"https://www.googleapis.com/drive/v2/files/1pdACPWuN4BSKgD4Yjv3IpJEbubIiC0ON9rTZWIhDsPE/parents/0AMDaYQPF88wUUk9PVA\",\n   \"parentLink\": \"https://www.googleapis.com/drive/v2/files/0AMDaYQPF88wUUk9PVA\",\n   \"isRoot\": true\n  }\n ],\n \"exportLinks\": {\n  \"application/rtf\": \"https://docs.google.com/feeds/download/documents/export/Export?id=1pdACPWuN4BSKgD4Yjv3IpJEbubIiC0ON9rTZWIhDsPE&exportFormat=rtf\",\n  \"application/vnd.oasis.opendocument.text\": \"https://docs.google.com/feeds/download/documents/export/Export?id=1pdACPWuN4BSKgD4Yjv3IpJEbubIiC0ON9rTZWIhDsPE&exportFormat=odt\",\n  \"text/html\": \"https://docs.google.com/feeds/download/documents/export/Export?id=1pdACPWuN4BSKgD4Yjv3IpJEbubIiC0ON9rTZWIhDsPE&exportFormat=html\",\n  \"application/pdf\": \"https://docs.google.com/feeds/download/documents/export/Export?id=1pdACPWuN4BSKgD4Yjv3IpJEbubIiC0ON9rTZWIhDsPE&exportFormat=pdf\",\n  \"application/epub+zip\": \"https://docs.google.com/feeds/download/documents/export/Export?id=1pdACPWuN4BSKgD4Yjv3IpJEbubIiC0ON9rTZWIhDsPE&exportFormat=epub\",\n  \"application/zip\": \"https://docs.google.com/feeds/download/documents/export/Export?id=1pdACPWuN4BSKgD4Yjv3IpJEbubIiC0ON9rTZWIhDsPE&exportFormat=zip\",\n  \"application/vnd.openxmlformats-officedocument.wordprocessingml.document\": \"https://docs.google.com/feeds/download/documents/export/Export?id=1pdACPWuN4BSKgD4Yjv3IpJEbubIiC0ON9rTZWIhDsPE&exportFormat=docx\",\n  \"text/plain\": \"https://docs.google.com/feeds/download/documents/export/Export?id=1pdACPWuN4BSKgD4Yjv3IpJEbubIiC0ON9rTZWIhDsPE&exportFormat=txt\"\n },\n \"userPermission\": {\n  \"kind\": \"drive#permission\",\n  \"etag\": \"\\\"rOX0fJzgyZU36BYOEcGKIYxPCtI/7b7PyPToFrPg3cXDFAA1Us0fgyA\\\"\",\n  \"id\": \"me\",\n  \"selfLink\": \"https://www.googleapis.com/drive/v2/files/1pdACPWuN4BSKgD4Yjv3IpJEbubIiC0ON9rTZWIhDsPE/permissions/me\",\n  \"role\": \"owner\",\n  \"type\": \"user\"\n },\n \"quotaBytesUsed\": \"0\",\n \"ownerNames\": [\n  \"teste-718@finances-control.iam.gserviceaccount.com\"\n ],\n \"owners\": [\n  {\n   \"kind\": \"drive#user\",\n   \"displayName\": \"teste-718@finances-control.iam.gserviceaccount.com\",\n   \"isAuthenticatedUser\": true,\n   \"permissionId\": \"05738090504952695662\",\n   \"emailAddress\": \"teste-718@finances-control.iam.gserviceaccount.com\"\n  }\n ],\n \"lastModifyingUserName\": \"teste-718@finances-control.iam.gserviceaccount.com\",\n \"lastModifyingUser\": {\n  \"kind\": \"drive#user\",\n  \"displayName\": \"teste-718@finances-control.iam.gserviceaccount.com\",\n  \"isAuthenticatedUser\": true,\n  \"permissionId\": \"05738090504952695662\",\n  \"emailAddress\": \"teste-718@finances-control.iam.gserviceaccount.com\"\n },\n \"capabilities\": {\n  \"canCopy\": true,\n  \"canEdit\": true\n },\n \"editable\": true,\n \"copyable\": true,\n \"writersCanShare\": true,\n \"shared\": false,\n \"explicitlyTrashed\": false,\n \"appDataContents\": false,\n \"spaces\": [\n  \"drive\"\n ]\n}\n"

    @response_body {:ok, %HTTPoison.Response{body: @body}}
    @error_body "{\n \"error\": {\n  \"errors\": [\n   {\n    \"domain\": \"global\",\n    \"reason\": \"notFound\",\n    \"message\": \"File not found: 1pdACPWuN4BSKgD4Yjv3IpJEbubIiC0ON9rTZWIhDsPS\",\n    \"locationType\": \"other\",\n    \"location\": \"file\"\n   }\n  ],\n  \"code\": 404,\n  \"message\": \"File not found: 1pdACPWuN4BSKgD4Yjv3IpJEbubIiC0ON9rTZWIhDsPS\"\n }\n}\n"
    @error_response_body {:error, %HTTPoison.Error{reason: @error_body}}

    @request_body %{title: "Renamed"} |> Poison.encode!

    test "with success" do
      with_mock HTTPoison, [patch: fn(@update_url, @request_body, @headers) -> @response_body end] do
        response = Drive.rename_file(@file_id,  %{title: "Renamed"}, @headers)
        assert response == @body |> Poison.decode!
      end
    end

    test "with error" do
      with_mock HTTPoison, [patch: fn(@update_url, @request_body, @headers) -> @error_response_body end] do
        response = Drive.rename_file(@file_id,  %{title: "Renamed"}, @headers)
        assert response == @error_body
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
    @error_body "{\n \"error\": {\n  \"errors\": [\n   {\n    \"domain\": \"global\",\n    \"reason\": \"badRequest\",\n    \"message\": \"The requested conversion is not supported.\",\n    \"locationType\": \"parameter\",\n    \"location\": \"convertTo\"\n   }\n  ],\n  \"code\": 400,\n  \"message\": \"The requested conversion is not supported.\"\n }\n}\n"
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
        assert response == @error_body
      end
    end
  end


  describe "update_permission_file" do
    @permission_id "anyoneWithLink"
    @invalid_permission_id "anyone"
    @update_permission_url "https://www.googleapis.com/drive/v2/files/#{@file_id}/permissions/#{@permission_id}"
    @invalid_update_permission_url "https://www.googleapis.com/drive/v2/files/#{@file_id}/permissions/#{@invalid_permission_id}"
    @body "{\n \"kind\": \"drive#permission\",\n \"etag\": \"\\\"rOX0fJzgyZU36BYOEcGKIYxPCtI/WYANCZ0UohBR0ORDBV2s-qumiio\\\"\",\n \"id\": \"anyoneWithLink\",\n \"selfLink\": \"https://www.googleapis.com/drive/v2/files/12BbXrA627UzddYJWK3qww1yvWl_aKuvEeSv-qkPtz68/permissions/anyoneWithLink\",\n \"role\": \"writer\",\n \"type\": \"anyone\",\n \"withLink\": true\n}\n"
    @response_body {:ok, %HTTPoison.Response{body: @body}}
    @error_body "{\n \"error\": {\n  \"errors\": [\n   {\n    \"domain\": \"global\",\n    \"reason\": \"notFound\",\n    \"message\": \"Permission not found: anyone.\",\n    \"locationType\": \"other\",\n    \"location\": \"permission\"\n   }\n  ],\n  \"code\": 404,\n  \"message\": \"Permission not found: anyone.\"\n }\n}\n"
    @error_response_body {:error, %HTTPoison.Error{reason: @error_body}}

    test "with success" do
      with_mock HTTPoison, [put: fn(@update_permission_url, "", @headers) -> @response_body end] do
        response = Drive.update_permission_file(@file_id, @headers, @permission_id)
        assert response == @body |> Poison.decode!
      end
    end

    test "with error" do
      with_mock HTTPoison, [put: fn(@invalid_update_permission_url, "", @headers) -> @error_response_body end] do
        response = Drive.update_permission_file(@file_id, @headers, @invalid_permission_id)
        assert response == @error_body
      end
    end
  end
end
