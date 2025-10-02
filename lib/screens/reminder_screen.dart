import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ReminderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('reminder'))),
      body: Center(
        child: Text('Памятка туристу'),
      ),
    );
  }
}