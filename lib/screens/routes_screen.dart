import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class RoutesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('routes'))),
      body: Center(
        child: Text('Маршруты'),
      ),
    );
  }
}