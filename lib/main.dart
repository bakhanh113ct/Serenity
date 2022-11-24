import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serenity/bloc/blocCustomer/customer_bloc.dart';
import 'package:serenity/bloc/blocUser/user_bloc.dart';
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
          primaryColor: Color(0xFF226B3F),
          backgroundColor:  Color(0xFFEBFDF2),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFF226B3F),
            secondary: const Color(0xFF226B3F),
          ),
          textTheme: TextTheme(
              headline1:
                  const TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
              headline2: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF226B3F)),
              headline6:
                  const TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
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
          
        ),
         routes: {
        },
      ),
    );
  }
}
