import 'package:flutter/cupertino.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage ({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPage();
}

class _OverviewPage extends State<OverviewPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Hello overview'),
    );
  }
}