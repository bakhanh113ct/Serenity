import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serenity/repository/AuthRepository.dart';
import 'package:serenity/screen/DashboardPage.dart';
import 'package:serenity/screen/EmployeePage.dart';
import 'package:serenity/screen/ImportPage.dart';
import 'package:serenity/screen/OrderPage.dart';
import 'package:serenity/screen/ProductPage.dart';
import 'package:serenity/screen/ProfilePage.dart';
import 'package:serenity/screen/TroublePage.dart';
import 'package:serenity/widget/SideBar.dart';
import 'package:sidebarx/sidebarx.dart';

import '../bloc/blocUser/user_bloc.dart';
import 'CustomerPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = SidebarXController(selectedIndex: 0, extended: true);
  final pages = [const DashBoardPage(), const OrderPage()];
  int currentIndex = 0;
  onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(LoadUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<UserBloc,UserState>(
      builder: (BuildContext context, state) {
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFF226B3F),));
        } else if (state is UserLoaded) {
          return Row(
            children: [
              SideBar(controller: controller,user: state.user,),
              Expanded(
                  child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  // final pageTitle = _getTitleByIndex(controller.selectedIndex);
                  switch (controller.selectedIndex) {
                    case 0:
                      return DashBoardPage();
                    case 1:
                      return OrderPage();
                      case 2:
                      return ProductPage();
                    case 3:
                      return CustomerPage();
                      case 4:
                      return ImportPage();
                    case 5:
                      return TroublePage();
                      case 6:
                      return EmployeePage();
                    case 7:
                      return ProfilePage();
                    default:
                      return DashBoardPage();
                  }
                },
              )) // Your app screen body
            ],
          );
        }
        else{
          return Container();
        }
      },
    ));
  }
}
