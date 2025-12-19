load("re.bzl", "matches")

def assert_match(pattern, text, expected_match):
    res = matches(pattern, text)
    if expected_match == None:
        if res != None:
            print("FAIL: '%s' on '%s' expected None, got %s" % (pattern, text, res))

        # else:
        #     print("PASS: '%s' on '%s'" % (pattern, text))

    else:
        if res == None:
            print("FAIL: '%s' on '%s' expected match, got None" % (pattern, text))
        elif res[0] != expected_match:
            print("FAIL: '%s' on '%s' expected '%s', got '%s'" % (pattern, text, expected_match, res[0]))

        # else:
        #     print("PASS: '%s' on '%s'" % (pattern, text))

def assert_eq(actual, expected, msg):
    if actual != expected:
        print("FAIL: %s: Expected %s, Got %s" % (msg, expected, actual))

    # else:
    #     print("PASS: %s" % msg)

def run_suite(name, cases):
    print("--- Running %s ---" % name)
    for pattern, text, expected in cases:
        res = matches(pattern, text)
        status = "FAIL"

        if res == None and expected == None:
            status = "PASS"
        elif res != None and expected != None:
            match = True
            for k, v in expected.items():
                if k not in res or res[k] != v:
                    match = False
                    break
            if match:
                status = "PASS"

        if status == "FAIL":
            print("[FAIL] Pattern: '%s', Text: '%s'" % (pattern, text))
            print("   Expected: %s" % expected)
            print("   Got:      %s" % res)
