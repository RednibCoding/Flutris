// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

import 'flutris_widget.dart';
import 'helpers.dart';

Column makeGameoverScreen(BuildContext context, double width, double height) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Game Over",
          style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontWeight: FontWeight.bold, fontSize: height * 0.05)),
      SizedBox(height: height * 0.1),
      Text("Level: ${Player.level}", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.03)),
      SizedBox(height: height * 0.05),
      Text("Score:", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.03)),
      SizedBox(height: height * 0.01),
      Text("${Player.score}", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.03)),
      SizedBox(height: height * 0.06),
      GestureDetector(
        onTap: () {
          Flutris.of(context)?.setState(() {
            startNewGame();
          });
        },
        child: Container(
          width: width * 0.6,
          height: height * 0.1,
          decoration: const BoxDecoration(color: TEXT_COLOR),
          child:
              Center(child: Text("Start", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: BACK_COLOR, fontSize: height * 0.04))),
        ),
      ),
    ],
  );
}
