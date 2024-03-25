const std = @import("std");
const builtin = @import("builtin");
const os = std.os;
const fs = std.fs;
const print = std.debug.print;


pub fn read() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const ms:u64 = std.time.ms_per_s/100;
    print( "ms: {d}", .{ms});
    
    var start:i64 = @divFloor(std.time.milliTimestamp(), ms);

    
    var f = std.ArrayList(u8).init(allocator);
    defer f.deinit();
    var p = std.ArrayList(u8).init(allocator);
    defer p.deinit();
    var l = std.ArrayList(u8).init(allocator);
    defer l.deinit();

    const s1:i64 = @divFloor(std.time.milliTimestamp(), ms)-start;
    start = @divFloor(std.time.milliTimestamp(), ms);


    // Get the path
    var path_buffer: [std.fs.MAX_PATH_BYTES]u8 = undefined;
    const path = try std.fs.realpath("frame_8m.txt", &path_buffer);

    // Open the file
    const file = try std.fs.openFileAbsolute(path, .{}); //.{ .read = true });
    defer file.close();

    // Read the contents
    const buffer_size = 1024*1024*27;
    const file_buffer = try file.readToEndAlloc(allocator, buffer_size);
    defer allocator.free(file_buffer);

    // Split by "\n" and iterate through the resulting slices of "const []u8"
    //var iter = std.mem.split(u8,file_buffer, "\n");
    print("c {any}", .{file_buffer.len});

    var run3:bool = true;
    var k:u64=0;
    var v:u8 = ' ';
    var sw:u8 = ' ';

    var fps:u8 = 0;
    var fps_old:u8 = 0;

    var line2_count:u64=0;
    var line2_old:u64=0;
    
    var pix_line:u64 = 0;

    while(run3){
        v = file_buffer[k];
        // print("c {d} {any}\n", .{k,v});
        if( v == 'f'){
            sw = 'f';
        }
        if( v == 'h'){
            sw = 'p';
        }
        if( v == 'v'){
            sw = 'l';
        }

        if( v == '0' or v == '1'){
            if( sw == 'f'){
                try f.append(v);
                if( fps_old != v){
                    fps_old=v;
                    if( v == '1'){
                        fps+=1;
                        //print("--", .{});
                        //print("\n", .{});
                    }
                }
            }
            if( sw == 'p'){
                try p.append(v);
                pix_line += 1;
            }
            if( sw == 'l'){
                try l.append(v);
                if( line2_old != v){
                    line2_old=v;
                    if( v == '1'){
                        line2_count+=1;
                        //print("--", .{});
                        //print("\n", .{});
                        pix_line = 0;
                    }
                }
            }
            // print(": {c} {d} {c}\n", .{sw,k,v});
        }


        k+=1;
        if(k>file_buffer.len-1){
            run3=false;
        }
        if(fps>1){
            break;
        }
    }
    print("\n", .{});
    print("pix   count: {d}\n", .{k});
    print("pix   count: {d}\n", .{pix_line});
    print("frame_count: {d}\n", .{fps});
    print("lines : {d}\n", .{line2_count});
    print("\n", .{});


    

    const s21:u8 =0;
    const s2:u8 =0;


    const s10:i64 = @divFloor(std.time.milliTimestamp(), ms)-start;
    print("time: s1:{d} s2:{d} s21:{} s10:{d} sum:{d}", .{s1,s2,s10,s21,s1+s2+s10});
    print("\n", .{});
}

