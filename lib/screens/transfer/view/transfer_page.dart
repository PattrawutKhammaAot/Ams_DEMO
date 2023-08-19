import 'package:flutter/material.dart';

import '../../../widgets/label.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Label("Transfer"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
