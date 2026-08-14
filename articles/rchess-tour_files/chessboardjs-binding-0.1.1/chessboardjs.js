HTMLWidgets.widget({

  name: 'chessboardjs',
  type: 'output',

  initialize: function(el, width, height) {
    return {
      // TODO: add instance fields as required
    };
  },

  renderValue: function(el, x, instance) {

    console.log(x);
    console.log(el);
    console.log(parseInt(el.clientWidth));

    var board = ChessBoard(el.id, {
      pieceTheme: chess24_theme,
      position: x.fen
    });

    $(window).resize(board.resize);

  },

  resize: function(el, width, height, instance) {

  }

});
