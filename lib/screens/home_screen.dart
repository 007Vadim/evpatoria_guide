import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/story.dart';
import '../models/event.dart';
import '../models/news_item.dart';
import 'webview_screen.dart';
import 'events_screen.dart';
import 'news_screen.dart';

class HomeScreen extends StatelessWidget {
  // Мок-данные
  final List<Story> _stories = [
    Story(
      titleKey: 'story_1_title',
      descriptionKey: 'story_1_desc',
      buttonKey: 'book_tour',
      onPressed: () {
        // TODO: открыть экран экскурсий
      },
    ),
    Story(
      titleKey: 'story_2_title',
      descriptionKey: 'story_2_desc',
      buttonKey: 'see_on_map',
      onPressed: () {
        // TODO: открыть карту
      },
    ),
    Story(
      titleKey: 'story_3_title',
      descriptionKey: 'story_3_desc',
      buttonKey: 'find_restaurants',
      onPressed: () {
        // TODO: открыть рестораны в путеводителе
      },
    ),
    Story(
      titleKey: 'story_4_title',
      descriptionKey: 'story_4_desc',
      buttonKey: 'explore',
      onPressed: () {
        // TODO: открыть культурное наследие
      },
    ),
  ];

  final List<Event> _events = [
    Event(title: 'Летний музыкальный фестиваль', date: '15 июля 2026', imageUrl: 'https://via.placeholder.com/80x80'),
    Event(title: 'Художественная выставка', date: '5 августа 2026', imageUrl: 'https://via.placeholder.com/80x80'),
    Event(title: 'Театр', date: '19 августа 2026', imageUrl: 'https://via.placeholder.com/80x80'),
  ];

  final List<NewsItem> _news = [
    NewsItem(title: 'Новость #1', date: '20 июня 2026', imageUrl: 'https://via.placeholder.com/80x80'),
    NewsItem(title: 'Новость #2', date: '18 июня 2026', imageUrl: 'https://via.placeholder.com/80x80'),
    NewsItem(title: 'Новость #3', date: '15 июня 2026', imageUrl: 'https://via.placeholder.com/80x80'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('app_name')),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: AppSearchDelegate());
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'ru') {
                context.setLocale(Locale('ru'));
              } else if (result == 'en') {
                context.setLocale(Locale('en'));
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(value: 'ru', child: Text('Русский')),
              PopupMenuItem(value: 'en', child: Text('English')),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Видеокарточка
              _buildVideoCard(context),

              SizedBox(height: 20),

              // Истории
              Text(tr('stories_title'), style: Theme.of(context).textTheme.titleLarge),
              _buildStoriesList(context),

              SizedBox(height: 20),

              // Общественный транспорт
              _buildSectionCard(
                tr('public_transport'),
                Icons.directions_bus,
                () {
                  // TODO: открыть экран маршрутов автобусов
                },
              ),

              // События
              _buildEventsSection(context),

              // Новости
              _buildNewsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoCard(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(
            'https://via.placeholder.com/400x200?text=Добро+пожаловать+в+Евпаторию!',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tr('welcome_title'), style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: 8),
                Text(tr('welcome_desc')),
                SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WebViewScreen(
                          url: 'https://evpatoria-travel.ru',
                          title: 'Evpatoria Travel',
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.play_arrow),
                  label: Text(tr('watch_video')),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WebViewScreen(
                          url: 'https://evpatoria-travel.ru/guide',
                          title: tr('full_guide'),
                        ),
                      ),
                    );
                  },
                  child: Text(tr('full_guide_button')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoriesList(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _stories.length,
        itemBuilder: (context, index) {
          final story = _stories[index];
          return _buildStoryCard(
            tr(story.titleKey),
            tr(story.descriptionKey),
            tr(story.buttonKey),
            story.onPressed,
            index,
          );
        },
      ),
    );
  }

  Widget _buildStoryCard(String title, String desc, String buttonText, VoidCallback? onPressed, int index) {
    return Card(
      margin: EdgeInsets.only(right: 12),
      child: SizedBox(
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network('https://via.placeholder.com/220x100?text=Story+$index', fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text(desc, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  SizedBox(height: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      textStyle: TextStyle(fontSize: 12),
                    ),
                    onPressed: onPressed,
                    child: Text(buttonText),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, IconData icon, VoidCallback onTap) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildEventsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(tr('upcoming_events'), style: Theme.of(context).textTheme.titleMedium),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => EventsScreen()));
              },
              child: Text(tr('view_all')),
            ),
          ],
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _events.length,
            itemBuilder: (context, index) {
              final event = _events[index];
              return Card(
                margin: EdgeInsets.only(right: 12),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.network(event.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(event.title, style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(event.date, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNewsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(tr('city_news'), style: Theme.of(context).textTheme.titleMedium),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => NewsScreen()));
              },
              child: Text(tr('view_all')),
            ),
          ],
        ),
        SizedBox(height: 8),
        ..._news.map((item) => ListTile(
              leading: Image.network(item.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
              title: Text(item.title),
              subtitle: Text(item.date),
            )),
      ],
    );
  }
}

// Оставим SearchDelegate как заглушку
class AppSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) => [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  @override
  Widget? buildLeading(BuildContext context) => IconButton(icon: Icon(Icons.arrow_back), onPressed: () => close(context, ''));
  @override
  Widget buildResults(BuildContext context) => Center(child: Text('Результаты: $query'));
  @override
  Widget buildSuggestions(BuildContext context) => ListView();
}