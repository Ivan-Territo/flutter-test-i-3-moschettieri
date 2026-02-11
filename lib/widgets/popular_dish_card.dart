import 'package:flutter/material.dart';
import '../models/dish.dart';

class PopularDishCard extends StatelessWidget {
  final Dish dish;

  const PopularDishCard({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey.withValues(alpha: .08), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          // Immagine
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              dish.urlImmagine, // Campo aggiornato
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => 
                  Container(width: 80, height: 80, color: Colors.grey[200], child: Icon(Icons.error)),
            ),
          ),
          const SizedBox(width: 15),
          
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        dish.piatto, // Campo aggiornato
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Se è Vegano, mostra icona foglia
                    if (dish.isVegan)
                      const Icon(Icons.eco, color: Colors.green, size: 18),
                  ],
                ),
                
                const SizedBox(height: 5),
                
                // Lista ingredienti come descrizione
                Text(
                  dish.ingredienti.join(", "), // Unisce la lista in una stringa
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 8),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "€ ${dish.prezzo.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    // Icona "Add"
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: Colors.green[50], shape: BoxShape.circle),
                      child: const Icon(Icons.add, color: Colors.green, size: 20),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}