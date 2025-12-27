"""
Tests for ungreedy loop optimization.
"""

load("@rules_testing//lib:unit_test.bzl", "unit_test")
load("//re:re.bzl", "compile", "search")
load("//re/private:constants.bzl", "OP_UNGREEDY_LOOP")

def _test_ungreedy_opt(env):
    # 1. Functional correctness
    cases = [
        ("a*?b", "aaab", "aaab"),
        ("a*?b", "b", "b"),
        ("[a-z]*?1", "abc1", "abc1"),
        (".*?a", "baaa", "ba"),  # Ungreedy loop stops at first 'a'
        ("a*?a", "aaaa", "a"),
    ]

    for pattern, text, expected in cases:
        m = search(pattern, text)
        env.expect.that_bool(m != None).equals(True)
        if m:
            env.expect.that_str(m.group(0)).equals(expected)

    # 2. Bytecode inspection
    patterns_to_check = [
        "a*?b",
        "[0-9]*?x",
        "(?i)a*?b",
    ]

    for p in patterns_to_check:
        compiled = compile(p)
        found = False
        for inst in compiled.bytecode:
            if inst[0] == OP_UNGREEDY_LOOP:
                found = True
                break
        env.expect.that_bool(found).equals(True)

def ungreedy_opt_test(name):
    unit_test(
        name = name,
        impl = _test_ungreedy_opt,
    )
