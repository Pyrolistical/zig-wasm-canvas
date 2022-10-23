const std = @import("std");
const allocator = std.heap.page_allocator;

extern "env" fn _throwError(pointer: [*]const u8, length: u32) noreturn;
pub fn throwError(message: []const u8) noreturn {
    _throwError(message.ptr, message.len);
}

extern "env" fn _consoleLog(pointer: [*]const u8, length: u32) void;
pub fn consoleLog(comptime fmt: []const u8, args: anytype) void {
    const msg = std.fmt.allocPrint(allocator, fmt, args) catch
        @panic("failed to allocate memory for consoleLog message");
    defer allocator.free(msg);
    _consoleLog(msg.ptr, msg.len);
}
