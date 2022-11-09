import 'package:flutter/material.dart';

class TroublePage extends StatefulWidget {
  const TroublePage({super.key});

  @override
  State<TroublePage> createState() => _TroublePageState();
}

class _TroublePageState extends State<TroublePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Trouble')),
    );
  }
}