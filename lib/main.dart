import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intelligent_learning/Games/Connect4/ScreenParts/welcome.dart';
import 'package:intelligent_learning/model/MyDataModelAdapter.dart';
import 'package:provider/provider.dart';
import 'package:intelligent_learning/GoogleSheet/user_sheets_api.dart';
import 'package:intelligent_learning/Games/FlappyBird/game.dart';
import 'package:intelligent_learning/Games/FlappyBird/game_manager.dart';
import 'package:intelligent_learning/Games/TicTacToc/screens/pickup_screen.dart';
import 'package:intelligent_learning/Games/Momory/memory1.dart';
import 'package:intelligent_learning/Games/Momory/memory2.dart';
import 'package:intelligent_learning/model/Theme.dart';
import 'package:intelligent_learning/Authentication/login/login.dart';
import 'package:intelligent_learning/Authentication/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';


late SharedPreferences sharedPref;
GetIt getIt = GetIt.instance;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserSheetsApi.init();
  getIt.registerSingleton<GameManager>(GameManager());
  sharedPref = await SharedPreferences.getInstance();
  await Hive.initFlutter();
  Hive.registerAdapter(MyDataModelAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
          builder: (context, ModelTheme themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          routes: {
            "login": (context) => LoginScreen(),
            "memory": (context) => Memory1(),
            "mem2": (context) => Memory2(),
            "flappy": (context) => FlappyGame(),
            "TicTacToc": (context) => PickUpScreen(),
            "connect4": (context) => Welcome(),
          },
          theme: themeNotifier.isDark
              ? ThemeData(
                  brightness: Brightness.dark,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                )
              : ThemeData(
                  brightness: Brightness.light,
                  primaryColor: Colors.green,
                  primarySwatch: Colors.green,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
        );
      }),
    );
  }
}
