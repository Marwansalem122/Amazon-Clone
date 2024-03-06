import 'package:amazonclone/assistant_method/cart_item_counter.dart';
import 'package:amazonclone/auth/authScreens/auth_srceens.dart';
import 'package:amazonclone/firebase_options.dart';
import 'package:amazonclone/global/global.dart';
import 'package:amazonclone/sellers_screens/home/home_screen.dart';
import 'package:amazonclone/sellers_screens/splashview/splashview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'assistant_method/total_ammount.dart';
import 'assistant_method/address_changeer.dart';

Future<void> main() async {
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartItemCounter()),
        ChangeNotifierProvider(create: (context) => TotalAmount()),
        ChangeNotifierProvider(create: (context) => AddressChanger()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Users App',
            theme: ThemeData(
                // This is the theme of your application.
                //
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: Colors.pinkAccent,
                ),
                appBarTheme: AppBarTheme(
                    color: Colors.purple,
                    centerTitle: true,
                    titleTextStyle: TextStyle(
                        fontSize: 24.sp, fontWeight: FontWeight.bold)),
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
                //    primaryColor: Colors.purple,
                primarySwatch: Colors.purple),
            home: const MySplashScreen(),
            routes: {
              "homepage": (context) => const HomeScreens(),
              "authscreen": (context) => const AuthScreens(),
              "splashview": (context) => const MySplashScreen(),
            }, //MySplashScreen() //HomeScreens(),
          );
        },
      ),
    );
  }
}
