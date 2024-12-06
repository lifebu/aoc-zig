const std = @import("std");

// TODO: Have a launch.json thing that I can debug the current file with it's main? zig run filename
const aoc2019d1 = @import("2019/day1.zig");
const aoc2024d1 = @import("2024/day1.zig");

pub fn main() !void {
    try aoc2024d1.versionA();
}