# regexlib

A lightweight, pure Starlark implementation of a Regex Engine.

## Overview

`regexlib` provides a Thompson NFA-based regex engine designed for Starlark environments (like Bazel) where the standard `re` module is unavailable. It supports a significant subset of RE2 syntax and is optimized for correctness and ease of integration.

## Syntax Reference

`regexlib` supports a significant subset of RE2 syntax. Below is a detailed reference of supported features.

### Single-character expressions
| Syntax | Description |
| :--- | :--- |
| `.` | any character, possibly including newline (s=true) |
| `[xyz]` | character class |
| `[^xyz]` | negated character class |
| `\d` | Perl character class (digits) |
| `\D` | negated Perl character class |
| `[[:alpha:]]` | ASCII character class |
| `[[:^alpha:]]` | negated ASCII character class |

### Composites
| Syntax | Description |
| :--- | :--- |
| `xy` | `x` followed by `y` |
| `x\|y` | `x` or `y` (prefer `x`) |

### Repetitions
| Syntax | Description |
| :--- | :--- |
| `x*` | zero or more `x`, prefer more |
| `x+` | one or more `x`, prefer more |
| `x?` | zero or one `x`, prefer one |
| `x{n,m}` | `n` or `n`+1 or ... or `m` `x`, prefer more |
| `x{n,}` | `n` or more `x`, prefer more |
| `x{n}` | exactly `n` `x` |
| `x*?` | zero or more `x`, prefer fewer |
| `x+?` | one or more `x`, prefer fewer |
| `x??` | zero or one `x`, prefer zero |
| `x{n,m}?` | `n` or ... or `m` `x`, prefer fewer |
| `x{n,}?` | `n` or more `x`, prefer fewer |
| `x{n}?` | exactly `n` `x` |

### Grouping
| Syntax | Description |
| :--- | :--- |
| `(re)` | numbered capturing group (submatch) |
| `(?P<name>re)` | named & numbered capturing group (submatch) |
| `(?<name>re)` | named & numbered capturing group (submatch) |
| `(?:re)` | non-capturing group |
| `(?flags)` | set flags within current group; non-capturing |
| `(?flags:re)` | set flags during re; non-capturing |

### Flags
| Flag | Description |
| :--- | :--- |
| `i` | case-insensitive (default false) |
| `m` | multi-line mode: `^` and `$` match begin/end line (default false) |
| `s` | let `.` match `\n` (default false) |
| `U` | ungreedy: swap meaning of `x*` and `x*?`, `x+` and `x+?`, etc (default false) |

### Empty strings (Anchors)
| Syntax | Description |
| :--- | :--- |
| `^` | at beginning of text or line (m=true) |
| `$` | at end of text or line (m=true) |
| `\A` | at beginning of text |
| `\z` | at end of text |
| `\b` | at ASCII word boundary |
| `\B` | not at ASCII word boundary |

### Escape sequences
| Syntax | Description |
| :--- | :--- |
| `\a` | bell (≡ `\007`) |
| `\f` | form feed (≡ `\014`) |
| `\t` | horizontal tab (≡ `\011`) |
| `\n` | newline (≡ `\012`) |
| `\r` | carriage return (≡ `\015`) |
| `\v` | vertical tab character (≡ `\013`) |
| `\123` | octal character code (up to three digits) |
| `\x7F` | hex character code (exactly two digits) |
| `\x{7F}` | hex character code |
| `\Q...\E` | literal text `...` even if `...` has punctuation |

### ASCII Character Classes
| Syntax | Description |
| :--- | :--- |
| `[[:alnum:]]` | alphanumeric (≡ `[0-9A-Za-z]`) |
| `[[:alpha:]]` | alphabetic (≡ `[A-Za-z]`) |
| `[[:ascii:]]` | ASCII (≡ `[\x00-\x7F]`) |
| `[[:blank:]]` | blank (≡ `[\t ]`) |
| `[[:cntrl:]]` | control (≡ `[\x00-\x1F\x7F]`) |
| `[[:digit:]]` | digits (≡ `[0-9]`) |
| `[[:graph:]]` | graphical (≡ `[!-~]`) |
| `[[:lower:]]` | lower case (≡ `[a-z]`) |
| `[[:print:]]` | printable (≡ `[ -~]`) |
| `[[:punct:]]` | punctuation (≡ `[!-/:-@[-` + "`" + `{-~]`) |
| `[[:space:]]` | whitespace (≡ `[\t\n\v\f\r ]`) |
| `[[:upper:]]` | upper case (≡ `[A-Z]`) |
| `[[:word:]]` | word characters (≡ `[0-9A-Za-z_]`) |
| `[[:xdigit:]]` | hex digit (≡ `[0-9A-Fa-f]`) |

## Compatibility

`regexlib` aims for high compatibility with [RE2 syntax](https://github.com/google/re2/blob/main/doc/syntax.txt). Most non-Unicode features are supported.

### Key Differences
- **Unicode**: Currently, only ASCII/UTF-8 byte-level matching is supported. Unicode character classes (`\p{...}`) are not implemented.
- **Backreferences**: Not supported (consistent with RE2's linear-time guarantee).
- **Lookarounds**: Not supported.

## Installation

Add the following to your `MODULE.bazel`:

```python
bazel_dep(name = "regexlib", version = "0.1.0")
```

## Usage

```python
load("@regexlib//lib:re.bzl", "search", "match", "findall", "sub", "split")

# Search for a pattern
m = search(r"(\w+)=(\d+)", "key=123")
if m:
    print(m.group(1)) # "key"
    print(m.group(2)) # "123"

# Replace matches
result = sub(r"a+", "b", "abaac") # "bbbc"
```

## Development

### Running Tests

```bash
bazel test //lib/tests:all_tests
```

## License

Apache 2.0
