// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

import 'flutris_widget.dart';
import 'helpers.dart';

Widget makeHelpScreen(BuildContext context, double width, double height) {
  return GestureDetector(
    onTap: () {
      Flutris.of(context)?.setState(() {
        Player.showHelp = false;
      });
    },
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(" -Controls-", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.04)),
          SizedBox(height: height * 0.04),
          Text("-Keyboard-", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.030)),
          SizedBox(height: height * 0.016),
          Text(" Arrow keys: L R D U", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.02)),
          SizedBox(height: height * 0.01),
          Text("        L R: move L R", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.018)),
          Text("           D: move donw", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.018)),
          Text("           U: rotate clw", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.018)),
          Text("     STRG: hold", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.018)),
          Text("Shift D: land", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.018)),
          Text("   Space: pause", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.018)),
          Text("       ESC: exit", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.018)),
          SizedBox(height: height * 0.04),
          Text("-TOUCH-", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.030)),
          SizedBox(height: height * 0.016),
          Text("        Swipe: L R D", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.02)),
          SizedBox(height: height * 0.01),
          Text("               L R: move L R",
              style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.018)),
          Text("                  D: move donw",
              style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.018)),
          Text("              Tap: rotate clw",
              style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.018)),
          Text("     Long Tap: land", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.018)),
          Text("Tap on hold: hold", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.018)),
          Text("Tap on next: pause", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.018)),
          Text("            Back: exit", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.018)),
        ],
      ),
    ),
  );
}
