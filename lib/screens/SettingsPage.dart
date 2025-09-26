import 'package:flutter/cupertino.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage ({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Hello settings'),
    );
  }
}