const std = @import("std");

const c = @cImport({
    @cInclude("SDL2/SDL.h");
});
const assert = @import("std").debug.assert;
const print = std.debug.print;

pub fn draw_quest(renderer:anytype,rect:anytype) !void {
    //rect10.y += 10;
    const l1 = [_]u8{  //undefined;
                0,0,1,1,0,
                0,1,0,0,1,
                0,0,0,0,1,
                0,0,0,1,0,
                0,0,0,0,0,
                0,0,0,1,0,
    };
    try  draw_mask(renderer,rect,l1);
}
pub fn draw_A(renderer:anytype,rect:anytype) !void {
    //rect10.y += 10;
    const l1 = [_]u8{  //undefined;
                0,0,1,0,0,
                0,1,0,1,0,
                1,0,0,0,1,
                1,1,1,1,1,
                1,0,0,0,1,
                1,0,0,0,1,
    };
    try  draw_mask(renderer,rect,l1);
}
pub fn draw_F(renderer:anytype,rect:anytype) !void {
    //rect10.y += 10;
    const l1 = [_]u8{  //undefined;
                1,1,1,1,0,
                1,0,0,0,0,
                1,1,1,0,0,
                1,0,0,0,0,
                1,0,0,0,0,
                1,0,0,0,0,
    };
    try  draw_mask(renderer,rect,l1);
}
pub fn draw_E(renderer:anytype,rect:anytype) !void {
    //rect10.y += 10;
    const l1 = [_]u8{  //undefined;
                1,1,1,1,0,
                1,0,0,0,0,
                1,1,1,0,0,
                1,0,0,0,0,
                1,0,0,0,0,
                1,1,1,1,0,
    };
    try  draw_mask(renderer,rect,l1);
}
pub fn draw_dpoint(renderer:anytype,rect:anytype) !void {
    //rect10.y += 10;
    const l1 = [_]u8{  //undefined;
                0,0,0,0,0,
                0,0,1,0,0,
                0,0,0,0,0,
                0,0,0,0,0,
                0,0,1,0,0,
                0,0,0,0,0,
    };
    try  draw_mask(renderer,rect,l1);
}
pub fn draw_R(renderer:anytype,rect:anytype) !void {
    //rect10.y += 10;
    const l1 = [_]u8{  //undefined;
                1,1,1,0,0,
                1,0,0,1,0,
                1,1,1,0,0,
                1,0,1,0,0,
                1,0,0,1,0,
                1,0,0,1,0,
    };
    try  draw_mask(renderer,rect,l1);
}
pub fn draw_H(renderer:anytype,rect:anytype) !void {
    //rect10.y += 10;
    const l1 = [_]u8{  //undefined;
                1,0,0,0,1,
                1,0,0,0,1,
                1,0,0,0,1,
                1,1,1,1,1,
                1,0,0,0,1,
                1,0,0,0,1,
    };
    try  draw_mask(renderer,rect,l1);
}
pub fn draw_a(renderer:anytype,rect:anytype) !void {
    //rect10.y += 10;
    const l1 = [_]u8{  //undefined;
                0,0,0,0,0,
                0,1,1,1,0,
                0,0,0,0,1,
                0,1,1,1,1,
                1,0,0,0,1,
                0,1,1,1,1,
    };
    try  draw_mask(renderer,rect,l1);
}
pub fn draw_M(renderer:anytype,rect:anytype) !void {
    //rect10.y += 10;
    const l1 = [_]u8{  //undefined;
                1,0,0,0,1,
                1,1,0,1,1,
                1,0,1,0,1,
                1,0,0,0,1,
                1,0,0,0,1,
                1,0,0,0,1,
    };
    try  draw_mask(renderer,rect,l1);
}
pub fn draw_l(renderer:anytype,rect:anytype) !void {
    //rect10.y += 10;
    const l1 = [_]u8{  //undefined;
                0,1,0,0,0,
                0,1,0,0,0,
                0,1,0,0,0,
                0,1,0,0,0,
                0,1,0,0,0,
                0,0,1,1,0,
    };
    try  draw_mask(renderer,rect,l1);
}
pub fn draw_L(renderer:anytype,rect:anytype) !void {
    //rect10.y += 10;
    const l1 = [_]u8{  //undefined;
                0,1,0,0,0,
                0,1,0,0,0,
                0,1,0,0,0,
                0,1,0,0,0,
                0,1,0,0,0,
                0,1,1,1,1,
    };
    try  draw_mask(renderer,rect,l1);
}
pub fn draw_o(renderer:anytype,rect:anytype) !void {
    //rect10.y += 10;
    const l1 = [_]u8{  //undefined;
                0,0,0,0,0,
                0,0,0,0,0,
                0,1,1,1,0,
                1,0,0,0,1,
                1,0,0,0,1,
                0,1,1,1,0,
    };
    try  draw_mask(renderer,rect,l1);
}
pub fn draw_space(renderer:anytype,rect:anytype) !void {
    //rect10.y += 10;
    const l1 = [_]u8{  //undefined;
                0,0,0,0,0,
                0,0,0,0,0,
                0,0,0,0,0,
                0,0,0,0,0,
                0,0,0,0,0,
                0,0,0,0,0,
    };
    try  draw_mask(renderer,rect,l1);
}
pub fn draw_mask(renderer:anytype,rect:anytype,mask:anytype) !void {
    var rect10 = c.SDL_Rect{ .x = 0, .y = 0, .w = 2, .h = 2 };
    rect10.x = rect.x;
    rect10.y = rect.y;
    rect10.w = rect.w;
    rect10.h = rect.h;
    const l1 = mask;
    var i:u32 = 0;
    var x:u8 = 0;
    var y:u8 = 0;
    //print( "a: {d} {d} {d} {d}\n", .{i,l1.len,x,y});
    while(i < l1.len ){
        rect10.x = @as(c_int,rect.x)+@as(c_int,x);
        rect10.y = rect.y+y;
        rect10.w = rect.w;
        rect10.h = rect.h;

        //print( "   a: {d} {d} {d}\n", .{i,x,y});
        if( l1[i] == 1){
            _ = c.SDL_RenderFillRect(renderer, &rect10);
        }
        i+=1;
        x+=2;
        if( @mod(x,5) == 0){
            x=0;
            y+=2;
        }
    }
}


pub fn raster_txt(renderer:anytype,rect:anytype,value:anytype) !void {
    print("\nraster_txt: {any}", .{value});

    var rect10 = c.SDL_Rect{ .x = 0, .y = 0, .w = 2, .h = 2 };
    rect10.x = rect.x;
    rect10.y = rect.y;
    rect10.w = rect.w;
    rect10.h = rect.h;
    // var buf: [20]u8 = undefined;
    const buf = value;
    //_ = try intToString(value,&buf);
    for( buf, 0..) | v,i| {
        _ = i;
        if( v == '1'){
        }else if( v == 104 or v == 'H'){
            try draw_H(renderer,rect10);
        }else if( v == 70 or v == 'F'){
            try draw_F(renderer,rect10);
        }else if( v == 'R'){
            try draw_R(renderer,rect10);
        }else if( v == 'A'){
            try draw_A(renderer,rect10);
        }else if( v == ':'){
            try draw_dpoint(renderer,rect10);
        }else if( v == 'M'){
            try draw_M(renderer,rect10);
        }else if( v == 'E'){
            try draw_E(renderer,rect10);
        }else if( v == 'a'){
            try draw_a(renderer,rect10);
        }else if( v == 'l'){
            try draw_l(renderer,rect10);
        }else if( v == 'o'){
            try draw_o(renderer,rect10);
        }else if( v == ' '){
            try draw_space(renderer,rect10);
        }else if( v == 'O'){
        }else {
            try draw_quest(renderer,rect10);
        }
        rect10.x +=12;
    }
}

