# zig-wasm-canvas

![](screenshot.png)

Demo showing how to call HTML canvas from zig via WebAssembly.

### Features

- Shim that makes it appear canvas ctx is in zig
- Shows how to pass strings from zig to JavaScript
- Shows how to read strings from JavaScript to zig
- @panic in zig throws an error in JavaScript

### Setup

1. Download [`zig 0.10.0`](https://ziglang.org/download/)
2. Add `zig` to path.
3. `npm run build:zig`
4. `npm run start`
5. Re-run `npm run build:zig` whenever zig files are changed.
