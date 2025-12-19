"""
Tests for regex groups and backreferences.
"""

load("tests/utils.star", "run_suite")

def run_tests_groups():
    """Runs group tests."""
    cases = [
        # 3. Named Capture Groups
        ("(?P<fruit>orange)", "orange", {0: "orange", "fruit": "orange"}),
        ("(?P<a>\\d+)-(?P<b>\\d+)", "123-456", {0: "123-456", 1: "123", "a": "123", 2: "456", "b": "456"}),

        # 7. Non-capturing groups
        ("(?:orange)", "orange", {0: "orange"}),
        ("(?:orange)-(\\d+)", "orange-123", {0: "orange-123", 1: "123"}),
    ]
    run_suite("Group Tests", cases)
