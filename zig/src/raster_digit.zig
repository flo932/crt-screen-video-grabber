
const std = @import("std");

const c = @cImport({
    @cInclude("SDL2/SDL.h");
});
const assert = @import("std").debug.assert;
const print = std.debug.print;


pub fn draw_r1( renderer:anytype,rect:anytype) !void {
    var rect10 = c.SDL_Rect{ .x = 0, .y = 0, .w = 2, .h = 2 };
    rect10.x = rect.x;
    rect10.y = rect.y;
    rect10.w = rect.w;
    rect10.h = rect.h;
    rect10.x += 6;
    _ = c.SDL_RenderFillRect(renderer, &rect10);
    rect10.y += 2;
    _ = c.SDL_RenderFillRect(renderer, &rect10);
    rect10.y += 2;
    _ = c.SDL_RenderFillRect(renderer, &rect10);
    
}
pub fn draw_r2( renderer:anytype,rect:anytype) !void {
    var rect10 = c.SDL_Rect{ .x = 0, .y = 0, .w = 2, .h = 2 };
    rect10.x = rect.x;
    rect10.y = rect.y;
    rect10.w = rect.w;
    rect10.h = rect.h;
    rect10.x += 6;
    rect10.y += 6;
    _ = c.SDL_RenderFillRect(renderer, &rect10);
    rect10.y += 2;
    _ = c.SDL_RenderFillRect(renderer, &rect10);
    rect10.y += 2;
    _ = c.SDL_RenderFillRect(renderer, &rect10);
        
}

pub fn draw_l1( renderer:anytype,rect:anytype) !void {
    var rect10 = c.SDL_Rect{ .x = 0, .y = 0, .w = 2, .h = 2 };
    rect10.x = rect.x;
    rect10.y = rect.y;
    rect10.w = rect.w;
    rect10.h = rect.h;
    //rect10.x += 6;
    _ = c.SDL_RenderFillRect(renderer, &rect10);
    rect10.y += 2;
    _ = c.SDL_RenderFillRect(renderer, &rect10);
    rect10.y += 2;
    _ = c.SDL_RenderFillRect(renderer, &rect10);
    
}
pub fn draw_l2( renderer:anytype,rect:anytype) !void {
    var rect10 = c.SDL_Rect{ .x = 0, .y = 0, .w = 2, .h = 2 };
    rect10.x = rect.x;
    rect10.y = rect.y;
    rect10.w = rect.w;
    rect10.h = rect.h;
    rect10.y += 6;
    //rect10.x += 6;
    _ = c.SDL_RenderFillRect(renderer, &rect10);
    rect10.y += 2;
    _ = c.SDL_RenderFillRect(renderer, &rect10);
    rect10.y += 2;
    _ = c.SDL_RenderFillRect(renderer, &rect10);
     
}
pub fn draw_h1( renderer:anytype,rect:anytype) !void {
    var rect10 = c.SDL_Rect{ .x = 0, .y = 0, .w = 2, .h = 2 };
    rect10.x = rect.x;
    rect10.y = rect.y;
    rect10.w = rect.w;
    rect10.h = rect.h;
    _ = c.SDL_RenderFillRect(renderer, &rect10);
    rect10.x += 2;
    _ = c.SDL_RenderFillRect(renderer, &rect10);
    rect10.x += 2;
    _ = c.SDL_RenderFillRect(renderer, &rect10);
    rect10.x += 2;
    _ = c.SDL_RenderFillRect(renderer, &rect10);
}
pub fn draw_h2( renderer:anytype,rect:anytype) !void {
    var rect10 = c.SDL_Rect{ .x = 0, .y = 0, .w = 2, .h = 2 };
    rect10.x = rect.x;
    rect10.y = rect.y;
    rect10.w = rect.w;
    rect10.h = rect.h;
    rect10.y += 5;
    try draw_h1( renderer,rect10);
}
pub fn draw_h3( renderer:anytype,rect:anytype) !void {
    var rect10 = c.SDL_Rect{ .x = 0, .y = 0, .w = 2, .h = 2 };
    rect10.x = rect.x;
    rect10.y = rect.y;
    rect10.w = rect.w;
    rect10.h = rect.h;
    rect10.y += 10;
    try draw_h1( renderer,rect10);
}
        

pub fn draw_zerro( renderer:anytype,rect:anytype) !void {
    var rect10 = c.SDL_Rect{ .x = 0, .y = 0, .w = 2, .h = 2 };
    rect10.x = rect.x;
    rect10.y = rect.y;
    rect10.w = rect.w;
    rect10.h = rect.h;
    try draw_h1( renderer,rect10);
    try draw_h3( renderer,rect10);

    try draw_r1( renderer,rect10);
    try draw_r2( renderer,rect10);
    try draw_l1( renderer,rect10);
    try draw_l2( renderer,rect10);
}

pub fn draw_one( renderer:anytype,rect:anytype) !void {
    var rect10 = c.SDL_Rect{ .x = 0, .y = 0, .w = 2, .h = 2 };
    rect10.x = rect.x;
    rect10.y = rect.y;
    rect10.w = rect.w;
    rect10.h = rect.h;
    try draw_r1( renderer,rect10);
    try draw_r2( renderer,rect10);

    rect10.x = rect.x;
    rect10.y = rect.y;
    rect10.x += 6;
    rect10.x -= 2;
    rect10.y += 1;
    _ = c.SDL_RenderFillRect(renderer, &rect10);
    rect10.x -= 2;
    rect10.y += 1;
    _ = c.SDL_RenderFillRect(renderer, &rect10);
    //rect10.x -= 2;
    //rect10.y += 1;
    //_ = c.SDL_RenderFillRect(renderer, &rect10);
}
pub fn draw_two( renderer:anytype,rect:anytype) !void {
    var rect10 = c.SDL_Rect{ .x = 0, .y = 0, .w = 2, .h = 2 };
    rect10.x = rect.x;
    rect10.y = rect.y;
    rect10.w = rect.w;
    rect10.h = rect.h;

    try draw_r1( renderer,rect10);
    try draw_h1( renderer,rect10);
    try draw_h2( renderer,rect10);
    try draw_h3( renderer,rect10);
    try draw_l2( renderer,rect10);


}

pub fn draw_three( renderer:anytype,rect:anytype) !void {
    var rect10 = c.SDL_Rect{ .x = 0, .y = 0, .w = 2, .h = 2 };
    rect10.x = rect.x;
    rect10.y = rect.y;
    rect10.w = rect.w;
    rect10.h = rect.h;

    try draw_r1( renderer,rect10);
    try draw_r2( renderer,rect10);
    try draw_h1( renderer,rect10);
    try draw_h2( renderer,rect10);
    try draw_h3( renderer,rect10);
}
pub fn draw_four( renderer:anytype,rect:anytype) !void {
    var rect10 = c.SDL_Rect{ .x = 0, .y = 0, .w = 2, .h = 2 };
    rect10.x = rect.x;
    rect10.y = rect.y;
    rect10.w = rect.w;
    rect10.h = rect.h;
    try draw_h2( renderer,rect10);
    try draw_l1( renderer,rect10);
    try draw_r1( renderer,rect10);
    try draw_r2( renderer,rect10);

}
pub fn draw_five( renderer:anytype,rect:anytype) !void {
    var rect10 = c.SDL_Rect{ .x = 0, .y = 0, .w = 2, .h = 2 };
    rect10.x = rect.x;
    rect10.y = rect.y;
    rect10.w = rect.w;
    rect10.h = rect.h;
    try draw_h1( renderer,rect10);
    try draw_h2( renderer,rect10);
    try draw_h3( renderer,rect10);
    try draw_l1( renderer,rect10);
    try draw_r2( renderer,rect10);
}
pub fn draw_six( renderer:anytype,rect:anytype) !void {
    var rect10 = c.SDL_Rect{ .x = 0, .y = 0, .w = 2, .h = 2 };
    rect10.x = rect.x;
    rect10.y = rect.y;
    rect10.w = rect.w;
    rect10.h = rect.h;
    try draw_r2( renderer,rect10);
    try draw_l1( renderer,rect10);
    try draw_l2( renderer,rect10);
    try draw_h1( renderer,rect10);
    try draw_h2( renderer,rect10);
    try draw_h3( renderer,rect10);
}

pub fn draw_seven( renderer:anytype,rect:anytype) !void {
    var rect10 = c.SDL_Rect{ .x = 0, .y = 0, .w = 2, .h = 2 };
    rect10.x = rect.x;
    rect10.y = rect.y;
    rect10.w = rect.w;
    rect10.h = rect.h;
    try draw_h1( renderer,rect10);
    try draw_r1( renderer,rect10);
    try draw_r2( renderer,rect10);
}


pub fn draw_eigth( renderer:anytype,rect:anytype) !void {
    var rect10 = c.SDL_Rect{ .x = 0, .y = 0, .w = 2, .h = 2 };
    rect10.x = rect.x;
    rect10.y = rect.y;
    rect10.w = rect.w;
    rect10.h = rect.h;

    try draw_r1( renderer,rect10);
    try draw_r2( renderer,rect10);
    try draw_l1( renderer,rect10);
    try draw_l2( renderer,rect10);
    try draw_h1( renderer,rect10);
    try draw_h2( renderer,rect10);
    try draw_h3( renderer,rect10);
}
pub fn draw_nine( renderer:anytype,rect:anytype) !void {
    var rect10 = c.SDL_Rect{ .x = 0, .y = 0, .w = 2, .h = 2 };
    rect10.x = rect.x;
    rect10.y = rect.y;
    rect10.w = rect.w;
    rect10.h = rect.h;

    try draw_r1( renderer,rect10);
    try draw_r2( renderer,rect10);
    try draw_l1( renderer,rect10);
    try draw_h1( renderer,rect10);
    try draw_h2( renderer,rect10);
    try draw_h3( renderer,rect10);
}

fn intToString(int: anytype, buf: []u8) ![]const u8 {
    return try std.fmt.bufPrint(buf, "{}", .{int});
}
pub fn raster_int(renderer:anytype,rect:anytype,value:anytype) !void {
    //print("test: {}", .{value});

    var rect10 = c.SDL_Rect{ .x = 0, .y = 0, .w = 2, .h = 2 };
    rect10.x = rect.x;
    rect10.y = rect.y;
    rect10.w = rect.w;
    rect10.h = rect.h;
    var buf: [20]u8 = undefined;

    _ = try intToString(value,&buf);
    for( buf, 0..) | v,i| {
        _ = i;
        if( v == '1'){
            try draw_one(renderer,rect10);
        }else if( v == '2'){
            try draw_two(renderer,rect10);
        }else if( v == '3'){
            try draw_three(renderer,rect10);
        }else if( v == '4'){
            try draw_four(renderer,rect10);
        }else if( v == '5'){
            try draw_five(renderer,rect10);
        }else if( v == '6'){
            try draw_six(renderer,rect10);
        }else if( v == '7'){
            try draw_seven(renderer,rect10);
        }else if( v == '8'){
            try draw_eigth(renderer,rect10);
        }else if( v == '9'){
            try draw_nine(renderer,rect10);
        }else if( v == '0'){
            try draw_zerro(renderer,rect10);
        }
        rect10.x +=12;
    }
}

