import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_scaper/home_controller.dart';
import 'package:sky_scaper/home_page.dart';
import 'package:sky_scaper/splash_screen.dart';
import 'package:sky_scaper/theme_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
            create: (context) => HomeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (BuildContext context, themeProvider, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            initialRoute: "/",
            routes: {
              "/": (context) => SplashScreen(),
              "home_page": (context) => HomePage(),
            },
          );
        },
      ),
    );
  }
}