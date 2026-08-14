# Chess Class

Chees class.

## Format

An \[R6::R6Class\] generator object.

## Methods

- `new` Creating a new instance of Chess class.

- `ascii` Print the board via console.

- `clear` Remove all pieces from the board.

- `fen` Return the actual Forsyth Edwards notation.

- `pgn` Return Portable Game notation.

- `get` Return the piece in a spicific square argument.

- `history` Return a vector containing the moves of the current game. If
  the argument `verbose=TRUE` is added the method return a data frame.

- `game_over` Returns TRUE if the game has ended via checkmate,
  stalemate, draw, threefold repetition, or insufficient material.
  Otherwise, returns FALSE.

- `in_check` Returns true or false if the side to move is in check.

- `in_checkmate` Returns true or false if the side to move has been
  checkmated.

- `in_draw` Returns true or false if the game is drawn 50 move rule or
  insufficient material.

- `in_stalemate` Returns true or false if the side to move has been
  stalemated.

- `in_threefold_repetition` Returns true or false if the current board
  position has occurred three or more times.

- `insufficient_material` Returns true if the game is drawn due to
  insufficient material (K vs. K, K vs. KB, or K vs. KN); otherwise
  false.

- `move` Attempts to make a move on the board, returning a move object
  if the move was legal, otherwise null. The .move function can be
  called two ways, by passing a string in Standard Algebraic Notation
  SAN:

- `moves` Returns a vector of legals moves from the current position.
  The function takes an optional parameter which controls the single
  square move generation and verbosity.

- `validate_fen` Returns a validation object specifying validity or the
  errors found within the FEN string.

- `load`

- `load_pgn` Load the moves of a game stored in Portable Game Notation.

- `put` Place a piece on square where piece is an object.

- `remove` Remove and return the piece on square.

- `reset` Reset the board to the initial starting position.

- `square_color` Returns the color of the square (light or dark).

- `turn` Returns the current side to move.

- `undo` Takeback the last halfmove, returning a move object if
  successful.

- `header` Allows header information to be added to PGN output. Any
  number of key value pairs can be passed to `header()`.

- `get_header` Get header of the actual game via list object.

- `history_detail` Return a detailed version for
  `history(verbose=TRUE)`.

- `summary` Print a summary of the object.

- `plot` Plot the object with chessboard.js or ggplot2.

- `print` Print the summary ob the Chess object.

## Methods

### Public methods

- [`Chess$new()`](#method-Chess-initialize)

- [`Chess$init_ct()`](#method-Chess-init_ct)

- [`Chess$ascii()`](#method-Chess-ascii)

- [`Chess$clear()`](#method-Chess-clear)

- [`Chess$fen()`](#method-Chess-fen)

- [`Chess$pgn()`](#method-Chess-pgn)

- [`Chess$get()`](#method-Chess-get)

- [`Chess$history()`](#method-Chess-history)

- [`Chess$game_over()`](#method-Chess-game_over)

- [`Chess$in_check()`](#method-Chess-in_check)

- [`Chess$in_checkmate()`](#method-Chess-in_checkmate)

- [`Chess$in_draw()`](#method-Chess-in_draw)

- [`Chess$in_stalemate()`](#method-Chess-in_stalemate)

- [`Chess$in_threefold_repetition()`](#method-Chess-in_threefold_repetition)

- [`Chess$insufficient_material()`](#method-Chess-insufficient_material)

- [`Chess$move()`](#method-Chess-move)

- [`Chess$moves()`](#method-Chess-moves)

- [`Chess$validate_fen()`](#method-Chess-validate_fen)

- [`Chess$load()`](#method-Chess-load)

- [`Chess$load_pgn()`](#method-Chess-load_pgn)

- [`Chess$put()`](#method-Chess-put)

- [`Chess$remove()`](#method-Chess-remove)

- [`Chess$reset()`](#method-Chess-reset)

- [`Chess$square_color()`](#method-Chess-square_color)

- [`Chess$turn()`](#method-Chess-turn)

- [`Chess$undo()`](#method-Chess-undo)

- [`Chess$header()`](#method-Chess-header)

- [`Chess$get_header()`](#method-Chess-get_header)

- [`Chess$history_detail()`](#method-Chess-history_detail)

- [`Chess$summary()`](#method-Chess-summary)

- [`Chess$plot()`](#method-Chess-plot)

- [`Chess$print()`](#method-Chess-print)

- [`Chess$clone()`](#method-Chess-clone)

------------------------------------------------------------------------

### `Chess$new()`

Create a game from a FEN position.

#### Usage

    Chess$new(fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")

#### Arguments

- `fen`:

  A Forsyth-Edwards Notation string.

------------------------------------------------------------------------

### `Chess$init_ct()`

Initialize the underlying JavaScript chess context.

#### Usage

    Chess$init_ct(fen)

#### Arguments

- `fen`:

  A Forsyth-Edwards Notation string.

------------------------------------------------------------------------

### `Chess$ascii()`

Print an ASCII representation of the board.

#### Usage

    Chess$ascii()

------------------------------------------------------------------------

### `Chess$clear()`

Remove all pieces from the board.

#### Usage

    Chess$clear()

------------------------------------------------------------------------

### `Chess$fen()`

Return the current FEN position.

#### Usage

    Chess$fen()

------------------------------------------------------------------------

### `Chess$pgn()`

Return the game in Portable Game Notation.

#### Usage

    Chess$pgn()

------------------------------------------------------------------------

### `Chess$get()`

Return the piece on a square.

#### Usage

    Chess$get(square)

#### Arguments

- `square`:

  A square such as \`"e4"\`.

------------------------------------------------------------------------

### `Chess$history()`

Return the moves already played.

#### Usage

    Chess$history(verbose = FALSE)

#### Arguments

- `verbose`:

  If \`TRUE\`, return detailed move records as a tibble.

------------------------------------------------------------------------

### `Chess$game_over()`

Test whether the game has ended.

#### Usage

    Chess$game_over()

------------------------------------------------------------------------

### `Chess$in_check()`

Test whether the active player is in check.

#### Usage

    Chess$in_check()

------------------------------------------------------------------------

### `Chess$in_checkmate()`

Test whether the active player is checkmated.

#### Usage

    Chess$in_checkmate()

------------------------------------------------------------------------

### `Chess$in_draw()`

Test whether the game is drawn.

#### Usage

    Chess$in_draw()

------------------------------------------------------------------------

### `Chess$in_stalemate()`

Test whether the active player is stalemated.

#### Usage

    Chess$in_stalemate()

------------------------------------------------------------------------

### `Chess$in_threefold_repetition()`

Test whether the position has repeated three times.

#### Usage

    Chess$in_threefold_repetition()

------------------------------------------------------------------------

### `Chess$insufficient_material()`

Test whether neither player has mating material.

#### Usage

    Chess$insufficient_material()

------------------------------------------------------------------------

### `Chess$move()`

Play a legal move.

#### Usage

    Chess$move(move)

#### Arguments

- `move`:

  A move in Standard Algebraic Notation.

------------------------------------------------------------------------

### `Chess$moves()`

Return legal moves from the current position.

#### Usage

    Chess$moves(verbose = FALSE)

#### Arguments

- `verbose`:

  If \`TRUE\`, return detailed move records as a tibble.

------------------------------------------------------------------------

### `Chess$validate_fen()`

Validate a FEN position.

#### Usage

    Chess$validate_fen(fen)

#### Arguments

- `fen`:

  A Forsyth-Edwards Notation string.

------------------------------------------------------------------------

### `Chess$load()`

Replace the current position with a FEN position.

#### Usage

    Chess$load(fen)

#### Arguments

- `fen`:

  A Forsyth-Edwards Notation string.

------------------------------------------------------------------------

### `Chess$load_pgn()`

Load a game from Portable Game Notation.

#### Usage

    Chess$load_pgn(pgn)

#### Arguments

- `pgn`:

  A Portable Game Notation string.

------------------------------------------------------------------------

### `Chess$put()`

Place a piece on a square.

#### Usage

    Chess$put(type, color, square)

#### Arguments

- `type`:

  One of \`"k"\`, \`"q"\`, \`"r"\`, \`"b"\`, \`"n"\`, or \`"p"\`.

- `color`:

  Either \`"w"\` or \`"b"\`.

- `square`:

  A square such as \`"e4"\`.

------------------------------------------------------------------------

### `Chess$remove()`

Remove and return the piece on a square.

#### Usage

    Chess$remove(square)

#### Arguments

- `square`:

  A square such as \`"e4"\`.

------------------------------------------------------------------------

### `Chess$reset()`

Reset the game to the standard starting position.

#### Usage

    Chess$reset()

------------------------------------------------------------------------

### `Chess$square_color()`

Return whether a square is light or dark.

#### Usage

    Chess$square_color(square)

#### Arguments

- `square`:

  A square such as \`"e4"\`.

------------------------------------------------------------------------

### `Chess$turn()`

Return the active color, \`"w"\` or \`"b"\`.

#### Usage

    Chess$turn()

------------------------------------------------------------------------

### `Chess$undo()`

Undo and return the last move.

#### Usage

    Chess$undo()

------------------------------------------------------------------------

### `Chess$header()`

Add a key-value pair to the PGN header.

#### Usage

    Chess$header(key, value)

#### Arguments

- `key`:

  A PGN header name.

- `value`:

  A value coercible to character.

------------------------------------------------------------------------

### `Chess$get_header()`

Return the PGN header as a list.

#### Usage

    Chess$get_header()

------------------------------------------------------------------------

### `Chess$history_detail()`

Return piece-by-piece move history as a tibble.

#### Usage

    Chess$history_detail()

------------------------------------------------------------------------

### `Chess$summary()`

Print a summary of the game.

#### Usage

    Chess$summary()

------------------------------------------------------------------------

### `Chess$plot()`

Render the current position.

#### Usage

    Chess$plot(type = "chessboardjs", ...)

#### Arguments

- `type`:

  Either \`"chessboardjs"\` or \`"ggplot"\`.

- `...`:

  Additional arguments passed to the renderer.

------------------------------------------------------------------------

### `Chess$print()`

Print the game summary.

#### Usage

    Chess$print()

------------------------------------------------------------------------

### `Chess$clone()`

The objects of this class are cloneable with this method.

#### Usage

    Chess$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
