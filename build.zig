const std = @import("std");
const Build = std.Build;
const OptimizeMode = std.builtin.OptimizeMode;

pub fn build(b: *Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const dep_sokol = b.dependency("sokol", .{
        .target = target,
        .optimize = optimize,
    });
    const hello = b.addExecutable(.{
        .name = "triangle",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/triangle.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{
                    .name = "sokol",
                    .module = dep_sokol.module("sokol"),
                },
            },
        }),
    });
    b.installArtifact(hello);
    const run = b.addRunArtifact(hello);
    b.step("run", "Run triangle").dependOn(&run.step);
}