import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sellers_app/auth/authScreens/auth_srceens.dart';
import 'package:sellers_app/firebase_options.dart';
import 'package:sellers_app/global/global.dart';
import 'package:sellers_app/screens/splashScreen/splashview_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sellers App',
          theme: ThemeData(
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: Colors.pinkAccent),
              // This is the theme of your application.
              //
              // iconTheme: IconThemeData(color: Colors.white),
              appBarTheme: AppBarTheme(
                  color: Colors.purple,
                  centerTitle: true,
                  iconTheme: const IconThemeData(color: Colors.white),
                  titleTextStyle:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              //    primaryColor: Colors.purple,
              primarySwatch: Colors.purple),
          home: const MySplashScreen(),
          routes: {
            "homepage": (context) => const HomeScreens(),
            "authscreen": (context) => const AuthScreens(),
            "splashview": (context) => const MySplashScreen(),
          },
        );
      },
    );
  }
}
