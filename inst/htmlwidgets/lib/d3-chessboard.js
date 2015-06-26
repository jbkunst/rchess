function d3chessboard() {

  // defaults (have function)
  var whitecellcolor = "beige",
      blackcellcolor = "tan",
      fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
      picefontsize = 35,
      textfontsize = 16,
      textopacity = 0.75,
      size = 400;
      
  // internal parameters
  var margin = {top: 25, right: 25, bottom: 25, left: 25},
      cols = ["a", "b", "c", "d", "e", "f", "g", "h"],
      rows = [8, 7, 6, 5, 4, 3, 2, 1],
      griddata = cartesianprod(rows, rows);

  // http://stackoverflow.com/questions/27806132/how-to-draw-a-chess-board-in-d3
  // easy access for chess.js
  var pieces = {
    p : { w : "\u2659", b: "\u265F"},
    k : { w : "\u2654", b: "\u265A"},
    q : { w : "\u2655", b: "\u265B"},
    r : { w : "\u2656", b: "\u265C"},
    b : { w : "\u2657", b: "\u265D"},
    n : { w : "\u2658", b: "\u265E"}
  }

  function board(selection) {

    selection.each(function(d, i) {

      var chess = new Chess();
      
      chess.load(fen);

      // beware, you maybe shall not pass
      selection.selectAll("*").remove();

      var svg = selection.append("svg")
        .attr("width", size + margin.left + margin.right)
        .attr("height", size + margin.top + margin.bottom)
        .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

      var gridSize = Math.floor(size / cols.length)

      var colLabels = svg.selectAll(".colLabel")
          .data(cols)
          .enter().append("text")
            .text(function (d) { return d; })
            .attr("y", 0)
            .attr("x", function (d, i) { return i * gridSize; })
            .attr("font-size", textfontsize)
            .style("text-anchor", "middle")
            .style("opacity", textopacity)
            .attr("transform", "translate(" + gridSize / 2 + ", " + (size + gridSize/3) + "  )")

      var colLabels2 = svg.selectAll(".colLabel")
          .data(cols)
          .enter().append("text")
            .text(function (d) { return d; })
            .attr("y", 0)
            .attr("x", function (d, i) { return i * gridSize; })
            .attr("font-size", textfontsize)
            .style("text-anchor", "middle")
            .style("opacity", textopacity)
            .attr("transform", "translate(" + gridSize / 2 + ", " + -6 + "  )")

      var rowLabels = svg.selectAll(".rowLabel")
          .data(rows)
          .enter().append("text")
            .text(function(d) { return d; })
            .attr("y", function(d, i) { return i * gridSize; })
            .attr("x", 0)
            .attr("font-size", textfontsize)
            .style("text-anchor", "middle")
            .style("opacity", textopacity)
            .attr("transform", "translate(-18," + gridSize / 1.5 + ")")

      var rowLabels = svg.selectAll(".rowLabel")
          .data(rows)
          .enter().append("text")
            .text(function(d) { return d; })
            .attr("y", function(d, i) { return i * gridSize; })
            .attr("x", 0)
            .attr("font-size", textfontsize)
            .style("text-anchor", "middle")
            .style("opacity", textopacity)
            .attr("transform", "translate(" + (size + 18) + "," + gridSize / 1.5 + ")")

      var chessBoard = svg.selectAll(".cell")
          .data(griddata)
          .enter().append("rect")
          .attr("x", function(d) { return (d[1] - 1) * gridSize; })
          .attr("y", function(d) { return (d[0] - 1) * gridSize; })
          .attr("row", function(d){ return 9 - d[0]; })
          .attr("col", function(d){ return d[1]; })
          .attr("id", function(d){ return cols[d[1]-1] + (9 - d[0]); })
          .attr("fill", function(d){ if ((d[1]+d[0])%2 != 0) return blackcellcolor; else return whitecellcolor; })
          .attr("width", gridSize)
          .attr("height", gridSize)

      var piecePositions = svg.selectAll(".piece")
          .data(griddata)
          .enter().append("text")
          .attr("x", function(d) { return (d[1] - 1) * gridSize; })
          .attr("y", function(d) { return (d[0] - 1) * gridSize; })
          .attr("row", function(d){ return 9 - d[0]; })
          .attr("col", function(d){ return d[1]; })
          .style("text-anchor", "middle")
          .style("color", "white")
          .attr("font-size", picefontsize)
          .attr("transform", "translate(" + gridSize / 2 + "," + gridSize / 1.3 + ")")
          .text(function(d, i){
            var cell = cols[d[1]-1] + (9 - d[0]);
            var chesscell = chess.get(cell);
            return ((chesscell == null) ? "" : pieces[chesscell.type][chesscell.color]);
          })

    });
  };

  board.size = function(_) {
    if (!arguments.length) return size;
    size = _;
    return board;
  };

  board.picefontsize = function(_) {
    if (!arguments.length) return picefontsize;
    picefontsize = _;
    return board;
  };

  board.textfontsize = function(_) {
    if (!arguments.length) return textfontsize;
    textfontsize = _;
    return board;
  };

  board.textopacity = function(_) {
    if (!arguments.length) return textopacity;
    textopacity = _;
    return board;
  };

  board.whitecellcolor = function(_) {
    if (!arguments.length) return whitecellcolor;
    whitecellcolor = _;
    return board;
  };

  board.blackcellcolor = function(_) {
    if (!arguments.length) return blackcellcolor;
    blackcellcolor = _;
    return board;
  };

  board.fen = function(_) {
    if (!arguments.length) return fen;
    fen = _;
    return board;
  };

  return board;
}

/* http://stackoverflow.com/questions/12303989/cartesian-product-of-multiple-arrays-in-javascript */
function cartesianprod(paramArray) {

  function addTo(curr, args) {

    var i, copy, 
        rest = args.slice(1),
        last = !rest.length,
        result = [];

    for (i = 0; i < args[0].length; i++) {

      copy = curr.slice();
      copy.push(args[0][i]);

      if (last) {
        result.push(copy);

      } else {
        result = result.concat(addTo(copy, rest));
      }
    }

    return result;
  }


  return addTo([], Array.prototype.slice.call(arguments));
}