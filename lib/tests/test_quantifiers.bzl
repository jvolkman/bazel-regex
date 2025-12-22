"""
Tests for regex quantifiers.
"""

load("@bazel_skylib//lib:unittest.bzl", "unittest")
load("//lib/tests:utils.bzl", "run_suite")

def _test_quantifiers_impl(ctx):
    env = unittest.begin(ctx)
    run_tests_quantifiers(env)
    return unittest.end(env)

quantifiers_test = unittest.make(_test_quantifiers_impl)

def run_tests_quantifiers(env):
    """Runs quantifier tests.

    Args:
      env: The test environment.
    """
    cases = [
        # 1. Basic Greedy vs Lazy
        ("a{2,4}", "aa", {0: "aa"}),
        ("a{2,4}", "aaa", {0: "aaa"}),
        ("a{2,4}", "aaaa", {0: "aaaa"}),
        ("a{2,4}", "aaaaa", {0: "aaaa"}),
        ("a{2,4}?", "aaaaa", {0: "aa"}),

        # 2. Lazy vs Greedy in Context
        ("<.*?>", "<tag>content</tag>", {0: "<tag>"}),
        ("<.*>", "<tag>content</tag>", {0: "<tag>content</tag>"}),

        # 3. Repeat Range Edge Cases
        ("a{0,}", "", {0: ""}),
        ("a{0,}", "aaa", {0: "aaa"}),
        ("a{2,}", "a", None),
        ("a{2,}", "aa", {0: "aa"}),
        ("a{2,}", "aaa", {0: "aaa"}),
        ("a{,2}", "aaa", {0: "aa"}),
        ("a{,2}", "a", {0: "a"}),

        # 4. Group Quantifiers
        ("(ab){2}", "abab", {0: "abab", 1: "ab"}),
        ("(abc)?def", "abcdef", {0: "abcdef", 1: "abc"}),
        ("(abc)?def", "def", {0: "def"}),
        ("(a+)+", "aaaaa", {0: "aaaaa", 1: "aaaaa"}),

        # 5. Stress and Backtracking
        ("a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa", "aaaaaaaaaa", {0: "aaaaaaaaaa"}),
        ("a{100}", "a" * 100, {0: "a" * 100}),
        ("a{100}", "a" * 99, None),
    ]
    run_suite(env, "Quantifier Tests", cases)
