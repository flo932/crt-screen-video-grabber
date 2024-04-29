//const Builder = @import("std").build.Builder;
const std = @import("std");
const Builder = @import("std").Build;

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "crt-capture-zig",
        .root_source_file = .{ .path = "src/main.zig" },
        //.root_source_file = .{ .path = "src/main_popen.zig" },
        .target = target,
        .optimize = optimize,
    });
    if ( true ){ //target.isNativeOs() and target.getOsTag() == .linux) {
        // The SDL package doesn't work for Linux yet, so we rely on system
        // packages for now.
        exe.linkSystemLibrary("SDL2");
        exe.linkLibC();
    } else {
        const sdl_dep = b.dependency("sdl", .{
            .optimize = .ReleaseFast,
            .target = target,
        });
        exe.linkLibrary(sdl_dep.artifact("SDL2"));
    }

    b.installArtifact(exe);

    const run = b.step("run", "Run");
    const run_cmd = b.addRunArtifact(exe);
    run.dependOn(&run_cmd.step);
}
