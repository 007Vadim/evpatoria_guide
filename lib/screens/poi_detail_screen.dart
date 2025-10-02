import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/poi.dart';
import 'webview_screen.dart';

class PoiDetailScreen extends StatelessWidget {
  final Poi poi;

  const PoiDetailScreen({Key? key, required this.poi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Получаем язык из контекста
    final languageCode = Localizations.localeOf(context).languageCode;
    final name = poi.getName(languageCode);
    final description = poi.getDescription(languageCode);

    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (poi.imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    poi.imageUrl!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              SizedBox(height: 16),
              Text(description, style: TextStyle(fontSize: 16, height: 1.5)),
              SizedBox(height: 16),
              if (poi.phone != null) ...[
                _buildContactRow(Icons.phone, poi.phone!, () => _launchUrl('tel:${poi.phone}', context)),
                SizedBox(height: 8),
              ],
              if (poi.website != null) ...[
                _buildContactRow(Icons.language, tr('website'), () => _launchUrl(poi.website!, context)),
                SizedBox(height: 8),
              ],
              if (poi.bookingUrl != null) ...[
                ElevatedButton(
                  onPressed: () => _launchUrl(poi.bookingUrl!, context),
                  child: Text(
                    poi.category == 'restaurants' ? tr('book_table') : tr('book_room'),
                  ),
                ),
                SizedBox(height: 16),
              ],
              ElevatedButton.icon(
                onPressed: () => _share(context, name),
                icon: Icon(Icons.share),
                label: Text(tr('share')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: onTap,
    );
  }

  Future<void> _launchUrl(String url, BuildContext context) async {
    if (url.startsWith('http')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => WebViewScreen(url: url, title: tr('web_page')),
        ),
      );
    } else {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(tr('cannot_open'))));
      }
    }
  }

  void _share(BuildContext context, String name) {
    // TODO: реализовать share через share_plus
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$name — ${tr('shared')}')));
  }
}