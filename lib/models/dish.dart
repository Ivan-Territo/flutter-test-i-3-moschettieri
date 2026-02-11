class Dish {
  final int id;
  final String piatto;
  final String categoria;
  final double prezzo;
  final List<String> ingredienti;
  final bool isVegan;
  final bool disponibile;
  final String urlImmagine;

  Dish({
    required this.id,
    required this.piatto,
    required this.categoria,
    required this.prezzo,
    required this.ingredienti,
    required this.isVegan,
    required this.disponibile,
    required this.urlImmagine,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: int.tryParse(json['id'].toString()) ?? 0,
      piatto: json['piatto'] ?? '',
      categoria: json['categoria'] ?? '',
      prezzo: double.tryParse(json['prezzo'].toString()) ?? 0.0,
      ingredienti: List<String>.from(json['ingredienti'] ?? []),
      isVegan: json['is_vegan'] ?? false,
      disponibile: json['disponibile'] ?? true,
      urlImmagine: json['url_immagine'] ?? '',
    );
  }
}
