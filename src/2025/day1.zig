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

    const file: []const u8 = try std.fs.cwd().readFileAlloc(alloc, file_name, std.math.maxInt(u32));
    defer alloc.free(file);

    var dial: i16 = 50;
    var hit_zero_count: usize = 0;
    var line_it = std.mem.splitScalar(u8, file, '\n');
    while(line_it.next()) |line| {
        if(line.len == 0) {
            continue;
        }

        const direction: u8 = line[0];
        const amount: i16 = try std.fmt.parseInt(i16, line[1..], 10);
        const movement: i16 = if(direction == 'L') -amount else amount;
        const limit: i16 = 100;
        dial = @mod(((dial + @mod(movement, limit)) + limit), limit);
        if(dial == 0) {
            hit_zero_count += 1;
        }
    }
    std.log.info("Hit zero count: {}", .{ hit_zero_count });
}

// https://adventofcode.com/2024/day/1#part2
pub fn versionB() !void {
}
