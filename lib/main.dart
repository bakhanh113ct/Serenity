import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serenity/bloc/blocReport/bloc/report_bloc.dart';
import 'package:serenity/routes/Routes.dart';
import 'package:serenity/screen/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:serenity/screen/MainPage.dart';

import 'package:serenity/screen/cart_page.dart';

import 'bloc/blocCart/bloc/cart_bloc.dart';
import 'bloc/blocCheckOut/bloc/checkout_bloc.dart';
import 'bloc/blocDetailOrder/bloc/detail_order_bloc.dart';
import 'bloc/blocOrder/order_bloc.dart';
import 'package:serenity/bloc/employee/employee_bloc.dart';
import 'package:serenity/bloc/importOrder/import_order_bloc.dart';


import 'bloc/blocProduct/bloc/product_bloc.dart';
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
        BlocProvider(create: (context) => OrderBloc()),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => CheckoutBloc()),
        BlocProvider(create: (context) => CustomerBloc()),
        BlocProvider(create: (context) => TroubleBloc()),
        BlocProvider(
            create: (context) => ImportOrderBloc()..add(LoadImportOrder())),
        BlocProvider(create: (context) => EmployeeBloc()..add(LoadEmployee())),
        BlocProvider(create: (context) => ReportBloc()..add(LoadReport())),
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(create: (context) => DetailOrderBloc()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Serenity',
          theme: ThemeData(
            fontFamily: "Poppins",
            // canvasColor: Color(0xFF226B3F),
            primaryColor: Color(0xFF226B3F),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xFF226B3F),
              secondary: const Color(0xFF226B3F),
            ),
          ),
          onGenerateRoute: getRoute,
          home: Scaffold(
            // resizeToAvoidBottomInset: false,
            body: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  return const MainPage();
                } else {
                  return const LoginPage();
                }
              },
            ),
          )),
    );
  }
}

Route? getRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.cart:{
      return MaterialPageRoute(
            builder: (context) => const CartPage(), settings: settings);
    }
  }
  return null;
}
