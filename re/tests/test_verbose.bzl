"""Tests for Verbose mode."""

load("@rules_testing//lib:unit_test.bzl", "unit_test")
load("//:re.bzl", "re")

def _verbose_test(env):
    # Test whitespace skipping
    p1 = re.compile(r" a b c ", re.X)
    env.expect.that_bool(p1.match("abc") != None).equals(True)
    env.expect.that_bool(p1.match(" a b c ") == None).equals(True)

    # Test comment skipping
    p2 = re.compile(r"""
        [+-]? # sign
        \d+   # digits
    """, re.VERBOSE)
    env.expect.that_bool(p2.fullmatch("+123") != None).equals(True)
    env.expect.that_bool(p2.fullmatch("456") != None).equals(True)
    env.expect.that_bool(p2.fullmatch("+ 123") == None).equals(True)

    # Test escaped whitespace and #
    p3 = re.compile(r"a\ b\#c", re.X)
    env.expect.that_bool(p3.match("a b#c") != None).equals(True)

    # Test inline flag (?x)
    p4 = re.compile(r"(?x) x y z ")
    env.expect.that_bool(p4.match("xyz") != None).equals(True)

def verbose_test(name):
    unit_test(
        name = name,
        impl = _verbose_test,
    )
