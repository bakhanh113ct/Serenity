import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serenity/repository/AuthRepository.dart';

import 'package:sidebarx/sidebarx.dart';

import '../bloc/blocUser/user_bloc.dart';
import '../bloc/blocUser/user_state.dart';
import '../model/User.dart';

class SideBar extends StatelessWidget {
  SideBar({super.key, required this.controller, required this.user});
  final SidebarXController controller;
  final User user;
  final admin=[SidebarXItem(icon: Icons.local_florist, label: 'Product'),
            SidebarXItem(icon: Icons.list_alt, label: 'Order'),
            SidebarXItem(icon: Icons.person, label: 'Customer'),
            SidebarXItem(icon: Icons.local_shipping, label: 'Import'),
            SidebarXItem(icon: Icons.error, label: 'Trouble'),
            SidebarXItem(icon: Icons.warehouse, label: 'Warehouse'),
            SidebarXItem(icon: Icons.support_agent, label: 'Employee'),
            SidebarXItem(icon: Icons.manage_accounts, label: 'Profile'),
            SidebarXItem(icon: Icons.dashboard, label: 'Report'),];
  final staff=[SidebarXItem(icon: Icons.local_florist, label: 'Product'),
            SidebarXItem(icon: Icons.list_alt, label: 'Order'),
            SidebarXItem(icon: Icons.person, label: 'Customer'),
            SidebarXItem(icon: Icons.local_shipping, label: 'Import'),
            SidebarXItem(icon: Icons.error, label: 'Trouble'),
            SidebarXItem(icon: Icons.warehouse, label: 'Warehouse'),
            SidebarXItem(icon: Icons.support_agent, label: 'Employee'),
            SidebarXItem(icon: Icons.manage_accounts, label: 'Profile'),
          ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if(state is UserLoading){
          return Container();
        }
        else if(state is UserLoaded){
          return SidebarX(
          extendedTheme: const SidebarXTheme(width: 220),
          controller: controller,
          theme: SidebarXTheme(
            margin: const EdgeInsets.all(10),
            iconTheme: const IconThemeData(color: Color(0xFFA09E9E), size: 32),
            itemTextPadding: const EdgeInsets.only(left: 35),
            selectedItemTextPadding: const EdgeInsets.only(left: 35),
            selectedIconTheme:
                const IconThemeData(color: Colors.white, size: 32),
            textStyle: const TextStyle(
                fontSize: 19,
                color: Color(0xFFA09E9E),
                fontWeight: FontWeight.w500),
            selectedTextStyle: const TextStyle(
                fontSize: 19, color: Colors.white, fontWeight: FontWeight.w500),
            selectedItemDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF226B3F)),
          ),
          headerBuilder: (context, extended) {
            return Padding(
              padding: EdgeInsets.only(top: 25),
              child: SizedBox(
                height: 120,
                width: 120,
                child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              radius: (52),
                              backgroundColor: Colors.transparent,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  state.user.image!,
                                  fit: BoxFit.cover,
                                ),
                              )))
              ),
            );
          },
          footerDivider: Divider(
              color: const Color(0xFFA09E9E).withOpacity(0.5), height: 1),
          items: state.user.position=="admin"?admin:staff,
          footerBuilder: (context, extended) {
            return Padding(
                padding: const EdgeInsets.only(top: 25),
                child: IconButton(
                  icon: const Icon(
                    Icons.door_back_door,
                    size: 32,
                    color: Color(0xFFA09E9E),
                  ),
                  onPressed: () {
                    AuthRepository().SignOut();
                  },
                ));
          },
        );
        } 
        else{
          return Container();
        } 
      },
    );
  }
}
