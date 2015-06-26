HTMLWidgets.widget({

  name: 'chessboard',

  type: 'output',

  initialize: function(el, width, height) {

    return {
      // TODO: add instance fields as required
    };

  },

  renderValue: function(el, x, instance) {

    console.log(x);
    console.log(el);

    var sel = d3.select("#" + el.id);
    var board = d3chessboard()
                  .fen(x.fen)
                  .size(parseInt(el.style.width));
    sel.call(board);

  },

  resize: function(el, width, height, instance) {

  }

});
