import 'package:flutter/material.dart';

class Story {
  final String titleKey;
  final String descriptionKey;
  final String buttonKey;
  final VoidCallback? onPressed;
  final String? externalUrl; // для внешних ссылок

  Story({
    required this.titleKey,
    required this.descriptionKey,
    required this.buttonKey,
    this.onPressed,
    this.externalUrl,
  });
}