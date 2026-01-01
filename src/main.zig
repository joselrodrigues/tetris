const std = @import("std");
const rl = @import("raylib");
const utils = @import("utils.zig");
const pieces = @import("pieces.zig");
const game = @import("game.zig");

pub fn main() anyerror!void {
    rl.initWindow(utils.screenWidth, utils.screenHeight, "NES Tetris");
    defer rl.closeWindow();

    const spriteSheet = try rl.loadTexture("src/sprites/start.png");
    const blocks = try rl.loadTexture("src/sprites/blocks.png");
    defer rl.unloadTexture(spriteSheet);
    defer rl.unloadTexture(blocks);

    rl.setTargetFPS(60);

    var gameState = game.GameState.init(100, 50, .S, 1);

    while (!rl.windowShouldClose()) {
        const deltaTime = rl.getFrameTime();

        gameState.handleInput();
        gameState.update(deltaTime);

        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.black);

        const block = pieces.getBlockRect(gameState.level, utils.getColorType(gameState.currentPiece));
        pieces.drawShape(gameState.currentPiece, gameState.pieceX, gameState.pieceY, block, blocks);
    }
}
