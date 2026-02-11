import 'package:flutter/material.dart';
import '../models/dish.dart';

class SpecialDishCard extends StatelessWidget {
  final Dish dish;

  const SpecialDishCard({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // IMMAGINE
          CircleAvatar(
            radius: 45,
            backgroundImage: NetworkImage(dish.urlImmagine), // Campo aggiornato
            backgroundColor: Colors.green[50],
          ),
          const SizedBox(height: 12),
          
          // TITOLO (Nome Piatto)
          Text(
            dish.piatto, // Campo aggiornato
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: 4),
          
          // SOTTOTITOLO (Categoria)
          Text(
            dish.categoria, // Campo aggiornato
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 8),
          
          // PREZZO
          Text(
            "€ ${dish.prezzo.toStringAsFixed(2)}", // Campo aggiornato
            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF5BA453)),
          ),
        ],
      ),
    );
  }
}