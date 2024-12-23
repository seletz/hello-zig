const std = @import("std");

const CompileStep = struct {
    executable: *std.Build.Step.Compile,
    test_executable: *std.Build.Step.Compile,
};

fn compile_exe(b: *std.Build, target: std.Build.ResolvedTarget, mode: std.builtin.OptimizeMode, name: []const u8, path: std.Build.LazyPath) CompileStep {
    const exe = b.addExecutable(.{
        .name = name,
        .root_source_file = path,
        .target = target,
        .optimize = mode,
    });

    const exe_unit_tests = b.addTest(.{
        .root_source_file = path,
        .target = target,
        .optimize = mode,
    });

    return .{
        .executable = exe,
        .test_executable = exe_unit_tests,
    };
}

fn compile_sokol_exe(b: *std.Build, target: std.Build.ResolvedTarget, mode: std.builtin.OptimizeMode, name: []const u8, path: std.Build.LazyPath) CompileStep {
    const dep_sokol = std.Build.dependency(b, "sokol", .{
        .target = target,
        .optimize = mode,
    });
    const exe = b.addExecutable(.{
        .name = name,
        .root_source_file = path,
        .target = target,
        .optimize = mode,
    });

    exe.root_module.addImport("sokol", dep_sokol.module("sokol"));

    const exe_unit_tests = b.addTest(.{
        .root_source_file = path,
        .target = target,
        .optimize = mode,
    });
    exe_unit_tests.root_module.addImport("sokol", dep_sokol.module("sokol"));
    return .{
        .executable = exe,
        .test_executable = exe_unit_tests,
    };
}

pub fn build(b: *std.Build) void {
    const target = std.Build.standardTargetOptions(b, .{});
    const mode = std.Build.standardOptimizeOption(b, .{});

    const hello = compile_exe(b, target, mode, "hello-world", b.path("src/hello-world.zig"));
    b.installArtifact(hello.executable);

    const triangle = compile_sokol_exe(b, target, mode, "triangle", b.path("src/triangle.zig"));
    b.installArtifact(triangle.executable);

    const run_cmd = b.addRunArtifact(triangle.executable);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const run_exe_unit_tests = b.addRunArtifact(triangle.test_executable);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_exe_unit_tests.step);
}
