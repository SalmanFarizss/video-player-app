import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:lilac_task_app/features/auth/screens/splash_screen.dart';
import 'package:lilac_task_app/features/home/screens/home_screen.dart';
import 'package:lilac_task_app/theme/palette.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().whenComplete(() => print('initialization completed'));
  runApp(const ProviderScope(child: MyApp()));
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    if (Platform.isAndroid) {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    }
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Consumer(
      builder: (context,ref,child) {
        bool isDarkMode=ref.watch(darkThemeProvider);
        return MaterialApp(
          theme:isDarkMode?Palette.darkModeAppTheme:Palette.lightModeAppTheme,
          darkTheme: Palette.darkModeAppTheme,
          debugShowCheckedModeBanner: false,
          home: const SplashScreen()
        );
      }
    );
  }
}
