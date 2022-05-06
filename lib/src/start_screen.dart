// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

import 'flutris_widget.dart';
import 'helpers.dart';

Column makeStartScreen(BuildContext context, double width, double height) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      SizedBox(height: height * 0.4),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Tetris",
              style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontWeight: FontWeight.bold, fontSize: height * 0.07)),
          SizedBox(height: height * 0.05),
          GestureDetector(
            onTap: () {
              Flutris.of(context)?.setState(() {
                startNewGame();
              });
            },
            child: Center(
              child: Container(
                width: width * 0.6,
                height: height * 0.1,
                decoration: const BoxDecoration(color: TEXT_COLOR),
                child: Center(
                    child: Text("Start", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: BACK_COLOR, fontSize: height * 0.04))),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: height * 0.25),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(width: width * 0.025),
          GestureDetector(
            onTap: () {
              Flutris.of(context)?.setState(() {
                Player.showHelp = true;
              });
            },
            child: Container(
              width: width * 0.18,
              height: height * 0.1,
              decoration: const BoxDecoration(color: TEXT_COLOR),
              child:
                  Center(child: Text(" ?", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: BACK_COLOR, fontSize: height * 0.04))),
            ),
          ),
          Expanded(child: Container()),
          Text("Rednib Games ", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.02)),
        ],
      )
    ],
  );
}
