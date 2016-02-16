REBOL [
	Title:   "Generates Red equal? tests"
	Author:  "Peter W A Wood"
	File: 	 %make-strict-equal-auto-test.r
	Version: 0.1.0
	Tabs:	 4
	Rights:  "Copyright (C) 2013-2016 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/red/red/blob/origin/BSD-3-License.txt"
]

;; initialisations 

make-dir %auto-tests/
infix-file: %auto-tests/infix-strict-equal-auto-test.red
prefix-file: %auto-tests/strict-equal-auto-test.red

test-src: {
Red [
	Title:   "Red infix or prefix equal test script"
	Author:  "Nenad Rakocevic & Peter W A Wood"
	File: 	 ***FILE***
	Tabs:	 4
	Rights:  "Copyright (C) 2011-2016 Nenad Rakocevic & Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

comment {  This file is generated by make-strict-equal-auto-test.r
  Do not edit this file directly.
}

;make-length:***MAKELENGTH***           

#include  %../../../../quick-test/quick-test.red
}

;;functions

group-title: ""                         ;; title of current group
group-test-no: 0                        ;; number of current test in group

add-strict-equal-test: func [
  expected [string!]
  actual   [string!]
][
  add-test
  append infix-src join {--assert } [expected " == " actual newline]
  append prefix-src join {--assert strict-equal? } [expected " " actual newline]
]

add-strict-equal-test-with-init: func [
	init [string!]
	expected [string!]
	actual   [string!]
][
  add-test
  append infix-src join init newline
  append prefix-src join init newline
  append infix-src join {--assert } [expected " == " actual newline]
  append prefix-src join {--assert strict-equal? } [expected " " actual newline]
]

add-not-strict-equal-test: func [
  expected [string!]
  actual   [string!]
][
  add-test
  append infix-src join {--assert not } [expected " == " actual newline]
  append prefix-src join {--assert not strict-equal? } [expected " " actual newline]
]

add-not-strict-equal-test-with-init: func [
	init [string!]
	expected [string!]
	actual   [string!]
][
	add-test
	append infix-src join init newline
	append prefix-src join init newline
	append infix-src join {--assert not } [expected " == " actual newline]
	append prefix-src join {--assert not strict-equal? } [expected " " actual newline]
]

add-test: func [] [
  group-test-no: group-test-no + 1
  append infix-src join {--test-- "infix-strict-equal-} 
    [group-title "-" group-test-no {"} newline]
  append prefix-src join {--test-- "prefix-strict-equal-} 
    [group-title "-" group-test-no {"} newline]
]

add-test-with-code: func [
  code        [string!]
  assertion   [string!]
][
  add-test
  append infix-src join code newline
  append prefix-src join code newline
  append infix-src join {--assert } [assertion newline]
  append prefix-src join {--assert } [assertion newline]
]
  
add-test-text: func [
  text  [string!]
][
  append infix-src join replace copy text "***FIX***" "infix" newline
  append prefix-src join replace copy text "***FIX***" "prefix" newline
]

start-group: func [
  title [string!]
][
  group-title: title
  group-test-no: 0
  add-test-text join {===start-group=== "} [title {"}]
]
  

;; processing 
replace test-src {***MAKELENGTH***} length? read %make-strict-equal-auto-test.r
infix-src: copy test-src
replace infix-src {***FILE***} :infix-file
prefix-src: copy test-src
replace prefix-src {***FILE***} :prefix-file

add-test-text {~~~start-file~~~ "***FIX***-strict-equal"}

start-group "same-datatype"
add-strict-equal-test "0" "0"
add-strict-equal-test "1" "1"
add-strict-equal-test "FFFFFFFFh" "-1"
add-strict-equal-test "[]" "[]"
add-strict-equal-test "[a]" "[a]"
add-not-strict-equal-test "[A]" "[a]"
add-not-strict-equal-test "['a]" "[a]"
add-not-strict-equal-test "[a:]" "[a]"
add-not-strict-equal-test "[:a]" "[a]"
add-not-strict-equal-test "[:a]" "[a:]"
add-strict-equal-test "[abcde]" "[abcde]"
add-strict-equal-test "[a b c d]" "[a b c d]"
add-strict-equal-test "[b c d]" "next [a b c d]"
add-strict-equal-test "[b c d]" "(next [a b c d])"
add-strict-equal-test {"a"} {"a"}
add-not-strict-equal-test {"a"} {"A"}
add-strict-equal-test {"abcdeè"} {"abcdeè"}
add-strict-equal-test {(next "abcdeè")} {next "abcdeè"}
add-strict-equal-test {(first "abcdeè")} {first "abcdeè"}
add-strict-equal-test {(last "abcdeè")} {last "abcdeè"}
add-strict-equal-test {"abcde^^(2710)é^^(010000)"} {"abcde^^(2710)é^^(010000)"} 
;; need to escape the ^ as file is processed by REBOL
add-strict-equal-test {[d]} {back tail [a b c d]}
add-strict-equal-test {"2345"} {next "12345"}
add-strict-equal-test {#"z"} {#"z"}
add-not-strict-equal-test {#"z"} {#"Z"}
add-not-strict-equal-test {#"e"} {#"è"}
add-strict-equal-test {#"^^(010000)"} {#"^^(010000)"}
add-strict-equal-test {true} {true}
add-strict-equal-test {false} {false}
add-not-strict-equal-test {false} {true}
add-not-strict-equal-test {true} {false}
add-strict-equal-test {none} {none}
add-strict-equal-test {'a} {'a}
add-strict-equal-test {[a b c d e]} {first [[a b c d e]]}
add-test-with-code {ea-result: 1 == 1} {ea-result = true}
add-test-with-code {ea-result: 1 == 0} {ea-result = false}
add-test-with-code {ea-result: strict-equal? 1 1} {ea-result = true}
add-test-with-code {ea-result: strict-equal? 1 0} {ea-result = false}
add-strict-equal-test {0.0} {-0.0}
add-not-strict-equal-test {1} {1.0}
add-test-text {===end-group===}

start-group {implcit-cast}
add-not-strict-equal-test {#"0"} {48}
add-not-strict-equal-test {48} {#"0"}
add-not-strict-equal-test {#"^^(2710)"} {10000}
add-not-strict-equal-test {#"^^(010000)"} {65536}
add-test-with-code {ea-result: #"1" == 49} {ea-result = false}
add-test-with-code {ea-result: strict-equal? #"^^(010000)" 10000} {ea-result = false}
add-strict-equal-test-with-init {a: b: 1} {a} {b}
add-strict-equal-test-with-init {a: b: "abcde"} {a} {b} 
add-test-text {===end-group===}

add-test-text {~~~end-file~~~}

write infix-file infix-src
write prefix-file prefix-src

print "Strict equal auto test files generated"

