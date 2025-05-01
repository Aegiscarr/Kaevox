import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(KaevoxApp(savedThemeMode: savedThemeMode));

  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(1280, 720);
    win.minSize = Size(640, 480);
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Kaevox";
    win.show();
    player.play(DeviceFileSource("Z:\\Horizon\\Music\\nty\\Boris Johnson is STILL a Fucking Cunt [O8dF_iSGp1o].mp3"));
    }
  );
}

const String kvxLogo = 'assets/kvx.svg';
final player = AudioPlayer();

bool isDarkMode() {
    final darkMode = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    if (darkMode == Brightness.dark) {
      log('is dark mode');
      return true;
    } else {
      log('is not dark mode');
      return false;
    } 
  }

// colors
const borderColor = Color(0xFFFFFFFF);
const sidebarColor = Color(0xff1199ff);
const backgroundStartColor = Color(0xFFFFFFFF);
const backgroundEndColor = Color.fromARGB(255, 176, 219, 255);


final buttonColors = WindowButtonColors(
    iconNormal: const Color.fromARGB(255, 6, 79, 128),
    mouseOver: const Color.fromARGB(255, 12, 133, 246),
    mouseDown: const Color.fromARGB(255, 6, 83, 128),
    iconMouseOver: const Color.fromARGB(255, 6, 73, 128),
    iconMouseDown: const Color.fromARGB(255, 0, 102, 255));

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color.fromARGB(255, 128, 6, 6),
    iconMouseOver: Colors.white);

// app

class KaevoxApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const KaevoxApp({super.key, this.savedThemeMode});
  
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
      ),
      dark: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      // overrideMode: AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Adaptive Theme Demo',
        theme: theme,
        darkTheme: darkTheme,
        home: const KaevoxHomePage(),
      ),
      debugShowFloatingThemeButton: true,
    );
  }
}

//class LeftSide extends StatelessWidget {
//  const LeftSide({super.key});
//
//  @override
//  Widget build(BuildContext ctx) {
//    return SizedBox(
//      width: 200,
//      child: Container(
//        color: Theme.of(ctx).colorScheme.inversePrimary,
//        child: Column(
//          children: [
//            kvxAsset,
//            WindowTitleBarBox(child: MoveWindow()),
//            Expanded(child: Container()),
//            
//          ]
//        )
//      )
//    );
//  }
//}

class RightSide extends StatelessWidget {
  const RightSide({super.key});

  @override
  Widget build(BuildContext ctx) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Theme.of(ctx).colorScheme.surface, Theme.of(ctx).colorScheme.surfaceContainerHigh],
            stops: [0.0, 1.0]
          ),
        ),
        child: Column(
          children: [
            WindowTitleBarBox(
              child: Row(
                children: [
                  Container(
                    width: 130,
                    child: kvxAsset,
                  ),
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
  const WindowButtons({super.key});
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: WindowBorder(
        color: borderColor,
        width: 1,
        child: Row(
          children: const [RightSide()],
        )
      )
    );
  }
}

final Widget kvxAsset = SvgPicture.asset(
  kvxLogo,
  colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
  semanticsLabel: 'Kaevox Logo',
);