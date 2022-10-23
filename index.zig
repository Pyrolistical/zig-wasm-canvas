const std = @import("std");
const builtin = std.builtin;
const math = std.math;
const allocator = std.heap.page_allocator;

const env = @import("env.zig");
const ctx = @import("canvas.zig");

extern "app" fn _allocPromptName(
    messsage_pointer: [*]const u8,
    message_length: u32,
) [*:0]u8;
fn allocPromptName(message: []const u8) []const u8 {
    const name_pointer = _allocPromptName(message.ptr, message.len);
    return std.mem.span(name_pointer);
}

fn draw() !void {
    {
        ctx.save();
        defer ctx.restore();
        const name = allocPromptName("What is your name?");
        defer allocator.free(name);
        const salutation = try std.fmt.allocPrint(allocator, "Dear {s},", .{name});
        defer allocator.free(salutation);

        ctx.font("60px cursive");
        ctx.fillText(salutation, 50.0, 100.0);
        ctx.fillText("From Zig.", 50.0, 700.0);
    }
    {
        ctx.save();
        defer ctx.restore();
        ctx.translate(100.0, 150.0);
        ctx.beginPath();
        ctx.moveTo(150.0, 150.0);
        ctx.lineTo(300.0, 300.0);
        ctx.lineTo(450.0, 150.0);
        ctx.strokeStyle("red");
        ctx.lineWidth(300.0);
        ctx.lineCap("round");
        ctx.stroke();
    }
}

export fn _draw() void {
    draw() catch |err| {
        const message = std.fmt.allocPrint(allocator, "uncaught error {any}\n", .{err}) catch
            @panic("failed to allocate memory for uncaught error message");
        defer allocator.free(message);
        @panic(message);
    };
}

// Calls to @panic are sent here.
// See https://ziglang.org/documentation/master/#panic
pub fn panic(message: []const u8, _: ?*builtin.StackTrace, _: ?usize) noreturn {
    env.throwError(message);
}

export fn allocUint8(length: u32) [*]const u8 {
    const slice = allocator.alloc(u8, length) catch
        @panic("failed to allocate memory");
    return slice.ptr;
}

export fn free(pointer: [*:0]u8) void {
    allocator.free(std.mem.span(pointer));
}
