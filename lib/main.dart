import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mentoons/controller/BottomNavBar_Provider/BottomNavBar_Provider.dart';
import 'package:mentoons/controller/login_provider/login_provider.dart';
import 'package:mentoons/controller/splash_provider/splash_provider.dart';
import 'package:mentoons/firebase_options.dart';
import 'package:mentoons/utils/colors.dart';
import 'package:mentoons/view/splash/splash.dart';
import 'package:provider/provider.dart';

void main()async{
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => SplashProvider(),),
      ChangeNotifierProvider(create: (context) => LoginProvider(),),
      ChangeNotifierProvider(create: (context) => BottomNavProvider(),),

    ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home:SplashScreen() ,
      ),
    );
  }
}