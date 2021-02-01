module Test.Main where

import Prelude

import Effect (Effect)
import Node.Path (basename, basenameWithoutExt, concat, delimiter, dirname, extname, normalize, parse, relative, resolve, sep)
import Test.Assert (assert, assertEqual)

main :: Effect Unit
main = do
  assertEqual { actual: normalize "/foo/bar//baz/asdf/quux/..", expected: normalize "/foo/bar/baz/asdf" }
  assertEqual { actual: concat ["/foo", "bar"], expected: normalize "/foo/bar" }
  assertEqual { actual: relative "/data/orandea/test/aaa" "/data/orandea/impl/bbb", expected: normalize "../../impl/bbb" }
  assertEqual { actual: dirname "/foo/bar/baz/asdf/quux", expected: normalize "/foo/bar/baz/asdf" }
  assertEqual { actual: basename "/foo/bar/baz/asdf/quux.html", expected: "quux.html" }
  assertEqual { actual: basenameWithoutExt "/foo/bar/baz/asdf/quux.html" ".html", expected: "quux" }
  assertEqual { actual: basenameWithoutExt "/foo/bar/baz/asdf/quux.txt" ".html", expected: "quux.txt" }
  assertEqual { actual: extname "index.html", expected: ".html" }
  assertEqual { actual: extname "index.coffee.md", expected: ".md" }
  assertEqual { actual: extname "index.", expected: "." }
  assertEqual { actual: extname "index", expected: "" }
  assertEqual { actual: sep, expected: normalize "/" }
  assert $ delimiter == ";" || delimiter == ":"

  let path = parse "/home/user/file.js"
  assertEqual { actual: path.root, expected: "/" }
  assertEqual { actual: path.dir, expected: "/home/user" }
  assertEqual { actual: path.base, expected: "file.js" }
  assertEqual { actual: path.ext, expected: ".js" }
  assertEqual { actual: path.name, expected: "file" }

  path1 <- resolve ["a"] ""
  path2 <- resolve ["a"] "."
  assertEqual { actual: path1, expected: path2 }
