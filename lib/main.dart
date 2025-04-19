import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const KaevoxApp());

  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(1280, 720);
    win.minSize = Size(640, 480);
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Kaevox";
    win.show();
    }
  );
}

// colors
const borderColor = Color(0xFFFFFFFF);
const sidebarColor = Color(0xff1199ff);
const backgroundStartColor = Color(0xFFFFFFFF);
const backgroundEndColor = Color.fromARGB(255, 176, 219, 255);


final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFF805306),
    mouseOver: const Color(0xFFF6A00C),
    mouseDown: const Color(0xFF805306),
    iconMouseOver: const Color(0xFF805306),
    iconMouseDown: const Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFF805306),
    iconMouseOver: Colors.white);

// ACTUAL APP SHITE

class KaevoxApp extends StatelessWidget {
  const KaevoxApp({Key? key}) : super(key: key);
    
  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WindowBorder(
          color: borderColor,
          width: 1,
          child: Row(
            children: const [LeftSide(), RightSide()],
          )
        )
      )
    );
  }
}



class LeftSide extends StatelessWidget {
  const LeftSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return SizedBox(
      width: 200,
      child: Container(
        color: sidebarColor,
        child: Column(
          children: [
            WindowTitleBarBox(child: MoveWindow()),
            Expanded(child: Container())
          ]
        )
      )
    );
  }
}



class RightSide extends StatelessWidget {
  const RightSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [backgroundStartColor, backgroundEndColor],
            stops: [0.0, 1.0]
          ),
        ),
        child: Column(
          children: [
            WindowTitleBarBox(
              child: Row(
                children: [
                  Expanded(
                    child: MoveWindow(),
                  ),
                  const WindowButtons(),
                ]
              ),
            )
          ],
        )
      )
    );
  }
}



class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}


class KaevoxState extends ChangeNotifier {
  var current = "Hello World!";
}

class KaevoxHomePage extends StatelessWidget {
  const KaevoxHomePage({super.key});

  @override
  Widget build(BuildContext ctx) {
    var appState = ctx.watch<KaevoxState>();

    return Scaffold(
      body: Column(
        children: [
          Text('Kaevox boilerplate work'),
          Text(appState.current)
        ]
      )
    );
  }
}