"""Benchmarks for the Starlark regex engine comparing fast-path vs standard VM."""

load("//lib:re.bzl", "compile")

# buildifier: disable=print
def run_benchmark_group(n):
    cases = [
        ("Start-Anchored Match (^\\d+abc$)", r"^\d+abc$", "12345abc", "match"),
        ("End-Anchored Search (\\d+abc$)", r"\d+abc$", "prefix" * 10 + "123abc", "search"),
        ("Literal Skip Search (needle\\d+)", r"needle\d+", "haystack " * 10 + "needle999", "search"),
    ]

    for name, pattern, text, method in cases:
        p = compile(pattern)
        print("Benchmarking: %s" % name)
        if method == "match":
            for _ in range(n):
                p.match(text)
        else:
            for _ in range(n):
                p.search(text)

def run_benchmarks(n = 10000):
    print("--- Performance Benchmark (n=%d) ---" % n)
    run_benchmark_group(n)
    print("FINISHED_BENCHMARK")
    print("--- Done ---")
