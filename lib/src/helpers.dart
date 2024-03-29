// ignore_for_file: constant_identifier_names, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, must_be_immutable, invalid_use_of_protected_member

// #####################################################################################
//     Constants
// #####################################################################################

import 'dart:async';
import 'dart:math';

import 'package:flutris/flutris.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

const TEXT_COLOR = Color.fromARGB(255, 15, 56, 15);
const BACK_COLOR_DARK = Color.fromARGB(255, 125, 155, 15);
const BACK_COLOR = Color.fromARGB(255, 155, 188, 15);
const CASE_COLOR = Color.fromARGB(255, 170, 170, 170);

const NUM_BLOCKS_X = 10;
const NUM_BLOCKS_Y = 20;
const BAG = [0, 1, 2, 3, 4, 5, 6];

typedef Matrix = List<List<int>>;

class Pos {
  Pos([this.x = 0, this.y = 0]);
  int x = 0;
  int y = 0;
}

Matrix TPiece = [
  [0, 0, 0],
  [1, 1, 1],
  [0, 1, 0],
];
Matrix OPiece = [
  [2, 2],
  [2, 2],
];
Matrix LPiece = [
  [0, 3, 0],
  [0, 3, 0],
  [0, 3, 3],
];
Matrix JPiece = [
  [0, 4, 0],
  [0, 4, 0],
  [4, 4, 0],
];
Matrix IPiece = [
  [0, 5, 0, 0],
  [0, 5, 0, 0],
  [0, 5, 0, 0],
  [0, 5, 0, 0],
];
Matrix SPiece = [
  [0, 6, 6],
  [6, 6, 0],
  [0, 0, 0],
];
Matrix ZPiece = [
  [7, 7, 0],
  [0, 7, 7],
  [0, 0, 0],
];

const List<Color> colors = [
  Color(0x00000000),
  Color(0xFFFF0D72),
  Color(0xFF0DC2FF),
  Color(0xFF0DFF72),
  Color(0xFFF538FF),
  Color(0xFFFF8E0D),
  Color(0xFFFFE138),
  Color(0xFF3877FF),
];

class Player {
  static Matrix? currentPiece;
  static Pos currentPiecePos = Pos();
  static Matrix? nextPiece;
  static Matrix? holdPiece;
  static Matrix? lastHeldPiece;
  static Matrix? ghostPiece;
  static Pos ghostPiecePos = Pos();
  static bool canHoldPiece = true;
  static int score = 0;
  static int level = 1;
  static bool isGameOver = false;
  static List<int> currentBag = [];
  static bool isPlaying = false;
  static bool showHelp = false;
  static bool pause = false;

  static void reset() {
    currentPiece = null;
    currentPiecePos = Pos();
    nextPiece = null;
    holdPiece = null;
    lastHeldPiece = null;
    ghostPiece = null;
    ghostPiecePos = Pos();
    canHoldPiece = true;
    score = 0;
    level = 1;
    isGameOver = false;
    isPlaying = false;
    currentBag = [];
    showHelp = false;
    pause = false;
  }
}

class Board {
  static Matrix matrix = List.generate(NUM_BLOCKS_Y, (y) => List.generate(NUM_BLOCKS_X, (x) => 0));

  static void reset() {
    matrix = List.generate(NUM_BLOCKS_Y, (y) => List.generate(NUM_BLOCKS_X, (x) => 0));
  }
}

class TimeHandler {
  static int dropCounter = 0;
  static int lastTime = 0;
  static int elapsedTime = 0;
  static int dropInterval = 800;
  static int tickDelay = 33;
  static Timer? timer;

  static void dispose() {
    reset();
    timer?.cancel();
    timer = null;
  }

  static void reset() {
    dropCounter = 0;
    dropInterval = 800;
    lastTime = 0;
    elapsedTime = 0;
    tickDelay = 33;
  }
}

class TouchHandler {
  static double dragStartX = 0;
  static double dragStartY = 0;
  static double dragEndX = 0;
  static double dragEndY = 0;
  static int dragDirectionX = 0;
  static int dragDirectionY = 0;

  static void reset() {
    dragStartX = 0;
    dragStartY = 0;
    dragEndX = 0;
    dragEndY = 0;
    dragDirectionX = 0;
    dragDirectionY = 0;
  }
}

class AudioHandler {
  static bool soundOn = true;
  static bool musicOn = true;
  static AudioPlayer? _musicPlayer;
  static AudioPlayer? _soundPlayer;
  static const String _musicFile = "packages/flutris/assets/audio/tetris.mp3";
  static const String _rowSweepSoundFile = "packages/flutris/assets/audio/row_sweep.mp3";
  static const String _gameoverSoundFile = "packages/flutris/assets/audio/gameover.mp3";
  static const String _levelupSoundFile = "packages/flutris/assets/audio/levelup.mp3";
  static const String _landSoundFile = "packages/flutris/assets/audio/land.mp3";

  static void init() {
    _musicPlayer = AudioPlayer();
    _musicPlayer?.setLoopMode(LoopMode.all);
    _soundPlayer = AudioPlayer();
    _soundPlayer?.setLoopMode(LoopMode.off);
  }

  static setFlags({bool? soundOn, bool? musicOn}) {
    AudioHandler.soundOn = soundOn ?? AudioHandler.soundOn;
    AudioHandler.musicOn = musicOn ?? AudioHandler.musicOn;
  }

  static void playMusic() async {
    if (!musicOn) return;
    if ((_musicPlayer?.playing ?? true)) return;
    await _musicPlayer?.setAsset(_musicFile);
    _musicPlayer?.play();
  }

  static void pauseMusic() async {
    await _musicPlayer?.pause();
  }

  static void stopMusic() async {
    if ((_musicPlayer?.playing ?? false)) {
      await _musicPlayer?.stop();
    }
  }

  static void playSweepSound() async {
    if (!soundOn) return;
    await _soundPlayer?.setAsset(_rowSweepSoundFile);
    _soundPlayer?.play();
  }

  static void playLandSound() async {
    if (!soundOn) return;
    await _soundPlayer?.setAsset(_landSoundFile);
    _soundPlayer?.play();
  }

  static void playGameoverSound() async {
    if (!soundOn) return;
    await _soundPlayer?.setAsset(_gameoverSoundFile);
    _soundPlayer?.play();
  }

  static void playLevelUpSound() async {
    if (!soundOn) return;
    await _soundPlayer?.setAsset(_levelupSoundFile);
    _soundPlayer?.play();
  }

  static void reset() async {
    if ((_musicPlayer?.playing ?? false)) {
      await _musicPlayer?.stop();
    }
  }

  static void dispose() {
    _musicPlayer?.stop();
    _musicPlayer?.dispose();
    _soundPlayer?.stop();
    _soundPlayer?.dispose();
  }
}

FocusNode keyboardFocusNode = FocusNode();

// #####################################################################################
//     Helpers
// #####################################################################################

void drawBlock(int x, int y, double blockWidth, double blockHeight, Canvas canvas, Color color) {
  final border = Paint()
    ..color = BACK_COLOR
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;
  final deco = Paint()
    ..color = BACK_COLOR
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;
  final paint = Paint()..color = TEXT_COLOR;
  canvas.drawRect(Rect.fromLTWH(x * blockWidth, y * blockWidth, blockWidth, blockHeight), paint);
  canvas.drawRect(Rect.fromLTWH(x * blockWidth, y * blockWidth, blockWidth, blockHeight), border);
  canvas.drawRect(Rect.fromLTWH(x * blockWidth + 8, y * blockWidth + 8, blockWidth - 16, blockHeight - 16), deco);
}

void drawBlockSimple(int x, int y, double blockWidth, double blockHeight, Canvas canvas, Color color) {
  final border = Paint()
    ..color = BACK_COLOR
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;
  final paint = Paint()..color = TEXT_COLOR;
  canvas.drawRect(Rect.fromLTWH(x * blockWidth, y * blockWidth, blockWidth, blockHeight), paint);
  canvas.drawRect(Rect.fromLTWH(x * blockWidth, y * blockWidth, blockWidth, blockHeight), border);
}

void drawGhostBlock(int x, int y, double blockWidth, double blockHeight, Canvas canvas, Color color) {
  final border = Paint()
    ..color = BACK_COLOR
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;
  final paint = Paint()..color = BACK_COLOR_DARK;
  canvas.drawRect(Rect.fromLTWH(x * blockWidth, y * blockWidth, blockWidth, blockHeight), paint);
  canvas.drawRect(Rect.fromLTWH(x * blockWidth, y * blockWidth, blockWidth, blockHeight), border);
}

void drawMatrix(Matrix matrix, canvas, double blockWidth, double blockHeight, Pos offset, {bool ghost = false}) {
  for (int row = 0; row < matrix.length; row++) {
    for (int x = 0; x < matrix[row].length; x++) {
      if (matrix[row][x] != 0) {
        final color = colors[matrix[row][x]];
        if (ghost) {
          drawGhostBlock(x + offset.x, row + offset.y, blockWidth, blockHeight, canvas, color);
        } else {
          if (blockWidth < 20) {
            drawBlockSimple(x + offset.x, row + offset.y, blockWidth, blockHeight, canvas, color);
          } else {
            drawBlock(x + offset.x, row + offset.y, blockWidth, blockHeight, canvas, color);
          }
        }
      }
    }
  }
}

void drawPlayerPiece(Canvas canvas, double blockWidth, double blockHeight) {
  if (Player.currentPiece != null) {
    drawMatrix(Player.currentPiece!, canvas, blockWidth, blockHeight, Player.currentPiecePos);
  }
}

void drawGhostPiece(Canvas canvas, double blockWidth, double blockHeight) {
  if (Player.ghostPiece != null) {
    Player.ghostPiecePos.y = Player.currentPiecePos.y;
    landPiece(Player.ghostPiece, Player.ghostPiecePos);
    if (Player.ghostPiecePos.y > Player.currentPiecePos.y) {
      drawMatrix(Player.ghostPiece!, canvas, blockWidth, blockHeight, Player.ghostPiecePos, ghost: true);
    }
  }
}

void drawBoard(Canvas canvas, double blockWidth, double blockHeight) {
  drawMatrix(Board.matrix, canvas, blockWidth, blockHeight, Pos());
}

Matrix getNewPiece() {
  if (Player.currentBag.isEmpty) {
    Player.currentBag = List.from(BAG);
    Player.currentBag.shuffle();
  }
  final type = Player.currentBag.removeLast();
  switch (type) {
    case 0:
      return Matrix.from(TPiece);
    case 1:
      return Matrix.from(OPiece);
    case 2:
      return Matrix.from(LPiece);
    case 3:
      return Matrix.from(JPiece);
    case 4:
      return Matrix.from(IPiece);
    case 5:
      return Matrix.from(SPiece);
    case 6:
      return Matrix.from(ZPiece);
    default:
      return Matrix.from(TPiece);
  }
}

bool isColliding(Matrix? piece, Pos? pos) {
  if (piece == null || pos == null) {
    return false;
  }
  for (var y = 0; y < piece.length; ++y) {
    for (var x = 0; x < piece[y].length; ++x) {
      bool atBottom = y + pos.y > NUM_BLOCKS_Y - 1 && piece[y][x] != 0;
      bool atLeft = x + pos.x < 0 && piece[y][x] != 0;
      bool atRight = x + pos.x > NUM_BLOCKS_X - 1 && piece[y][x] != 0;
      if (atBottom || atLeft || atRight) return true;
      if (piece[y][x] != 0 && (Board.matrix[y + pos.y][x + pos.x] != 0)) {
        return true;
      }
    }
  }
  return false;
}

void mergePieceWithBoard() {
  if (Player.currentPiece == null) return;
  final piece = Player.currentPiece;
  final board = Board.matrix;
  final pos = Player.currentPiecePos;
  for (var row = 0; row < piece!.length; ++row) {
    for (var x = 0; x < piece[row].length; ++x) {
      if (piece[row][x] != 0) {
        board[row + pos.y][x + pos.x] = piece[row][x];
      }
    }
  }
}

void moveHorizontal(int dir) {
  Player.currentPiecePos.x += dir;
  if (isColliding(Player.currentPiece, Player.currentPiecePos)) {
    Player.currentPiecePos.x -= dir;
  }
  Player.ghostPiecePos.x = Player.currentPiecePos.x;
}

void movePlayerPieceDown() {
  Player.currentPiecePos.y++;
  if (isColliding(Player.currentPiece, Player.currentPiecePos)) {
    Player.currentPiecePos.y--;
    mergePieceWithBoard();
    nextPiece();
    removeFullRows();
  }
  TimeHandler.dropCounter = 0;
}

void landPiece(Matrix? piece, Pos? pos) {
  if (piece == null || pos == null) return;
  while (!isColliding(piece, pos)) {
    pos.y++;
  }
  pos.y--;
  if (piece == Player.currentPiece) {
    AudioHandler.playLandSound();
  }
}

void rotate(dir) {
  final piece = Player.currentPiece;
  final posX = Player.currentPiecePos.x;
  var offset = 1;
  _rotate(dir);
  while (isColliding(Player.currentPiece, Player.currentPiecePos)) {
    Player.currentPiecePos.x += offset;
    offset = -(offset + (offset > 0 ? 1 : -1));
    if (offset > piece![0].length) {
      _rotate(-dir);
      Player.currentPiecePos.x = posX;
      return;
    }
  }
}

void _rotate(dir) {
  if (Player.currentPiece == null) return;
  for (var y = 0; y < Player.currentPiece!.length; ++y) {
    for (var x = 0; x < y; ++x) {
      var temp = Player.currentPiece![y][x];
      Player.currentPiece![y][x] = Player.currentPiece![x][y];
      Player.currentPiece![x][y] = temp;
    }
  }
  if (dir > 0) {
    for (var rowNum = 0; rowNum < Player.currentPiece!.length; ++rowNum) {
      final row = Player.currentPiece![rowNum];
      Player.currentPiece![rowNum] = row.reversed.toList();
    }
  } else {
    Player.currentPiece = Player.currentPiece!.reversed.toList();
  }
  Player.ghostPiece = Matrix.from(Player.currentPiece!);
  Player.ghostPiecePos.x = Player.currentPiecePos.x;
}

void nextPiece() {
  Player.currentPiece = Player.nextPiece ?? getNewPiece();
  Player.nextPiece = getNewPiece();
  Player.currentPiecePos = Pos((NUM_BLOCKS_X / 2 - 2).floor(), 0);
  checkGameOver();
  Player.ghostPiece = Matrix.from(Player.currentPiece!);
  Player.ghostPiecePos.x = Player.currentPiecePos.x;
  Player.canHoldPiece = true;
}

void checkGameOver() {
  if (isColliding(Player.currentPiece, Player.currentPiecePos)) {
    Player.isGameOver = true;
    Player.isPlaying = false;
    AudioHandler.stopMusic();
    AudioHandler.playGameoverSound();
  }
}

void removeFullRows() {
  var scoreMultiplier = 1;
  var rowsRemoved = 0;
  outer:
  for (var rowNum = Board.matrix.length - 1; rowNum > 0; --rowNum) {
    for (var i = 0; i < Board.matrix[rowNum].length; ++i) {
      if (Board.matrix[rowNum][i] == 0) {
        continue outer;
      }
    }

    Board.matrix.removeAt(rowNum);
    Board.matrix.insert(0, List.filled(NUM_BLOCKS_X, 0));
    ++rowNum;

    Player.score += scoreMultiplier * 100;
    scoreMultiplier *= 2;
    rowsRemoved++;
  }

  // Set player.level based on player.score
  var level = Player.level;
  Player.level = logCeil(Player.score, 1.8);
  if (Player.level > level) {
    AudioHandler.playLevelUpSound();
  } else {
    if (rowsRemoved > 0) {
      AudioHandler.playSweepSound();
    }
  }
}

int logCeil(int x, double base) {
  if (x <= 0) return 1;
  var result = log(x.toDouble() / 100) / log(base > 1 ? base : 1);
  var intResult = result.ceil();
  return intResult > 1 ? intResult : 1;
}

void drawPiecePreview(Canvas canvas, Matrix? piece, double blockWidth, double blockHeight, Pos pos) {
  if (piece == null) return;
  drawMatrix(piece, canvas, blockWidth, blockHeight, pos);
}

void holdPiece() {
  if (!Player.isPlaying) return;
  if (!Player.canHoldPiece) return;
  if (Player.holdPiece == null) {
    Player.lastHeldPiece = Player.holdPiece;
    Player.holdPiece = Player.currentPiece;
    Player.currentPiece = Player.nextPiece;
    Player.nextPiece = getNewPiece();
    Player.currentPiecePos = Pos((NUM_BLOCKS_X / 2 - 2).floor(), 0);
  } else {
    Player.lastHeldPiece = Player.holdPiece;
    final temp = Player.holdPiece;
    Player.holdPiece = Player.currentPiece;
    Player.currentPiece = temp;
    Player.currentPiecePos = Pos((NUM_BLOCKS_X / 2 - 2).floor(), 0);
  }
  Player.ghostPiece = Matrix.from(Player.currentPiece!);
  Player.ghostPiecePos.x = Player.currentPiecePos.x;
  Player.canHoldPiece = false;
}

void resetGame() {
  Player.reset();
  Board.reset();
  TimeHandler.reset();
  AudioHandler.reset();
}

void startNewGame() {
  AudioHandler.playMusic();
  resetGame();
  Player.isPlaying = true;
  nextPiece();
}

void disposeFlutris() {
  resetGame();
  AudioHandler.dispose();
  TimeHandler.dispose();
  if (kDebugMode) {
    print("Game disposed");
  }
}

void onTick(Timer t) {
  if (!Player.isPlaying) return;
  if (Player.pause) return;
  TimeHandler.elapsedTime += TimeHandler.tickDelay;
  final dt = TimeHandler.elapsedTime - TimeHandler.lastTime;
  TimeHandler.lastTime = TimeHandler.elapsedTime;
  TimeHandler.dropCounter += dt;
  if (TimeHandler.dropCounter > (TimeHandler.dropInterval - (Player.level * 50))) {
    if (Player.currentPiece == null) return;
    movePlayerPieceDown();
    // Hack to prevent the app to loose focus for the RawKeyboardListener
    keyboardFocusNode.requestFocus();
  }
}
