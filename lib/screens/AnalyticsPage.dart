import 'package:flutter/cupertino.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage ({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPage();
}

class _AnalyticsPage extends State<AnalyticsPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Hello analytics'),
    );
  }
}