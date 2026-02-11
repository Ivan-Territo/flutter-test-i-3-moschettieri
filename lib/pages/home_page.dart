import 'package:flutter/material.dart';
// Importa i tuoi file
import '../services/api_service.dart';
// NOTA: Se la classe dentro questo file si chiama 'Piatto', usa 'Piatto' invece di 'Dish' nel codice sotto
import '../models/dish.dart';
import '../widgets/special_dish_card.dart';
// import '../widgets/popular_dish_card.dart'; // Se hai una card specifica per il menu popolare, scommentalo

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 1. Istanziamo il servizio per scaricare i dati
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),

      // --- APP BAR ---
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.eco, color: Color(0xFF5BA453)),
            SizedBox(width: 8),
            Text(
              "Vegety",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),

      // --- CORPO ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(),
            const SizedBox(height: 40),

            // 2. Special Dish (ORA CON API)
            _buildSpecialDishHeader(),
            _buildSpecialDishList(), // <--- Modificato
            const SizedBox(height: 50),

            _buildFreshVegetablesSection(),
            const SizedBox(height: 50),

            // 4. Popular Menu (ORA CON API)
            _buildPopularMenuHeader(),
            _buildPopularMenuApi(), // <--- Modificato
            const SizedBox(height: 50),

            _buildBestChefsSection(),
            const SizedBox(height: 50),

            _buildNewsletterBanner(),
            const SizedBox(height: 40),

            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // ==========================================
  //      WIDGET HELPER
  // ==========================================

  Widget _buildHeroSection() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Healthy food\nto live better",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enjoy a healthy life by eating healthy foods.",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E3B28),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Get Started",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        const Expanded(
          flex: 2,
          child: CircleAvatar(
            radius: 65,
            backgroundColor: Color(0xFFE8F5E9),
            backgroundImage: NetworkImage(
              "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400",
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialDishHeader() {
    return Column(
      children: [
        const Center(
          child: Text(
            "Our Special Dish",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 5),
        Center(
          child: Text(
            "Made with premium ingredients",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ),
      ],
    );
  }

  // --- MODIFICATO: Usa l'API ---
  Widget _buildSpecialDishList() {
    return FutureBuilder<List<Dish>>(
      // Assicurati che 'Dish' sia il nome della classe nel file dish.dart
      future: _apiService.getMenu(),
      builder: (context, snapshot) {
        // 1. Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 260,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        // 2. Error
        if (snapshot.hasError) {
          return const SizedBox(
            height: 260,
            child: Center(child: Text("Errore caricamento dati")),
          );
        }

        // 3. Empty
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox(
            height: 260,
            child: Center(child: Text("Nessun piatto speciale.")),
          );
        }

        // 4. Data OK
        final allDishes = snapshot.data!;
        // Prendiamo ad esempio solo i primi 5 piatti per questa sezione
        final specialDishes = allDishes.take(5).toList();

        return SizedBox(
          height: 260,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
            itemCount: specialDishes.length,
            itemBuilder: (context, index) {
              return SpecialDishCard(dish: specialDishes[index]);
            },
          ),
        );
      },
    );
  }

  Widget _buildFreshVegetablesSection() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Image.network(
            "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400",
            height: 200,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stack) =>
                const Icon(Icons.eco, size: 80, color: Colors.green),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Fresh Vegetables\nEvery Day",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "We present various types of fresh vegetables taken directly from the farmer's garden.",
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E3B28),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Learn More",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPopularMenuHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Our Popular Menu",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        const Text(
          "Best selling dishes selected by you",
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
      ],
    );
  }

  // --- MODIFICATO: Usa l'API ---
  Widget _buildPopularMenuApi() {
    // Nota: shrinkWrap: true e physics: NeverScrollableScrollPhysics() sono importanti
    // perché questo ListView è dentro un Column che è dentro un SingleChildScrollView

    return FutureBuilder<List<Dish>>(
      future: _apiService.getMenu(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Text("Errore nel caricamento del menu");
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text("Menu vuoto");
        }

        final menu = snapshot.data!;

        return ListView.separated(
          shrinkWrap: true, // Importante per non rompere lo scroll della pagina
          physics:
              const NeverScrollableScrollPhysics(), // Disabilita lo scroll interno
          itemCount: menu.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final piatto = menu[index];

            // Qui puoi usare PopularDishCard se l'hai creata, oppure un container custom
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Immagine
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      piatto.urlImmagine,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      headers: const {
                        'User-Agent':
                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
                      },
                      errorBuilder: (ctx, err, stack) => Container(
                        width: 70,
                        height: 70,
                        color: Colors.grey[200],
                        child: const Icon(Icons.fastfood),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  // Testi
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          piatto
                              .piatto, // Assicurati che nel modello si chiami 'nome'
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          piatto.categoria,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Prezzo
                  Text(
                    "€${piatto.prezzo}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5BA453),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBestChefsSection() {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Cooked by the\nBest Chefs",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 15),
              _buildCheckItem("A guaranteed delicious meal"),
              _buildCheckItem("Food is guaranteed hygienic"),
              _buildCheckItem("Cooked quickly"),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Image.network(
            "https://images.unsplash.com/photo-1583394293214-28ded15ee548?w=400",
            height: 250,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stack) =>
                const Icon(Icons.person, size: 100, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF5BA453), size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.grey[700], fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsletterBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFF2E3B28),
        borderRadius: BorderRadius.circular(30),
        image: const DecorationImage(
          image: NetworkImage(
            "https://images.unsplash.com/photo-1466637574441-749b8f19452f?w=400",
          ),
          fit: BoxFit.cover,
          opacity: 0.1,
        ),
      ),
      child: Column(
        children: [
          const Text(
            "Join our member and\nget discount up to 50%",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        hintStyle: TextStyle(fontSize: 13),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5BA453),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        const Divider(color: Colors.grey),
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.eco, color: Color(0xFF5BA453)),
                SizedBox(width: 5),
                Text(
                  "Vegety",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.facebook, color: Colors.grey, size: 20),
                SizedBox(width: 15),
                Icon(Icons.camera_alt, color: Colors.grey, size: 20),
                SizedBox(width: 15),
                Icon(Icons.email, color: Colors.grey, size: 20),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          "© 2026 Vegety Restaurant. All rights reserved.",
          style: TextStyle(color: Colors.grey[400], fontSize: 11),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
