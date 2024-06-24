import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/src/presentation/views/home_screen.dart';
import 'package:todo/src/presentation/views/onBoadring_screen.dart';

 
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  //get value form sharedpres check its true or fale
  final onboarding = prefs.getBool("onboardingScren") ?? false;
 
 //initial Hive 
 await Hive.initFlutter();
 //open a box
  await Hive.openBox('A Box');

  runApp( MyApp(onboarding: onboarding,));

}

class MyApp extends StatelessWidget {
  final bool onboarding;
  const MyApp({super.key,  this.onboarding = false});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
     home: onboarding? HomeScreen() : OnboardingScreen(),
    
    );
  }
}

