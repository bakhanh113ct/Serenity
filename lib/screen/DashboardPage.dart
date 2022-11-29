import 'package:flutter/material.dart';

import '../routes/Routes.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFEBFDF2),
        child: Column(
          children: [
            ElevatedButton(onPressed: (){Navigator.pushNamed(context, Routes.test);}, child: Text("Test"))
          ],
        ),
      ),
    );
  }
}