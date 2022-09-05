#!/bin/sh

set -xe

export RUST_BACKTRACE=1
# allow warnings for now
# export RUSTFLAGS="-D warnings -C target-cpu=native"
# Enables additional cpu-specific optimizations.
export RUSTFLAGS="-C target-cpu=native"

# Currently, mlocking secrets is disabled due to secure memory limit issues.
export MLOCK_SECRETS=false

# allow warnings for now
cargo clippy --all-targets # -- --deny clippy::all
cargo clippy --all-features --all-targets # -- --deny clippy::all
cargo fmt -- --check

cargo test --release
cargo doc
cargo deadlinks --dir target/doc/hbbft/
cargo audit

cd hbbft_testing
# allow warnings for now
cargo clippy --all-targets # -- --deny clippy::all
cargo fmt -- --check
cargo test --release
cd ..
