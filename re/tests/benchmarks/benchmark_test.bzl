"""Benchmark test for the Starlark regex engine."""

load("@rules_testing//lib:unit_test.bzl", "unit_test")
load("//re/tests/benchmarks:benchmarks.bzl", "run_benchmarks")

def _benchmark_test(_env):
    # Run benchmarks with a large number of iterations
    run_benchmarks(n = 1000)

def benchmark_test(name):
    unit_test(
        name = name,
        impl = _benchmark_test,
    )
