"""
Utility functions for the Starlark regex engine tests using rules_testing.
"""

load("//re:re.bzl", "search")

def assert_match(env, pattern, text, expected_match):
    """Asserts that a pattern matches a text and returns the expected full match.

    Args:
      env: The test environment.
      pattern: The regex pattern.
      text: The text to search in.
      expected_match: The expected full match (group 0), or None if no match expected.
    """
    res = search(pattern, text)
    if expected_match == None:
        env.expect.that_bool(res == None).equals(True)
    elif res == None:
        # We expected a match but got None
        env.fail("Pattern: '%s', Text: '%s' expected match, got None" % (pattern, text))
    elif res.group(0) != expected_match:
        env.expect.that_str(res.group(0)).equals(expected_match)

def assert_eq(env, actual, expected, msg):
    """Asserts that two values are equal.

    Args:
      env: The test environment.
      actual: The actual value.
      expected: The expected value.
      msg: The message to display on failure.
    """
    if actual != expected:
        env.fail(msg + "\nExpected: %s\nActual: %s" % (expected, actual))

def run_suite(env, name, cases):
    """Runs a suite of regex tests.

    Args:
      env: The test environment.
      name: The name of the test suite.
      cases: A list of (pattern, text, expected_dict) tuples.
    """
    for pattern, text, expected in cases:
        res = search(pattern, text)
        if expected == None:
            if res != None:
                env.fail("Pattern: '%s', Text: '%s' expected None, got match '%s'" % (pattern, text, res.group(0)))
        elif res == None:
            env.fail("Pattern: '%s', Text: '%s' expected match, got None" % (pattern, text))
        else:
            for k, v in expected.items():
                val = res.group(k)
                if val != v:
                    env.fail("Pattern: '%s', Text: '%s' group %s mismatch. Expected '%s', got '%s'" % (pattern, text, k, v, val))
