const std = @import("std");

const c = @cImport({
    @cInclude("SDL2/SDL.h");
});
const assert = @import("std").debug.assert;
const print = std.debug.print;


const raster = @import("raster.zig");
const raster_digit = @import("raster_digit.zig");

pub fn Read(allocator:anytype,f:anytype,p:anytype,l:anytype,start_frame:anytype,init:u8) !void {


    // Get the path
    var path_buffer: [std.fs.MAX_PATH_BYTES]u8 = undefined;
    const path = try std.fs.realpath("../records/mirkon_wf150_mill_heidenhein_tnc150.txt", &path_buffer);

    // Open the file
    const file = try std.fs.openFileAbsolute(path, .{}); //.{ .read = true });
    defer file.close();

    // Read the contents
    const buffer_size = 1024*1024*27;
    const file_buffer = try file.readToEndAlloc(allocator, buffer_size);
    defer allocator.free(file_buffer);

    //print("c {any}", .{file_buffer.len});

    var k:u64=0;
    var v:u8 = ' ';
    var sw:u8 = ' ';

    var fps:u8 = 0;
    var fps_old:u8 = 0;

    var line2_count:u64=0;
    var line2_old:u64=0;

    var pix_change:u64 = 0;
    var pix_line:u64 = 0;
    var pix_line_old:u64 = 0;
    var i:u64 = 0;
    var i_ok:u8 = 0;
    while(true){

        if(fps>4){
           fps=0;
           break;
        }

        if( k >= file_buffer.len){
            k = 0;
            print("file restart #################################", .{});
        }

        i_ok=0;
        v = file_buffer[k];
        k+=1;

        if( v == 'f'){
            sw = 'f';
        }
        if( v == 'h'){
            sw = 'p';
        }
        if( v == 'v'){
            sw = 'l';
        }
        

        
        if( v != '0' and v != '1'){
            continue;
        }

        if( sw == 'f'){
            if( fps_old != v ){ 
                fps_old=v;
                if( v == '1'){
                    print("   fps:{} k:{},i:{} pix:{} pch:{} sfr:{}\n", .{fps,k,i,pix_line,pix_change,start_frame});
                    fps+=1;
                    pix_change = 0;
                }
            }
        }

        if(fps<1){
            continue;
        }
        if(fps < start_frame){
            continue;
        }

        if( init == 1){
            if( sw == 'f'){
                try f.append(v);
            }
            if( sw == 'p'){
                try p.append(v);
                pix_change += 1;
                pix_line += 1;
            }
            if( sw == 'l'){
                try l.append(v);
            }
            continue;
        }

        i+=1;
        if(i >= p.items.len ){
            i=0;
            continue;
        }
        //print("- i:{} {c},{c}\n", .{i,sw,v});

        if( sw == 'f'){
            f.items[i] = v;
            pix_change = 0;

        }else if( sw == 'p'){
            if(p.items[i] != v){
                pix_change += 1;
            }
            p.items[i] = v;

        }else if( sw == 'l'){
            l.items[i] = v;


            if( line2_old != v){
                line2_old=v;

                if( v == '1'){
                    line2_count+=1;
                    if(pix_line > 1){
                        pix_line_old = 100; //pix_line;
                    }
                    var j:u46 = 0;
                    if( pix_line_old >= 1){
                        while( j < pix_line_old-1){
                            if( f.items.len >= j){
                                break;
                            }
                            f.items[j] = 0;
                            p.items[j] = 1;
                            l.items[j] = 0;
                            j+=1;
                        }
                        if( j < f.items.len){
                            f.items[j] = '0';
                            p.items[j] = '0';
                            l.items[j] = '1';
                        }
                    }
                    pix_line = 0;
                }
            }
        }
       

    }


}

pub fn Clean(f:anytype,p:anytype,l:anytype) !void {
    for( p.items, 0..) | v,i| {
        _ = v;
        //f.items[i] = 0;   
        p.items[i] = '2';   
        //l.items[i] = 0;   
        _ = l;
        _ = f;
    }
}


pub fn main() !void {

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const ms:u64 = std.time.ms_per_s/100;
    print( "ms: {d}\n", .{ms});
    
    var start:i64 = @divFloor(std.time.milliTimestamp(), ms);

    
    var f = std.ArrayList(u8).init(allocator);
    defer f.deinit();
    var p = std.ArrayList(u8).init(allocator);
    defer p.deinit();
    var l = std.ArrayList(u8).init(allocator);
    defer l.deinit();

    const s1:i64 = @divFloor(std.time.milliTimestamp(), ms)-start;
    start = @divFloor(std.time.milliTimestamp(), ms);

    var start_frame:u64=0;
    _ = try Read(allocator,&f,&p,&l,start_frame,1);
    start_frame += 1;

    const s21:u8 =0;
    const s2:u8 =0;


    const s10:i64 = @divFloor(std.time.milliTimestamp(), ms)-start;
    print("time: s1:{d} s2:{d} s21:{} s10:{d} sum:{d}", .{s1,s2,s10,s21,s1+s2+s10});
    print("\n", .{});



    if (c.SDL_Init(c.SDL_INIT_VIDEO) != 0) {
        c.SDL_Log("Unable to initialize SDL: %s", c.SDL_GetError());
        return error.SDLInitializationFailed;
    }
    defer c.SDL_Quit();

    const screen = c.SDL_CreateWindow("VIRTUAL CRT SCREEN", c.SDL_WINDOWPOS_UNDEFINED, c.SDL_WINDOWPOS_UNDEFINED, 800, 640, c.SDL_WINDOW_OPENGL) orelse
        {
        c.SDL_Log("Unable to create window: %s", c.SDL_GetError());
        return error.SDLInitializationFailed;
    };
    defer c.SDL_DestroyWindow(screen);

    const renderer = c.SDL_CreateRenderer(screen, -1, 0) orelse {
        c.SDL_Log("Unable to create renderer: %s", c.SDL_GetError());
        return error.SDLInitializationFailed;
    };
    defer c.SDL_DestroyRenderer(renderer);



    var quit = false;
    c.SDL_RenderPresent(renderer);

    var line_old:u8 = ' ';
    var line_on: u8 = 0;
    var line_px: u64 = 0;
    var line_count: u64 = 0;
    var frame_nr:u64 = 0;
    var ix:u64 = 0;
    while (!quit) {
        line_count = 0;
        var event: c.SDL_Event = undefined;
        while (c.SDL_PollEvent(&event) != 0) {
            //print("{any}\n", .{event.type});
            switch (event.type) {
                c.SDL_QUIT => {
                    quit = true;
                },
                else => {},
            }
        }
        ix = 0;
        _ = c.SDL_RenderClear(renderer);
        _ = c.SDL_RenderDrawLine(renderer ,10,20,30,40);


        _ = c.SDL_SetRenderDrawColor(renderer, 0x10, 0x10, 0x10, 0xff);
        _ = c.SDL_RenderClear(renderer);

        var f5:u8 = ' ';
        var f5_old:u8 = ' ';
        var p5:u8 = ' ';
        var l5:u8 = ' ';

        var x:i32 = 0;
        var y:i32 = 0;
        
        var line_ok:u8 = 0;
        var rect2 = c.SDL_Rect{ .x = 0, .y = 0, .w = 1, .h = 2 };
        var rect3 = c.SDL_Rect{ .x = 0, .y = 0, .w = 3, .h = 3 };
        var rect10 = c.SDL_Rect{ .x = 0, .y = 0, .w = 2, .h = 2 };
        var fps_i:u64=0;

        var run5:bool = true;
        const force_line_brake:u32 = 788; // auto fill missing/blank lines
        
        //try Clean(&f,&p,&l);
        //start_frame = 0;
        //_ = try Read(allocator,&f,&p,&l,start_frame,0);
        //start_frame += 1;

        while(run5){
            while (c.SDL_PollEvent(&event) != 0) {
                //print("{any}\n", .{event.type});
                switch (event.type) {
                    c.SDL_QUIT => {
                        quit = true;
                    },
                    else => {},
                }
            }
            if(ix>=p.items.len){
                run5 = false;
                continue;
            } 
            if(ix>=f.items.len){
                run5 = false;
                continue;
            } 
            if(ix>=l.items.len){
                run5 = false;
                continue;
            } 

            f5 = f.items[ix];
            p5 = p.items[ix];
            l5 = l.items[ix];

            if( fps_i >= 2 and f5 == '1'){
                break;
            }
            if( f5 == '1'){
                if(f5_old != f5){
                    fps_i += 1;
                    //print("{d} \n\n", .{fps_i});
                }
            }
            if( f5 != f5_old){
                f5_old = f5;
            }
            if( l5 == '1'){
                if( line_old != l5){
                    line_on  = 1;
                    //print("px: {d} {d}\n", .{line_px,line_count});
                    if( line_px > force_line_brake and line_count >= 1){
                        y +=  @as(i32, @intCast(line_px / force_line_brake))*2;
                    }
                    line_px = 0;
                    line_count += 1;
                }
            }
            if( line_old != l5){
                line_old = l5;
            }

            if( line_on == 1){

                x = 0;
                y += 2;
                //print("{d} {d} {c} {c}\n", .{x,y,l5, p5});
                line_on  = 0;
            }
            rect2.x = x ;
            rect2.y = y ;

            if( p5 == '1'){
                _ = c.SDL_SetRenderDrawColor(renderer, 0, 0, 0, 0xff);
            }else if( p5 == '2'){
                _ = c.SDL_SetRenderDrawColor(renderer, 0, 100, 0, 0xff);
            }else{
                _ = c.SDL_SetRenderDrawColor(renderer, 0xaa, 0xaa, 0xaa, 0xff);
                line_ok = 1;
            }
            line_px += 1;
            _ = c.SDL_RenderFillRect(renderer, &rect2);
            x+=1;
            ix+=2;

            rect3.y+=7;
            if(rect3.y > 400){
                rect3.y = 0;
                rect3.x+=7;
            }
        }

        _ = c.SDL_SetRenderDrawColor(renderer, 250, 0, 0, 0xff);

        rect10.x = 10;
        rect10.y = 600;
        try raster.raster_txt(renderer,rect10,"FRAME:");
        rect10.x += 14*6;
        try raster_digit.raster_int(renderer,rect10,frame_nr);
        rect10.x = 10;
        rect10.y += 16;
        try raster.raster_txt(renderer,rect10,"hallo O");

        c.SDL_RenderPresent(renderer);

        //c.SDL_Delay(30); // 0.5 sec
        frame_nr+=1;
        print("frame:{} len:{d} start:{d}\n\n", .{frame_nr,p.items.len/787,start_frame});
    }
}
