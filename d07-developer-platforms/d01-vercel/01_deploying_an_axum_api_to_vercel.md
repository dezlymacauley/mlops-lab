# Deploying an Axum API to Vercel
_______________________________________________________________________________

## 1. Create a regular Rust project
_______________________________________________________________________________

Rememember to add this to you `.gitignore`
```gitignore
# Vercel Deployment
.vercel
```
_______________________________________________________________________________

## 2. Add the following project dependencies
_______________________________________________________________________________

An async runtime
```bash
cargo add tokio --features macros,net,rt-multi-thread,signal
```
_______________________________________________________________________________

A package for working with JSON data
```bash
cargo add serde --features derive
```
_______________________________________________________________________________

A server and a router
```bash
cargo add axum
```
_______________________________________________________________________________

I like to format my `Cargo.toml` file to look like this
```toml
[package]
name = "vercel-docker-rust"
version = "0.1.0"
edition = "2024"

#______________________________________________________________________________

[dependencies]

axum = "0.8.9"

serde = { 
    version = "1.0.229", 
    features = ["derive"] 
}

tokio = { 
    version = "1.53.2", 
    features = ["macros", "net", "rt-multi-thread", "signal"] 
}
#______________________________________________________________________________

[profile.release]
strip = true
lto = "thin"
#______________________________________________________________________________
```
_______________________________________________________________________________

Add the latest `lts` (long-term support version) of `Node.js`

The Vercel cli expects Node to be installed. The version of Node.js,
that I have on Arch Linux is often too new for the Vercel cli,
so I use mise to get the `lts` version of Node.js which is older.
```bash
mise use node@lts
```
_______________________________________________________________________________

Add the Vercel cli
```bash
mise use vercel@latest
```
_______________________________________________________________________________

Example for `src/main.rs`
```rust
use axum::{routing::get, Json, Router};
use serde::Serialize;
use std::{env, net::SocketAddr};

#[derive(Serialize)]
struct Message {
    message: &'static str,
}

#[derive(Serialize)]
struct Health {
    status: &'static str,
}

async fn hello() -> Json<Message> {
    Json(Message { message: "Hello from Rust on Vercel" })
}

async fn health() -> Json<Health> {
    Json(Health { status: "ok" })
}

#[tokio::main]
async fn main() {
    let port = env::var("PORT").ok().and_then(|v| v.parse().ok()).unwrap_or(80);
    let address = SocketAddr::from(([0, 0, 0, 0], port));

    let app = Router::new()
        .route("/", get(hello))
        .route("/health", get(health));

    let listener = tokio::net::TcpListener::bind(address).await.unwrap();

    axum::serve(listener, app)
        .with_graceful_shutdown(shutdown_signal())
        .await
        .unwrap();
}

async fn shutdown_signal() {
    let mut terminate =
        tokio::signal::unix::signal(tokio::signal::unix::SignalKind::terminate())
            .expect("install SIGTERM handler");

    terminate.recv().await;
}
```
_______________________________________________________________________________

Create a `vercel.json` file

Add this to the file

```json
{
  "$schema": "https://openapi.vercel.sh/vercel.json",
  "services": {
    "api": {
      "root": ".",
      "entrypoint": "Dockerfile.vercel",
      "runtime": "container"
    }
  },
  "rewrites": [
    { "source": "/(.*)", "destination": { "service": "api" } }
  ]
}
```
_______________________________________________________________________________

Ensure that Docker is running, then run this command

```bash
vercel dev -L
```

This will build your project in a local Docker container
_______________________________________________________________________________

You can open this in the browser

The root route
```
http://localhost:3000/
```
The health route
```
http://localhost:3000/health
```
_______________________________________________________________________________

Login to Vercel
```bash
vercel login
```
_______________________________________________________________________________

Deploy the API to Vercel
```bash
vercel deploy --prod
```
_______________________________________________________________________________

```
Vercel CLI 62.0.0 (Node.js 24.21.0)

  Directory       ~/local-workspace/github/public/vercel-docker-rust

  Team            dezlymacauley
? Which project?
  Search all projects
❯ Create a new project
Create it under dezlymacauley
```

_______________________________________________________________________________

Press enter
```
? Name? Press ↑ to return to project options (vercel-docker-rust)
```
_______________________________________________________________________________

Type `N` and press enter
```
? Connect this Git repository to automatically deploy changes on every push? (y/N) N
```
_______________________________________________________________________________

You can view the app here
```
https://vercel-docker-rust-ochre.vercel.app
```

Note: Each link on Vercel must be unique.
So Vercel detected a clash and added the word `ochre` to the link.

To avoid this, ensure that you pick a unique project name.
_______________________________________________________________________________

### Note:

For future deployments, use `vercel deploy --prod`
_______________________________________________________________________________
