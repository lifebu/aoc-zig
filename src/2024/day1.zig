const std = @import("std");

// zig run filename
pub fn main() !void {
    try versionA();
    //try versionB();
}

// https://adventofcode.com/2019/day/1
// Series of numbers for two lists.
// Pair up the smallest number in one list with smallest number in right list. As if both lists are sorted
// Get their distances. Add all of those distances.
// What is the total distance between your list?
pub fn versionA() !void {
    const allocator = std.heap.page_allocator;

    // TODO: Use and implement a minheap?
    var firstList = std.ArrayList(i32).init(allocator);
    defer firstList.deinit();

    var secondList = std.ArrayList(i32).init(allocator);
    defer secondList.deinit();

    const startTime: i128 = std.time.nanoTimestamp();
    defer std.debug.print("Time: {d}ns\n", .{std.time.nanoTimestamp() - startTime});

    const sourceDir: std.fs.Dir = try std.fs.cwd().openDir("src/2024", .{});
    const file: std.fs.File = try sourceDir.openFile("day1.txt", .{});
    defer file.close();

    var bufReader = std.io.bufferedReader(file.reader());
    var bufStream = bufReader.reader();
    var bufLine: [1024]u8 = undefined;

    while (try bufStream.readUntilDelimiterOrEof(&bufLine, '\n')) |line| {
        var iterator = std.mem.splitAny(u8, line, " ");
        // TODO: This index thig is pretty bad!
        var index: u2 = 0;
        while(iterator.peek()) |num| : (_ = iterator.next()) {
            if(num.len == 0) {
                continue;
            }

            const value: i32 = try std.fmt.parseInt(i32, num, 10);
            // TODO: This index thig is pretty bad!
            if(index == 0) {
                try firstList.append(value);
            } else {
                try secondList.append(value);
            }

            index += 1;
        }
        index = 0;
    }

    std.mem.sort(i32, firstList.items, {}, comptime std.sort.asc(i32));
    std.mem.sort(i32, secondList.items, {}, comptime std.sort.asc(i32));

    var totalDiff: u32 = 0;
    for(firstList.items, secondList.items) |firstItem, secondItem| {
        totalDiff += @abs(firstItem - secondItem);
    }

    std.debug.print("Total Diff: {d}\n", .{totalDiff});
}

// https://adventofcode.com/2024/day/1#part2
pub fn versionB() !void {
}