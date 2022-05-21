import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/core/constants/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:step_counter/ui/pages/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();

  await Hive.openBox<int>('steps');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = AppColors();
    return Sizer(
      builder: ((context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            appBarTheme: AppBarTheme(backgroundColor: appColors.darkGreen),
            scaffoldBackgroundColor: appColors.scaffoldBack,
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
        );
      }),
    );
  }
}
