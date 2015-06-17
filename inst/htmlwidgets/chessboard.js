HTMLWidgets.widget({

  name: 'chessboard',

  type: 'output',

  initialize: function(el, width, height) {

    return {
      // TODO: add instance fields as required
    };

  },

  renderValue: function(el, x, instance) {

    console.log(el);
    var board = new ChessBoard(el.id, 'start');

  },

  resize: function(el, width, height, instance) {

  }

});
