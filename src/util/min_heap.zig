const std = @import("std");

const Error = error{
    Full,
};

pub fn MinHeap(T: type, comptime max_size: usize) type {
    return struct {
        const Self = @This();
        /// array backing the min heap.
        arr: [max_size]T = [_]T{0} ** max_size,
        // the current size of the min heap.
        size: usize = 0,

        pub fn insert(self: *Self, val: T) Error!void {
            if(self.size == self.arr.len) {
                return Error.Full;
            }

            self.arr[self.size] = val;
            self.size += 1;

            var idx = self.size - 1;
            var parentIdx = (idx - 1) / 2;
            while(idx > 0 and self.arr[parentIdx] > self.arr[idx]) 
                : ({idx = parentIdx; parentIdx = (idx - 1) / 2;}) {
                std.mem.swap(T, &self.arr[idx], &self.arr[parentIdx]);
            }
        } 
    };
}