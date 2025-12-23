const std = @import("std");
const tetris = @import("tetris");

const rl = @import("raylib");

pub fn main() anyerror!void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 256;
    const screenHeight = 241;
    rl.initWindow(screenWidth, screenHeight, "raylib-zig - sprite sheet example");
    defer rl.closeWindow(); // Close window and OpenGL context

    const spriteSheet = try rl.loadTexture("src/sprites/start.png");
    defer rl.unloadTexture(spriteSheet);

    std.debug.print("Sprite sheet loaded: {}x{}\n", .{ spriteSheet.width, spriteSheet.height });

    rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.windowShouldClose()) { // Detect window close button or ESC key
        // Update
        //----------------------------------------------------------------------------------
        // TODO: Update your variables here
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.black);

        // Draw specific part of sprite sheet (left half)
        const sourceRec = rl.Rectangle{
            .x = 0,
            .y = 0,
            .width = @as(f32, @floatFromInt(spriteSheet.width)) / 2,
            .height = @as(f32, @floatFromInt(spriteSheet.height)),
        };

        // std.debug.print("{} {}", .{ spriteSheet.width, spriteSheet.height });

        const position = rl.Vector2{ .x = 0, .y = 0 };
        rl.drawTextureRec(spriteSheet, sourceRec, position, rl.Color.white);

        //----------------------------------------------------------------------------------
    }
}
