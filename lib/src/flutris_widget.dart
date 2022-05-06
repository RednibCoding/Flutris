// ignore_for_file: constant_identifier_names, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, must_be_immutable

import 'dart:async';

import 'package:flutris/src/game_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'gameover_screen.dart';
import 'help_screen.dart';
import 'helpers.dart';
import 'pause_screen.dart';
import 'start_screen.dart';

// #####################################################################################
//     Widget
// #####################################################################################

class Flutris extends StatefulWidget {
  double width = 0;
  double boardWidth = 0;
  double height = 0;
  bool muteSound;
  bool muteMusic;
  Flutris({Key? key, required sizeHeight, this.muteSound = false, this.muteMusic = false}) : super(key: key) {
    height = sizeHeight;
    width = sizeHeight;
    boardWidth = width * 0.75;
  }

  static _TetrisState? of(BuildContext context) => context.findAncestorStateOfType<_TetrisState>();

  @override
  State<Flutris> createState() => _TetrisState();
}

class _TetrisState extends State<Flutris> with WidgetsBindingObserver {
  @override
  void initState() {
    AudioHandler.init();
    AudioHandler.setFlags(soundOn: !widget.muteSound, musicOn: !widget.muteMusic);
    TimeHandler.timer = Timer.periodic(Duration(milliseconds: TimeHandler.tickDelay), (timer) {
      setState(() {
        onTick(timer);
      });
    });
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    disposeFlutris();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      pauseGame();
    }
    if (state == AppLifecycleState.resumed) {
      resumeGame();
    }
  }

  void pauseGame() {
    setState(() {
      Player.pause = true;
      if (kDebugMode) {
        print('Game paused');
      }
    });
    AudioHandler.stopMusic();
  }

  void resumeGame() {
    setState(() {
      Player.pause = false;
      if (kDebugMode) {
        print('Game resumed');
      }
    });
    AudioHandler.playMusic();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.width > widget.height / 2) {
      widget.width = widget.height / 2;
    }
    return WillPopScope(
      onWillPop: () async {
        resetGame();
        disposeFlutris();
        return true;
      },
      child: RawKeyboardListener(
        autofocus: true,
        focusNode: keyboardFocusNode,
        onKey: (e) {
          // Support keyboad input
          if (e.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
            if (e.isShiftPressed) {
              landPiece(Player.currentPiece, Player.currentPiecePos);
            } else {
              movePlayerPieceDown();
            }
          } else if (e.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
            rotate(1);
          } else if (e.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
            moveHorizontal(-1);
          } else if (e.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
            moveHorizontal(1);
          } else if (e.isKeyPressed(LogicalKeyboardKey.controlLeft)) {
            holdPiece();
          } else if (e.isKeyPressed(LogicalKeyboardKey.escape)) {
            resetGame();
          } else if (e.isKeyPressed(LogicalKeyboardKey.space)) {
            if (!Player.pause) {
              pauseGame();
            } else {
              resumeGame();
            }
          }
        },
        child: SizedBox(
          width: widget.width + 2,
          height: widget.height + 2,
          child: LayoutBuilder(
            builder: (context, constraints) => Container(
              decoration: BoxDecoration(
                color: BACK_COLOR,
                border: Border.all(
                  color: TEXT_COLOR,
                  width: 1,
                ),
              ),
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Player.isPlaying
                  ? Player.pause
                      ? makePauseScreen(context, widget.width, widget.height)
                      : makeGameField(context, widget, constraints.maxWidth, constraints.maxHeight)
                  : Player.isGameOver
                      ? makeGameoverScreen(context, widget.width, widget.height)
                      : Player.showHelp
                          ? makeHelpScreen(context, widget.width, widget.height)
                          : makeStartScreen(context, widget.width, widget.height),
            ),
          ),
        ),
      ),
    );
  }
}

class TetrisPainter extends CustomPainter {
  final double blockWidth, blockHeight;

  TetrisPainter({required this.blockWidth, required this.blockHeight});

  @override
  void paint(Canvas canvas, Size size) {
    drawGhostPiece(canvas, blockWidth, blockHeight);
    drawPlayerPiece(canvas, blockWidth, blockHeight);
    drawBoard(canvas, blockWidth, blockHeight);
    drawPiecePreview(canvas, Player.nextPiece, blockWidth / 3, blockHeight / 3, Pos(25, 3));
    drawPiecePreview(canvas, Player.holdPiece, blockWidth / 3, blockHeight / 3, Pos(2, 3));
  }

  @override
  bool shouldRepaint(TetrisPainter oldDelegate) => true;
}
