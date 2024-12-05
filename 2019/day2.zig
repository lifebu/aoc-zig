const std = @import("std");

// zig run filename
pub fn main() !void {
    try versionA();
    //try versionB();
}

// Intcode program: list of integers, comma-seperated.
// Start by looking at position 0 (first integer).
// Step: move to next opcode by advancing 4.
// Encountering unknown opcode => wrong.
// first integer is opcode (1: adds, 2: multiply, 99: finished)
// add: (idxInput1, idxInput2, idsResult). (indices where to read).
// mul: (idxInput1, idxInput2, idsResult). (indices where to read).

// puzzle input: change idx 1 to 12 and idx 2 with 2 => what value is left at position 0?

const OpCodeErr = error{
    INVALID_OPCODE,
};

// https://adventofcode.com/2019/day/2
pub fn versionA() !void {
    const startTime: i128 = std.time.nanoTimestamp();
    defer std.debug.print("Time: {d}ns\n", .{std.time.nanoTimestamp() - startTime});

    var allocator = std.heap.GeneralPurposeAllocator(.{}){};
    const alloc = allocator.allocator();
    defer _ = allocator.deinit();

    const sourceDir: std.fs.Dir = try std.fs.cwd().openDir("src/aoc2019", .{});
    const input = try sourceDir.readFileAlloc(alloc, "day2.txt", std.math.maxInt(usize));
    std.debug.print("Input:\n{s}", .{input});
    defer alloc.free(input);

    // convert string input to flat integer array.
    var intPrg = try std.BoundedArray(usize, 256).init(0);
    var splitIt = std.mem.splitAny(u8, input, ",\n");
    while (splitIt.next()) |split| {
        if (split.len == 0) {
            continue;
        }

        const val: usize = try std.fmt.parseInt(usize, split, 10);
        try intPrg.append(val);
    }

    // TODO: could this be better?
    var i: usize = 0;
    while (i < intPrg.len) {
        const opcode = intPrg.get(i);
        switch (opcode) {
            1 => {
                const iOperand1: usize = intPrg.get(i + 1);
                const iOperand2: usize = intPrg.get(i + 2);
                const iResult: usize = intPrg.get(i + 3);

                const result = intPrg.get(iOperand1) + intPrg.get(iOperand2);
                intPrg.set(iResult, result);
                i += 4;
            },
            2 => {
                const iOperand1 = intPrg.get(i + 1);
                const iOperand2 = intPrg.get(i + 2);
                const iResult = intPrg.get(i + 3);

                const result = intPrg.get(iOperand1) * intPrg.get(iOperand2);
                intPrg.set(iResult, result);
                i += 4;
            },
            99 => break,
            else => {
                std.debug.print("ERROR: INVALID_OPCODE: {d}", .{opcode});
                return OpCodeErr.INVALID_OPCODE;
            },
        }
    }

    std.debug.print("Output:\n", .{});
    for (intPrg.slice()) |elem| {
        std.debug.print("{d}, ", .{elem});
    }
    std.debug.print("\n", .{});
}
