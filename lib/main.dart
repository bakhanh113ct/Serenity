import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serenity/screen/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:serenity/screen/MainPage.dart';

import 'bloc/bloc_exports.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => CustomerBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Serenity',
        theme: ThemeData(
          fontFamily: "Poppins",
          // canvasColor: Color(0xFF226B3F),
          primaryColor: const Color(0xFF226B3F),
          backgroundColor:  const Color(0xFFEBFDF2),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFF226B3F),
            secondary: const Color(0xFF226B3F),
          ),
          textTheme: const TextTheme(
              headline1:
                  TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
              headline2: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF226B3F)),
              headline6:
                  TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          ),
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
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
          
        ),
         routes: const {
        },
      ),
    );
  }
}
