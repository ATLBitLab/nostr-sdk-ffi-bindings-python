#!/usr/bin/env bash

set -euo pipefail
python3 --version
pip install --user -r requirements.txt

echo "Generating nostr_sdk.py..."
cd ../
cargo run -p uniffi-bindgen generate src/nostr_sdk.udl --language python --no-format -o bindings-python/src/nostr-sdk/

echo "Generating native binaries..."
rustup target add x86_64-apple-darwin
cargo build --release --target x86_64-apple-darwin

echo "Copying libraries libnostr_sdk_ffi.dylib..."
cp ../../target/x86_64-apple-darwin/release/libnostr_sdk_ffi.dylib bindings-python/src/nostr-sdk/

echo "All done!"
