import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dep_college_app/Screens/home.dart';
import 'package:dep_college_app/Screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Assistant',
      debugShowCheckedModeBanner: false,
      // home: LoginScreen(),
      home: LoginScreen(),
      routes: {
        // '/homepage': (ctx) => HomeScreen(),
        '/login': (ctx) => LoginScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => HomeScreen());
      },
    );
  }
}
