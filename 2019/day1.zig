const std = @import("std");

// zig run filename
pub fn main() !void {
    //try versionA();
    try versionB();
}

// https://adventofcode.com/2019/day/1
pub fn versionA() !void {
    const startTime: i128 = std.time.nanoTimestamp();
    defer std.debug.print("Time: {d}ns\n", .{std.time.nanoTimestamp() - startTime});

    const sourceDir: std.fs.Dir = try std.fs.cwd().openDir("src/aoc2019", .{});
    const file: std.fs.File = try sourceDir.openFile("day1.txt", .{});
    defer file.close();

    var bufReader = std.io.bufferedReader(file.reader());
    var bufStream = bufReader.reader();
    var bufLine: [1024]u8 = undefined;

    // Problem
    var totalFuel: i32 = 0;
    while (try bufStream.readUntilDelimiterOrEof(&bufLine, '\n')) |line| {
        const mass: i32 = try std.fmt.parseInt(i32, line, 10);
        totalFuel += @divFloor(mass, 3) - 2;
    }

    std.debug.print("Total Fuel: {d}.\n", .{totalFuel});
}

// https://adventofcode.com/2019/day/1#part2
pub fn versionB() !void {
    const startTime: i128 = std.time.nanoTimestamp();
    defer std.debug.print("Time: {d}ns\n", .{std.time.nanoTimestamp() - startTime});

    const sourceDir: std.fs.Dir = try std.fs.cwd().openDir("src/aoc2019", .{});
    const file: std.fs.File = try sourceDir.openFile("day1.txt", .{});
    defer file.close();

    var bufReader = std.io.bufferedReader(file.reader());
    var bufStream = bufReader.reader();
    var bufLine: [1024]u8 = undefined;

    // Problem
    var totalFuel: i32 = 0;
    while (try bufStream.readUntilDelimiterOrEof(&bufLine, '\n')) |line| {
        var mass: i32 = try std.fmt.parseInt(i32, line, 10);
        while (mass > 0) {
            const newFuel: i32 = std.math.clamp(@divFloor(mass, 3) - 2, 0, std.math.maxInt(i32));
            totalFuel += newFuel;
            mass = newFuel;
        }
    }

    std.debug.print("Total Fuel: {d}.\n", .{totalFuel});
}
