const std = @import("std");
const print = std.debug.print;
const Child = std.process.Child;
const ArrayList = std.ArrayList;

pub fn popen(argv:anytype,stdout:anytype,stderr:anytype,allocator:anytype) !void {
    // https://cookbook.ziglang.cc/08-02-external.html

    for( argv ) | elem | {
        print("{s} ", .{elem});
    }
    print("\n", .{});

    //var child = Child.init(&argv, allocator);
    var child = Child.init(argv, allocator);
    child.stdout_behavior = .Pipe;
    child.stderr_behavior = .Pipe;
    
    try child.spawn();
    //try child.collectOutput(&stdout, &stderr, 47175488); // 1024
    try child.collectOutput(stdout, stderr, 5896936);//47175488); // 1024
    const term = try child.wait();

    _ = term;
    //try std.testing.expectEqual(term.Exited, 0);
    //try std.testing.expectEqualStrings("hello world", stdout.items);
    //try std.testing.expectEqualStrings("", stderr.items);
}

