"""Smoke test rule for re.bzl"""

load("@re.bzl//:re.bzl", "re")

def _smoke_test_impl(ctx):
    prog = re.compile("a*b")
    if not prog.match("aaaab"):
        fail("re.compile or match failed")

    # Create a dummy executable script that does nothing but exit 0.
    is_windows = ctx.target_platform_has_constraint(ctx.attr._windows[platform_common.ConstraintValueInfo])
    if is_windows:
        executable = ctx.actions.declare_file(ctx.label.name + ".bat")
        ctx.actions.write(
            output = executable,
            content = "@exit /b 0\r\n",
            is_executable = True,
        )
    else:
        executable = ctx.actions.declare_file(ctx.label.name + ".sh")
        ctx.actions.write(
            output = executable,
            content = "#!/usr/bin/env bash\nexit 0\n",
            is_executable = True,
        )

    return [DefaultInfo(executable = executable)]

smoke_test = rule(
    implementation = _smoke_test_impl,
    test = True,
    attrs = {
        "_windows": attr.label(default = "@platforms//os:windows"),
    },
)
