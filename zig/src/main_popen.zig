const std = @import("std");
const print = std.debug.print;
const Child = std.process.Child;
const ArrayList = std.ArrayList;

const popen = @import("popen.zig").popen;

pub fn main() !void {
    // https://cookbook.ziglang.cc/08-02-external.html
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const argv = [_][]const u8{
        "sigrok-cli",
        "--driver=fx2lafw",
        "--channels", 
        "D0=f,D1=h,D2=v", 
        "--config",  
        "samplerate=8m",  
        "--samples=1700k",
        //"--output-format csv"
        "-O",
        "csv",
        //"| wc",
    };
    // -O csv
    var i:u64 = 0;

    //print("{any}\n", .{argv});
    print("\n", .{});
    // By default, child will inherit stdout & stderr from its parents,
    // this usually means that child's output will be printed to terminal.
    // Here we change them to pipe and collect into `ArrayList`.
    var stdout = ArrayList(u8).init(allocator);
    var stderr = ArrayList(u8).init(allocator);
    defer {
        stdout.deinit();
        stderr.deinit();
    }

    try popen(&argv,&stdout,&stderr,allocator);

    i= 0;
    for( stdout.items ) | elem | {
        print("{c}", .{elem});
        i+=1;
        if( i > 1400){
            break ;
        }
    }
    print("\n", .{});
    //for( stdout.items ) | elem | {
        //print("{c}", .{elem});
    //}
    print("\n", .{});

}

