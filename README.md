# GenStage 実装サンプル

GenStageを使ってバックプレッシャーを効かせて並列数を制限しながら非同期処理を実行する実装例

## 準備

```
mix deps.get
```

## エラー回避のためだけのPostgres起動

(本当はPhoenix関係ないんだけど。。。Elixirよくわからないまま試行錯誤していたので。。。すまぬ)

```
docker compose up
```

## 実行

```
iex -S mix

iex(1)> Hello.Test.run :cast
```

---

# Hello

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
