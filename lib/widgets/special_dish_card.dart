import 'package:flutter/material.dart';
import '../models/dish.dart';

class SpecialDishCard extends StatelessWidget {
  final Dish dish;

  const SpecialDishCard({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // IMMAGINE ROTONDA
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipOval(
              child: Image.network(
                dish.urlImmagine,
                fit: BoxFit.cover,
                // RIMOSSO GLI HEADERS CHE CAUSAVANO L'ERRORE SU WEB
                errorBuilder: (context, error, stackTrace) {
                  // Se l'immagine originale è bloccata dal CORS, carica questa:
                  return Image.network(
                    "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=200",
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 15),

          // NOME PIATTO
          Text(
            dish.piatto,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 5),

          // CATEGORIA
          Text(
            dish.categoria,
            style: TextStyle(color: Colors.grey[400], fontSize: 12),
          ),

          const SizedBox(height: 10),

          // PREZZO
          Text(
            "€ ${dish.prezzo.toStringAsFixed(2)}",
            style: const TextStyle(
              color: Color(0xFF5BA453),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
