const rl = @import("raylib");
const utils = @import("utils.zig");

pub const Shape = [4][2]f32;

pub const shapes = struct {
    pub const I: Shape = .{
        .{ 0, 0 },
        .{ 0, 1 },
        .{ 0, 2 },
        .{ 0, 3 },
    };

    pub const O: Shape = .{
        .{ 0, 0 },
        .{ 1, 0 },
        .{ 0, 1 },
        .{ 1, 1 },
    };

    pub const T: Shape = .{
        .{ 1, 0 },
        .{ 0, 1 },
        .{ 1, 1 },
        .{ 2, 1 },
    };

    pub const L: Shape = .{
        .{ 0, 0 },
        .{ 0, 1 },
        .{ 0, 2 },
        .{ 1, 2 },
    };

    pub const J: Shape = .{
        .{ 1, 0 },
        .{ 1, 1 },
        .{ 1, 2 },
        .{ 0, 2 },
    };

    pub const S: Shape = .{
        .{ 1, 0 },
        .{ 2, 0 },
        .{ 0, 1 },
        .{ 1, 1 },
    };

    pub const Z: Shape = .{
        .{ 0, 0 },
        .{ 1, 0 },
        .{ 1, 1 },
        .{ 2, 1 },
    };

    pub fn get(piece: utils.Piece) Shape {
        return switch (piece) {
            .I => I,
            .O => O,
            .T => T,
            .L => L,
            .J => J,
            .S => S,
            .Z => Z,
        };
    }
};

pub fn getBlockRect(level: usize, colorType: utils.ColorType) rl.Rectangle {
    return .{
        .x = @as(f32, @floatFromInt(@intFromEnum(colorType))) * utils.blockSize,
        .y = @as(f32, @floatFromInt(level)) * utils.blockSize,
        .width = utils.blockSize,
        .height = utils.blockSize,
    };
}

pub fn drawShape(piece: utils.Piece, x: f32, y: f32, blockRect: rl.Rectangle, texture: rl.Texture2D) void {
    const shape = shapes.get(piece);
    for (shape) |offset| {
        const bx = x + offset[0] * utils.blockSize;
        const by = y + offset[1] * utils.blockSize;
        rl.drawTextureRec(texture, blockRect, .{ .x = bx, .y = by }, rl.Color.white);
    }
}