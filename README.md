# Flutris
A Retro Tetris Game as Flutter Package

<img src="shots/shot01.png" width="150" height="300" />
<img src="shots/shot02.png" width="150" height="300" />

## Use this package as a library

### Depend on it

With Flutter:

```yaml
dependencies:
  flutris: ^1.0.0
    path: "path/to/flutris-folder"
```

### Import it
Now in your Dart code, you can use:
```dart
import 'package:flutris/flutris.dart';
```


## Usage
```dart
// Imports
import 'package:flutris/flutris.dart';
import 'package:flutter/material.dart';

// Main
void main() {
  runApp(const MyApp());
}

// MyApp
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Tetris",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(title: "Flutter Tetris"),
    );
  }
}

// Main Page
class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

// Main Page State
class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          // All there is needed is to use the Flutris widget
          // The size determines the size of the game area
          // Here we made it responsive bei using a LayoutBuilder
          // and its constraints
          child: Center(child: Flutris(size: constraints.maxHeight)),
        ),
      ),
    );
  }
}

```



