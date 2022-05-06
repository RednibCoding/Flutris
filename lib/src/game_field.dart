import 'package:flutter/material.dart';

import 'flutris_widget.dart';
import 'helpers.dart';

Stack makeGameField(BuildContext context, Flutris widget, double width, double height) {
  return Stack(
    children: [
      CustomPaint(painter: TetrisPainter(blockWidth: widget.width / NUM_BLOCKS_X, blockHeight: widget.height / NUM_BLOCKS_Y)),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: holdPiece,
                child: Container(
                  height: height * 0.15,
                  width: width * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: BACK_COLOR_DARK,
                      width: 1,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: Flutris.of(context)?.pauseGame,
                child: Container(
                  height: height * 0.15,
                  width: width * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: BACK_COLOR_DARK,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(child: Container()),
          GestureDetector(
            onTap: () => rotate(1),
            onLongPress: () => landPiece(Player.currentPiece, Player.currentPiecePos),
            onVerticalDragStart: (details) {
              TouchHandler.dragStartY = details.localPosition.dy;
            },
            onVerticalDragEnd: (details) {
              TouchHandler.reset();
            },
            onVerticalDragUpdate: (details) {
              if (details.delta.dy > 0) {
                if (TouchHandler.dragDirectionY != 1) {
                  TouchHandler.reset();
                  TouchHandler.dragDirectionY = 1;
                  TouchHandler.dragStartY = details.localPosition.dy;
                }
                TouchHandler.dragEndY = details.localPosition.dy;
                final distance = TouchHandler.dragEndY - TouchHandler.dragStartY;
                final blockHeight = widget.height / NUM_BLOCKS_Y;
                if (distance > blockHeight) {
                  movePlayerPieceDown();
                  TouchHandler.dragStartY = TouchHandler.dragEndY;
                  TouchHandler.dragEndY = 0;
                }
              } else if (details.delta.dy < 0) {
                if (TouchHandler.dragDirectionY != -1) {
                  TouchHandler.reset();
                  TouchHandler.dragDirectionY = -1;
                  TouchHandler.dragStartY = details.localPosition.dy;
                }
              }
            },
            onHorizontalDragStart: (details) {
              TouchHandler.dragStartX = details.localPosition.dx;
            },
            onHorizontalDragEnd: (details) {
              TouchHandler.reset();
            },
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx > 0) {
                if (TouchHandler.dragDirectionX != 1) {
                  TouchHandler.reset();
                  TouchHandler.dragDirectionX = 1;
                  TouchHandler.dragStartX = details.localPosition.dx;
                }
                TouchHandler.dragEndX = details.localPosition.dx;
                final distance = TouchHandler.dragEndX - TouchHandler.dragStartX;
                final blockWidth = widget.width / NUM_BLOCKS_X;
                if (distance > blockWidth) {
                  moveHorizontal(1);
                  TouchHandler.dragStartX = TouchHandler.dragEndX;
                  TouchHandler.dragEndX = 0;
                }
              } else if (details.delta.dx < 0) {
                if (TouchHandler.dragDirectionX != -1) {
                  TouchHandler.reset();
                  TouchHandler.dragDirectionX = -1;
                  TouchHandler.dragStartX = details.localPosition.dx;
                }
                TouchHandler.dragEndX = details.localPosition.dx;
                final distance = TouchHandler.dragStartX - TouchHandler.dragEndX;
                final blockWidth = widget.width / NUM_BLOCKS_X;
                if (distance > blockWidth) {
                  moveHorizontal(-1);
                  TouchHandler.dragStartX = TouchHandler.dragEndX;
                }
              }
            },
            child: Container(
              alignment: Alignment.bottomCenter,
              height: height * 0.8,
              width: width,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
      Container(
        height: height * 0.04,
        decoration: BoxDecoration(
          color: BACK_COLOR,
          border: Border.all(
            color: TEXT_COLOR,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(" Hold",
                style: TextStyle(
                    fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontWeight: FontWeight.bold, fontSize: widget.height * 0.02)),
            Text("Lv ${Player.level}",
                style: TextStyle(
                    fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontWeight: FontWeight.bold, fontSize: widget.height * 0.012)),
            Text("Pts ${Player.score}",
                style: TextStyle(
                    fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontWeight: FontWeight.bold, fontSize: widget.height * 0.012)),
            Text("Next ",
                style: TextStyle(
                    fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontWeight: FontWeight.bold, fontSize: widget.height * 0.02)),
          ],
        ),
      ),
    ],
  );
}
