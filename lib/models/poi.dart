class Poi {
  final String id;
  final String nameRu;
  final String nameEn;
  final String descriptionRu;
  final String descriptionEn;
  final String category;
  final double lat;
  final double lng;
  final String? imageUrl;
  final String? phone;
  final String? website;
  final String? bookingUrl;
  final bool isPremium;

  // Конструктор без логики локализации
  Poi({
    required this.id,
    required this.nameRu,
    required this.nameEn,
    required this.descriptionRu,
    required this.descriptionEn,
    required this.category,
    required this.lat,
    required this.lng,
    this.imageUrl,
    this.phone,
    this.website,
    this.bookingUrl,
    this.isPremium = false,
  });

  // Метод для получения локализованного имени — вызывается из виджета
  String getName(String languageCode) {
    return languageCode == 'en' ? nameEn : nameRu;
  }

  // Метод для получения локализованного описания
  String getDescription(String languageCode) {
    return languageCode == 'en' ? descriptionEn : descriptionRu;
  }
}