# ElixirGoogleDriveApi

**Elixir Google Drive**

Elixir library to work files of Google Drive

## Setup

1. Use [this](https://console.developers.google.com/start/api?id=sheets.googleapis.com) wizard to create or select a project in the Google Developers Console and automatically turn on the API. Click __Continue__, then __Go to credentials__.
2. On the __Add credentials to your project page__, create __Service account key__.
3. Select your project name as service account and __JSON__ as key format, download the created key and rename it to __client_secret.json__.
4. Press __Manage service accounts__ on a credential page, copy your __Service Account Identifier__: _[projectname]@[domain].iam.gserviceaccount.com_
5. Create or open existing __document__ on your __Google Drive__ and add __Service Account Identifier__ as user invited in __Collaboration Settings__.
6. Add `{:elixir_google_drive_api, "~> 0.1.0"}` to __mix.exs__ under `deps` function, add `:elixir_google_drive_api` in your application list.
7. Add __client_secret.json__ in your `config.exs` or other config file, like `dev.exs` or `prod.secret.exs`.
    config :goth,
        json: "./config/client_secret.json" |> File.read!
8. Run `mix deps.get && mix deps.compile`.

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/elixir_google_drive_api](https://hexdocs.pm/elixir_google_drive_api).

