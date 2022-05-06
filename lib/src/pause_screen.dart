// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

import 'flutris_widget.dart';
import 'helpers.dart';

Widget makePauseScreen(BuildContext context, double width, double height) {
  return GestureDetector(
    onTap: Flutris.of(context)?.resumeGame,
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(" - Pause -", style: TextStyle(fontFamily: "GameBoy", package: "flutris", color: TEXT_COLOR, fontSize: height * 0.05)),
        ],
      ),
    ),
  );
}
