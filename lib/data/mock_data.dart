import '../models/dish.dart';

// Questa è la lista fissa che useremo per la parte alta della pagina
final List<Dish> specialDishes = [
  Dish(
    id: 101,
    piatto: "Insalata Verde",
    categoria: "Insalate",
    prezzo: 12.0,
    ingredienti: ["Lattuga", "Rucola", "Olio EVO"],
    isVegan: true,
    disponibile: true,
    urlImmagine: "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400", 
  ),
  Dish(
    id: 102,
    piatto: "Pasta al Pesto",
    categoria: "Primi",
    prezzo: 15.50,
    ingredienti: ["Basilico", "Pinoli", "Parmigiano"],
    isVegan: false,
    disponibile: true,
    urlImmagine: "https://images.unsplash.com/photo-1473093295043-cdd812d0e601?w=400",
  ),
  Dish(
    id: 103,
    piatto: "Bowl di Quinoa",
    categoria: "Unico",
    prezzo: 14.0,
    ingredienti: ["Quinoa", "Avocado", "Pomodorini"],
    isVegan: true,
    disponibile: true,
    urlImmagine: "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400",
  ),
];