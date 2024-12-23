const std = @import("std");
const assert = std.debug.assert;
const builtin = @import("builtin");

const zig_version = std.SemanticVersion{
    .major = 0,
    .minor = 13,
    .patch = 0,
};
comptime {
    const zig_version_eq = zig_version.major == builtin.zig_version.major and
        zig_version.minor == builtin.zig_version.minor and
        zig_version.patch == builtin.zig_version.patch;
    if (!zig_version_eq) {
        @compileError(std.fmt.comptimePrint(
            "unsupported zig version: expected {}, found {}",
            .{ zig_version, builtin.zig_version },
        ));
    }
}

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{ .preferred_optimize_mode = .ReleaseSafe });

    // Top-level steps you can invoke on the command line.
    const build_steps = .{
        .check = b.step("check", "Check if Hecher compiles"),
        .fuzz = b.step("fuzz", "Run fuzzers"),
        .run = b.step("run", "Run Hecher"),
        .@"test" = b.step("test", "Run all tests"),
    };
}
