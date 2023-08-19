import 'package:ams_count/widgets/label.dart';
import 'package:flutter/material.dart';

class MyAssetsPage extends StatefulWidget {
  const MyAssetsPage({super.key});

  @override
  State<MyAssetsPage> createState() => _MyAssetsPageState();
}

class _MyAssetsPageState extends State<MyAssetsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Label("My Assets"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
