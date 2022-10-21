const std = @import("std");
const builtin = std.builtin;
const math = std.math;
const allocator = std.heap.page_allocator;

const env = @import("env.zig");
const ctx = @import("canvas.zig");

extern "app" fn _promptName(
    messsage_pointer: [*]const u8,
    message_length: u32,
    output_pointer: [*]const u8,
    output_length: u32,
) u32;
fn allocPromptName(message: []const u8) !struct {
    buffer: []u8,
    name: []const u8,
} {
    const max_name_length = 50;
    const buffer = try allocator.alloc(u8, max_name_length);
    const length = _promptName(message.ptr, message.len, buffer.ptr, buffer.len);
    return .{
        .buffer = buffer,
        .name = buffer[0..length],
    };
}

fn draw() !void {
    {
        ctx.save();
        defer ctx.restore();
        const result = try allocPromptName("What is your name?");
        defer allocator.free(result.buffer);
        const salutation = try std.fmt.allocPrint(allocator, "Dear {s},", .{result.name});
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
            @panic("failed to allocate memory when printing uncaught error");
        defer allocator.free(message);
        @panic(message);
    };
}

// calls to @panic are sent here.
// see https://ziglang.org/documentation/master/#panic
pub fn panic(message: []const u8, _: ?*builtin.StackTrace, _: ?usize) noreturn {
    env.throwError(message);
}
