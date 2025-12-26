<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Public API for the Starlark regex engine.

<a id="compile"></a>

## compile

<pre>
load("@re.bzl//re:re.bzl", "compile")

compile(<a href="#compile-pattern">pattern</a>, <a href="#compile-flags">flags</a>)
</pre>

Compiles a regex pattern into a reusable object.

The returned object has 'search', 'match', and 'fullmatch' methods that work
like the top-level functions but with the pattern pre-compiled.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="compile-pattern"></a>pattern |  The regex pattern string.   |  none |
| <a id="compile-flags"></a>flags |  Regex flags (e.g. re.I, re.M, re.VERBOSE).   |  `0` |

**RETURNS**

A struct containing the compiled bytecode and methods:
- search(text): Scans text for a match. Returns a MatchObject or None.
- match(text): Checks for a match at the beginning of text. Returns a MatchObject or None.
- fullmatch(text): Checks for a match of the entire text. Returns a MatchObject or None.
- pattern: The pattern string.
- group_count: The number of capturing groups.

The MatchObject returned by these methods has the following members:
- group(n=0): Returns the string matched by group n (int or string name).
- groups(default=None): Returns a tuple of all captured groups.
- span(n=0): Returns the (start, end) tuple of the match for group n.
- start(n=0): Returns the start index of the match for group n.
- end(n=0): Returns the end index of the match for group n.
- string: The string passed to match/search.
- re: The compiled regex object.
- pos: The start position of the search.
- endpos: The end position of the search.
- lastindex: The integer index of the last matched capturing group.
- lastgroup: The name of the last matched capturing group.


<a id="findall"></a>

## findall

<pre>
load("@re.bzl//re:re.bzl", "findall")

findall(<a href="#findall-pattern">pattern</a>, <a href="#findall-text">text</a>, <a href="#findall-flags">flags</a>)
</pre>

Return all non-overlapping matches of pattern in string, as a list of strings.

If one or more groups are present in the pattern, return a list of groups.
Empty matches are included in the result.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="findall-pattern"></a>pattern |  The regex pattern string or a compiled regex object.   |  none |
| <a id="findall-text"></a>text |  The text to match against.   |  none |
| <a id="findall-flags"></a>flags |  Regex flags (only if pattern is a string).   |  `0` |

**RETURNS**

A list of matching strings or tuples of matching groups.


<a id="fullmatch"></a>

## fullmatch

<pre>
load("@re.bzl//re:re.bzl", "fullmatch")

fullmatch(<a href="#fullmatch-pattern">pattern</a>, <a href="#fullmatch-text">text</a>, <a href="#fullmatch-flags">flags</a>)
</pre>

Try to apply the pattern to the entire string.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="fullmatch-pattern"></a>pattern |  The regex pattern string or a compiled regex object.   |  none |
| <a id="fullmatch-text"></a>text |  The text to match against.   |  none |
| <a id="fullmatch-flags"></a>flags |  Regex flags (only if pattern is a string).   |  `0` |

**RETURNS**

A MatchObject containing the match results, or None if no match was found.
See `compile` for details on MatchObject.


<a id="match"></a>

## match

<pre>
load("@re.bzl//re:re.bzl", "match")

match(<a href="#match-pattern">pattern</a>, <a href="#match-text">text</a>, <a href="#match-flags">flags</a>)
</pre>

Try to apply the pattern at the start of the string.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="match-pattern"></a>pattern |  The regex pattern string or a compiled regex object.   |  none |
| <a id="match-text"></a>text |  The text to match against.   |  none |
| <a id="match-flags"></a>flags |  Regex flags (only if pattern is a string).   |  `0` |

**RETURNS**

A MatchObject containing the match results, or None if no match was found.
See `compile` for details on MatchObject.


<a id="search"></a>

## search

<pre>
load("@re.bzl//re:re.bzl", "search")

search(<a href="#search-pattern">pattern</a>, <a href="#search-text">text</a>, <a href="#search-flags">flags</a>)
</pre>

Scan through string looking for the first location where the regex pattern produces a match.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="search-pattern"></a>pattern |  The regex pattern string or a compiled regex object.   |  none |
| <a id="search-text"></a>text |  The text to match against.   |  none |
| <a id="search-flags"></a>flags |  Regex flags (only if pattern is a string).   |  `0` |

**RETURNS**

A MatchObject containing the match results, or None if no match was found.
See `compile` for details on MatchObject.


<a id="split"></a>

## split

<pre>
load("@re.bzl//re:re.bzl", "split")

split(<a href="#split-pattern">pattern</a>, <a href="#split-text">text</a>, <a href="#split-maxsplit">maxsplit</a>, <a href="#split-flags">flags</a>)
</pre>

Split the source string by the occurrences of the pattern, returning a list containing the resulting substrings.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="split-pattern"></a>pattern |  The regex pattern string or a compiled regex object.   |  none |
| <a id="split-text"></a>text |  The text to split.   |  none |
| <a id="split-maxsplit"></a>maxsplit |  The maximum number of splits to perform. If non-positive, there is no limit on the number of splits.   |  `0` |
| <a id="split-flags"></a>flags |  Regex flags (only if pattern is a string).   |  `0` |

**RETURNS**

A list of strings.


<a id="sub"></a>

## sub

<pre>
load("@re.bzl//re:re.bzl", "sub")

sub(<a href="#sub-pattern">pattern</a>, <a href="#sub-repl">repl</a>, <a href="#sub-text">text</a>, <a href="#sub-count">count</a>, <a href="#sub-flags">flags</a>)
</pre>

Return the string obtained by replacing the leftmost non-overlapping occurrences of the pattern in text by the replacement repl.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="sub-pattern"></a>pattern |  The regex pattern string or a compiled regex object.   |  none |
| <a id="sub-repl"></a>repl |  The replacement string or function.   |  none |
| <a id="sub-text"></a>text |  The text to search.   |  none |
| <a id="sub-count"></a>count |  The maximum number of pattern occurrences to replace. If non-positive, all occurrences are replaced.   |  `0` |
| <a id="sub-flags"></a>flags |  Regex flags (only if pattern is a string).   |  `0` |

**RETURNS**

The text with the replacements applied.


