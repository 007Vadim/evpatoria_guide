import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('city_news'))),
      body: Center(child: Text('Список всех новостей\n(интеграция с evpatoria-travel.ru/news)')),
    );
  }
}