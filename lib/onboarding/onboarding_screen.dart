import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../app.dart';
import '../services/preferences_service.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  final List<OnboardingPageData> _pages = [
    OnboardingPageData(
      title: 'onboarding_title_1',
      description: 'onboarding_desc_1',
    ),
    OnboardingPageData(
      title: 'onboarding_title_2',
      description: 'onboarding_desc_2',
    ),
    OnboardingPageData(
      title: 'onboarding_title_3',
      description: 'onboarding_desc_3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: _pages.length,
        itemBuilder: (context, index) {
          return OnboardingPage(
            data: _pages[index],
            isLast: index == _pages.length - 1,
            onSkip: _onSkip,
            onDone: _onDone,
          );
        },
      ),
    );
  }

  void _onSkip() async {
    await PreferencesService().setOnboardingSeen();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => EvpatoriaApp()),
      (route) => false,
    );
  }

  void _onDone() async {
    await PreferencesService().setOnboardingSeen();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => EvpatoriaApp()),
      (route) => false,
    );
  }
}

class OnboardingPageData {
  final String title;
  final String description;
  const OnboardingPageData({required this.title, required this.description});
}

class OnboardingPage extends StatelessWidget {
  final OnboardingPageData data;
  final bool isLast;
  final VoidCallback onSkip;
  final VoidCallback onDone;

  const OnboardingPage({
    Key? key,
    required this.data,
    required this.isLast,
    required this.onSkip,
    required this.onDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Кнопка "Пропустить"
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: onSkip,
                child: Text(
                  tr('skip'),
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),
            ),
            SizedBox(height: 40),

            // Иконка или изображение (заглушка)
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isLast ? Icons.info : Icons.explore,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            SizedBox(height: 40),

            // Заголовок
            Text(
              tr(data.title),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            SizedBox(height: 16),

            // Описание
            Text(
              tr(data.description),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[700],
                  ),
            ),

            Spacer(),

            // Кнопка "Поехали" или ничего
            if (isLast)
              ElevatedButton(
                onPressed: onDone,
                child: Text(tr('get_started')),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}