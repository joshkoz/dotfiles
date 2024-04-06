; extends

(((comment) @s
  (#lua-match? @s "^///")) @injection.content
  (#set! injection.language "xml"))
