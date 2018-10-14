[![Build Status](https://travis-ci.org/viniciusilveira/elixir-google-drive-api.svg?branch=master)](https://travis-ci.org/viniciusilveira/elixir-google-drive-api)
[![Ebert](https://ebertapp.io/github/viniciusilveira/elixir-google-drive-api.svg)](https://ebertapp.io/github/viniciusilveira/elixir-google-drive-api)
[![codecov](https://codecov.io/gh/viniciusilveira/elixir-google-drive-api/branch/master/graph/badge.svg)](https://codecov.io/gh/viniciusilveira/elixir-google-drive-api)

# ElixirGoogleDriveApi

**Elixir Google Drive**

Elixir library to work files of Google Drive

## Usage

1. Use [this](https://console.developers.google.com/start/api?id=sheets.googleapis.com) wizard to create or select a project in the Google Developers Console and automatically turn on the API. Click __Continue__, then __Go to credentials__.
2. On the __Add credentials to your project page__, create __Service account key__.
3. Select your project name as service account and __JSON__ as key format, download the created key and rename it to __client_secret.json__.
4. Press __Manage service accounts__ on a credential page, copy your __Service Account Identifier__: _[projectname]@[domain].iam.gserviceaccount.com_
5. Create or open existing __document__ on your __Google Drive__ and add __Service Account Identifier__ as user invited in __Collaboration Settings__.
6. Setup your project:

```elixir
defp deps do
  [
    {:elixir_google_drive_api, "~> 0.4"}
  ]
end
```

7. Add __client_secret.json__ in your `config.exs` or other config file, like `dev.exs` or `prod.secret.exs`.

```elixir
  config :goth, json: "./config/client_secret.json" |> File.read!
```
8. Run `mix deps.get && mix deps.compile`.

## Current Status

[Google Drive V3 Api Reference](https://developers.google.com/drive/api/v3/reference/)

### About

For About Resource details, see the [resource representation](https://developers.google.com/drive/api/v3/reference/about#resource) page.

- [ ] [Get](https://developers.google.com/drive/api/v3/reference/about/get)

### Changes

For Changes Resource details, see the [resource representation](https://developers.google.com/drive/api/v3/reference/changes#resource) page.

- [ ] [Get Start Page Token](https://developers.google.com/drive/api/v3/reference/changes/getStartPageToken)
- [ ] [List](https://developers.google.com/drive/api/v3/reference/changes/list)
- [ ] [Watch](https://developers.google.com/drive/api/v3/reference/changes/watch)

### Channels

For Channels Resource details, see the [resource representation](https://developers.google.com/drive/api/v3/reference/channels#resource) page.

- [ ] [Stop](https://developers.google.com/drive/api/v3/reference/channels/stop)

### Comments

For Comments Resource details, see the [resource representation](https://developers.google.com/drive/api/v3/reference/comments#resource) page.

- [ ] [Create](https://developers.google.com/drive/api/v3/reference/comments/create)
- [ ] [Delete](https://developers.google.com/drive/api/v3/reference/comments/delete)
- [ ] [Get](https://developers.google.com/drive/api/v3/reference/comments/get)
- [ ] [List](https://developers.google.com/drive/api/v3/reference/comments/list)
- [ ] [Update](https://developers.google.com/drive/api/v3/reference/comments/update)

### Files

For Files Resource details, see the [resource representation](https://developers.google.com/drive/api/v3/reference/files#resource) page.

- [x] [Copy](https://developers.google.com/drive/api/v3/reference/files/copy)
- [ ] [Create](https://developers.google.com/drive/api/v3/reference/files/create)
- [ ] [Delete](https://developers.google.com/drive/api/v3/reference/files/delete)
- [ ] [Empty Trash](https://developers.google.com/drive/api/v3/reference/files/emptyTrash)
- [ ] [Export](https://developers.google.com/drive/api/v3/reference/files/export)
- [ ] [Generate Ids](https://developers.google.com/drive/api/v3/reference/files/generateIds)
- [ ] [Get](https://developers.google.com/drive/api/v3/reference/files/get)
- [x] [Update](https://developers.google.com/drive/api/v3/reference/files/update)
- [ ] [List](https://developers.google.com/drive/api/v3/reference/files/list)
- [ ] [Watch](https://developers.google.com/drive/api/v3/reference/files/watch)

### Permissions

For Permissions Resource details, see the [resource representation](https://developers.google.com/drive/api/v3/reference/permissions#resource) page.

- [x] [Create](https://developers.google.com/drive/api/v3/reference/permissions/create)
- [ ] [Delete](https://developers.google.com/drive/api/v3/reference/permissions/delete)
- [ ] [Get](https://developers.google.com/drive/api/v3/reference/permissions/get)
- [ ] [List](https://developers.google.com/drive/api/v3/reference/permissions/list)
- [x] [Update](https://developers.google.com/drive/api/v3/reference/permissions/update)

### Replies

For Replies Resource details, see the [resource representation](https://developers.google.com/drive/api/v3/reference/replies#resource) page.

- [ ] [Create](https://developers.google.com/drive/api/v3/reference/replies/create)
- [ ] [Delete](https://developers.google.com/drive/api/v3/reference/replies/delete)
- [ ] [Get](https://developers.google.com/drive/api/v3/reference/replies/get)
- [ ] [List](https://developers.google.com/drive/api/v3/reference/replies/list)
- [ ] [Update](https://developers.google.com/drive/api/v3/reference/replies/update)

### Revisions

For Revisions Resource details, see the [resource representation](https://developers.google.com/drive/api/v3/reference/revisions#resource) page.

- [ ] [Delete](https://developers.google.com/drive/api/v3/reference/revisions/delete)
- [ ] [Get](https://developers.google.com/drive/api/v3/reference/revisions/get)
- [ ] [List](https://developers.google.com/drive/api/v3/reference/revisions/list)
- [ ] [Update](https://developers.google.com/drive/api/v3/reference/revisions/update)

### Teamdrives

For Revisions Resource details, see the [resource representation](https://developers.google.com/drive/api/v3/reference/teamdrives#resource) page.

- [ ] [Create](https://developers.google.com/drive/api/v3/reference/teamdrives/create)
- [ ] [Delete](https://developers.google.com/drive/api/v3/reference/teamdrives/delete)
- [ ] [Get](https://developers.google.com/drive/api/v3/reference/teamdrives/get)
- [ ] [List](https://developers.google.com/drive/api/v3/reference/teamdrives/list)
- [ ] [Update](https://developers.google.com/drive/api/v3/reference/teamdrives/update)

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/elixir_google_drive_api](https://hexdocs.pm/elixir_google_drive_api).

