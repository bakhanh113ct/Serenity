import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serenity/bloc/blocDeliveryReceipt/delivery_receipt_bloc.dart';
import 'package:serenity/bloc/blocReceiptDocument/receipt_document_bloc.dart';
import 'package:serenity/routes/Routes.dart';
import 'package:serenity/screen/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:serenity/screen/MainPage.dart';

import 'package:serenity/screen/cart_page.dart';

import 'bloc/blocCart/bloc/cart_bloc.dart';
import 'bloc/blocCheckOut/bloc/checkout_bloc.dart';
import 'bloc/blocExportBook/export_book_bloc.dart';
import 'bloc/blocImportBook/import_book_bloc.dart';
import 'bloc/blocOrder/order_bloc.dart';
import 'package:serenity/bloc/employee/employee_bloc.dart';
import 'package:serenity/bloc/importOrder/import_order_bloc.dart';

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
        BlocProvider(create: (context) => ReceiptDocumentBloc()),
        BlocProvider(create: (context) => ReportTroubleBloc()),
        BlocProvider(create: (context) => ImportBookBloc()),
        BlocProvider(create: (context) => ExportBookBloc()),
        BlocProvider(create: (context) => DeliveryReceiptBloc()),
        BlocProvider(
            create: (context) => ImportOrderBloc()..add(LoadImportOrder())),
        BlocProvider(create: (context) => EmployeeBloc()..add(LoadEmployee())),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Serenity',
          theme: ThemeData(
            fontFamily: "Poppins",
            // canvasColor: Color(0xFF226B3F),
            primaryColor: const Color(0xFF226B3F),
            backgroundColor: const Color(0xFFEBFDF2),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xFF226B3F),
              secondary: const Color(0xFF226B3F),
            ),
            textTheme: const TextTheme(
              headline1: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 30,
                            color: Color(0xFF226B3F),
                            fontWeight: FontWeight.w600),
              headline2: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF226B3F)),
              headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            ),
          ),
          home: Scaffold(
            resizeToAvoidBottomInset: false,
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
    case Routes.cart:
      {
        return MaterialPageRoute(
            builder: (context) => const CartPage(), settings: settings);
      }
  }
  return null;
}
