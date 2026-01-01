pub const blockSize: f32 = 8;
pub const screenWidth: i32 = 256;
pub const screenHeight: i32 = 241;

pub const Piece = enum {
    I,
    O,
    T,
    L,
    J,
    S,
    Z,
};

pub const ColorType = enum(u8) {
    primary = 0,
    secondary = 1,
    tertiary = 2,
};

pub fn getColorType(piece: Piece) ColorType {
    return switch (piece) {
        .I => .primary,
        .T => .primary,
        .O => .primary,
        .L => .secondary,
        .J => .tertiary,
        .Z => .secondary,
        .S => .tertiary,
    };
}