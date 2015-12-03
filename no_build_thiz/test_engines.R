rm(list = ls())
library("V8")

ctx <- V8::new_context()
ctx$eval('function setTimeout(){}')
ctx$source("no_build_thiz/stockfish.js")
ctx$eval("var stockfish = STOCKFISH();")
ctx$eval("stockfish.onmessage = function(event) { console.log(event.data ? event.data : event);};")
ctx$eval("stockfish.postMessage(\"go depth 2\");")


