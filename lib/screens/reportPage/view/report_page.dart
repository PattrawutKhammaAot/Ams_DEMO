import 'package:flutter/material.dart';

import '../../../widgets/label.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Label("Report"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
