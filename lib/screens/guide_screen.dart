import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key});

  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Только для Android/iOS (не для веба)
    if (!kIsWeb && Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Путеводитель')),
      body: WebView(
        initialUrl: 'about:blank', // Заглушка
        onWebViewCreated: (controller) {
          _controller = controller;
          // Загружаем HTML из asset'ов через data URI (без file://)
          _loadLocalHtml();
        },
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (request) {
          // Разрешаем загрузку только Яндекса и локального контента
          if (request.url.startsWith('https://api-maps.yandex.ru') ||
              request.url.startsWith('about:blank')) {
            return NavigationDecision.navigate;
          }
          // Открываем внешние ссылки в браузере
          if (request.url.startsWith('http')) {
            launchUrl(Uri.parse(request.url));
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }

  Future<void> _loadLocalHtml() async {
    // Читаем HTML из asset'ов
    String html = await DefaultAssetBundle.of(context).loadString('assets/map/yandex_map.html');
    
    // Подставляем API-ключ (лучше хранить в .env или в native-коде)
    final apiKey = '74334393-3048-4d8f-ae9e-b9c2341dc78f'; // ← Замените на свой
    html = html.replaceAll('74334393-3048-4d8f-ae9e-b9c2341dc78f', apiKey);

    // Загружаем как data:text/html
    _controller.loadUrl(
      Uri.dataFromString(
        html,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ).toString(),
    );
  }
}