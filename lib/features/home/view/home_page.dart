

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static final String routeName = 'HomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), backgroundColor: Colors.blue),
      body: const Center(
        child: Text('Welcome to Home Page!', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
