const std = @import("std");

// https://adventofcode.com/2025/day/1
// Textfile: Each line is L/R+Number
// We start at 50. Everytime we reach 0 increment number. How often do we pass 0?
pub fn versionA() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    var args = try std.process.argsWithAllocator(alloc);
    defer args.deinit();

    _ = args.next(); // The file itself.
    const file_name = args.next().?;

    const file: std.fs.File = try std.fs.cwd().openFile(file_name, .{});
    defer file.close();

    var dial: u8 = 50;
    var hit_zero_count = 0;
    var line_it = std.mem.splitScalar(u8, file, '\n');
    while(line_it.next()) |line| {
        const direction: u8 = line[0];
        const amount: u8 = try std.fmt.parseInt(u8, line[1..], 10);
        const movement: i16 = if(direction == 'L') -amount else amount;
    }
    std.log.info("Hit zero count: {}\n", .{ hit_zero_count });
}

// https://adventofcode.com/2024/day/1#part2
pub fn versionB() !void {
}
