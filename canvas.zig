const std = @import("std");
const allocator = std.heap.page_allocator;

pub extern "ctx" fn save() void;
pub extern "ctx" fn restore() void;

pub extern "ctx" fn translate(x: f64, y: f64) void;
pub extern "ctx" fn scale(x: f64, y: f64) void;
pub extern "ctx" fn rotate(angle: f64) void;

pub extern "ctx" fn beginPath() void;
pub extern "ctx" fn moveTo(x: f64, y: f64) void;
pub extern "ctx" fn lineTo(x: f64, y: f64) void;

extern "ctx" fn _font(pointer: [*]const u8, length: u32) void;
pub fn font(style: []const u8) void {
    _font(style.ptr, style.len);
}

extern "ctx" fn _fillStyle(pointer: [*]const u8, length: u32) void;
pub fn fillStyle(style: []const u8) void {
    _fillStyle(style.ptr, style.len);
}

extern "ctx" fn _fillText(pointer: [*]const u8, length: u32, x: f64, y: f64) void;
pub fn fillText(style: []const u8, x: f64, y: f64) void {
    _fillText(style.ptr, style.len, x, y);
}

pub extern "ctx" fn fill() void;

pub extern "ctx" fn lineWidth(width: f64) void;
extern "ctx" fn _lineCap(pointer: [*]const u8, length: u32) void;
pub fn lineCap(style: []const u8) void {
    _lineCap(style.ptr, style.len);
}

extern "ctx" fn _strokeStyle(pointer: [*]const u8, length: u32) void;
pub fn strokeStyle(style: []const u8) void {
    _strokeStyle(style.ptr, style.len);
}

extern "ctx" fn _strokeText(pointer: [*]const u8, length: u32, x: f64, y: f64) void;
pub fn strokeText(style: []const u8, x: f64, y: f64) void {
    _strokeText(style.ptr, style.len, x, y);
}

pub extern "ctx" fn stroke() void;
