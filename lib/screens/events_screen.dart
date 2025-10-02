import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class EventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('upcoming_events'))),
      body: Center(child: Text('Список всех событий\n(интеграция с evpatoria-travel.ru/events)')),
    );
  }
}