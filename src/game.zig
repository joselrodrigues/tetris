const utils = @import("utils.zig");
const rl = @import("raylib");
const std = @import("std");
const pieces = @import("pieces.zig");

pub const GameState = struct {
    pieceX: f32,
    pieceY: f32,
    currentPiece: utils.Piece,
    level: usize,
    gravityTimer: f32,

    pub fn init(startX: f32, startY: f32, piece: utils.Piece, level: usize) GameState {
        return .{
            .pieceX = startX,
            .pieceY = startY,
            .currentPiece = piece,
            .level = level,
            .gravityTimer = 0.0,
        };
    }

    pub fn update(self: *GameState, deltaTime: f32) void {
        var gravitySpeed = getGravitySpeed(self.level);

        if (rl.isKeyDown(.down)) {
            gravitySpeed = 0.05;
        }

        self.gravityTimer += deltaTime;
        if (self.gravityTimer >= gravitySpeed) {
            const newY = self.pieceY + utils.blockSize;

            if (canMoveTo(self.currentPiece, self.pieceX, newY)) {
                self.pieceY = newY;
                self.gravityTimer = 0.0;
            } else {
                std.debug.print("Pieza bloqueada en Y={d}\n", .{self.pieceY});
            }
        }
    }

    pub fn handleInput(self: *GameState) void {
        if (rl.isKeyPressed(.left)) {
            const newX = self.pieceX - utils.blockSize;
            if (canMoveTo(self.currentPiece, newX, self.pieceY)) {
                self.pieceX = newX;
            }
        }

        if (rl.isKeyPressed(.right)) {
            const newX = self.pieceX + utils.blockSize;
            if (canMoveTo(self.currentPiece, newX, self.pieceY)) {
                self.pieceX = newX;
            }
        }
    }
};

fn canMoveTo(piece: utils.Piece, x: f32, y: f32) bool {
    const shape = pieces.shapes.get(piece);

    for (shape) |offset| {
        const blockX = x + offset[0] * utils.blockSize;
        const blockY = y + offset[1] * utils.blockSize;

        if (blockX < 0 or blockX >= @as(f32, @floatFromInt(utils.screenWidth))) {
            return false;
        }

        if (blockY < 0 or blockY >= @as(f32, @floatFromInt(utils.screenHeight))) {
            return false;
        }
    }

    return true;
}

fn getGravitySpeed(level: usize) f32 {
    return switch (level) {
        0 => 0.8,
        1 => 0.72,
        2 => 0.63,
        3 => 0.55,
        4 => 0.47,
        5 => 0.38,
        6 => 0.30,
        7 => 0.22,
        8 => 0.13,
        9 => 0.10,
        10...15 => 0.08,
        16...18 => 0.07,
        19...28 => 0.05,
        else => 0.03,
    };
}

