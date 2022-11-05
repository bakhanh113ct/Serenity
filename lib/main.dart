import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serenity/screen/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:serenity/screen/MainPage.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Serenity',
      theme: ThemeData(
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF226B3F),
          secondary: const Color(0xFF226B3F),
        ),
      ),
      home: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.hasData){
            return const MainPage();
          }
          else {
            return const LoginPage();
          }
        },),
      )
    );
  }
}
