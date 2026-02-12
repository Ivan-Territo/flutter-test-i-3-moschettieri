import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/dish.dart';
import '../widgets/special_dish_card.dart'; 
import '../widgets/popular_dish_card.dart'; 
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  late Future<List<Dish>> _menuFuture;

  @override
  void initState() {
    super.initState();
    _menuFuture = _apiService.getMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 20,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF5BA453),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.eco, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            const Text(
              "Vegety",
              style: TextStyle(
                color: Color(0xFF2E3B28), 
                fontWeight: FontWeight.w800, 
                fontSize: 22
              )
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87, size: 24),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black87, size: 24),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black87, size: 24),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5BA453),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                elevation: 0,
              ),
              child: const Text(
                "Booking Now",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14
                ),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Healthy food to\nlive a healthier life\nin the future",
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, height: 1.2, color: Color(0xFF2E3B28))),
                        const SizedBox(height: 15),
                        Text("Enjoy a healthy life by eating healthy foods that have extraordinary flavors.",
                            style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E3B28),
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text("Get Started", style: TextStyle(color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                  const Expanded(
                    flex: 6,
                    child: CircleAvatar(
                      radius: 110,
                      backgroundColor: Colors.transparent,
                      // Immagine Hero (statica)
                      backgroundImage: NetworkImage("https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600"),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 40),

            const Center(child: Text("Our Special Dish", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF2E3B28)))),
            const SizedBox(height: 5),
            const Center(child: Text("Made with premium ingredients", style: TextStyle(color: Colors.grey, fontSize: 13))),
            const SizedBox(height: 30),

            FutureBuilder<List<Dish>>(
              future: _menuFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text("Nessun piatto disponibile");
                }

                final allDishes = snapshot.data!;
                final specialList = allDishes.take(3).toList();
                final popularList = allDishes.skip(3).take(3).toList();

                return Column(
                  children: [
                    Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, // CENTRATURA
                            children: specialList.map((dish) {
                              return SpecialDishCard(dish: dish);
                            }).toList(),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Image.network("https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400", height: 250),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Fresh Vegetables\nEvery Day", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 15),
                                Text("We present fresh vegetables taken directly from the farmer's garden.", style: TextStyle(color: Colors.grey[600])),
                                const SizedBox(height: 20),
                                OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    side: const BorderSide(color: Colors.black),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  ),
                                  child: const Text("Learn More"),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 60),
                    const Center(child: Text("Our Popular Menu", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF2E3B28)))),
                    const SizedBox(height: 5),
                    const Center(child: Text("Made with premium ingredients", style: TextStyle(color: Colors.grey, fontSize: 13))),
                    const SizedBox(height: 30),

                    Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, // CENTRATURA
                            children: popularList.map((dish) {
                              return PopularDishCard(dish: dish);
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 30),

            Center(
              child: ElevatedButton.icon(
                onPressed: (){}, 
                icon: const Icon(Icons.arrow_right, color: Colors.white),
                label: const Text("Load more menu", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
              )
            ),

            const SizedBox(height: 60),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Cooked by the\nBest Chefs in the\nWorld", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        _buildCheck("A guaranteed delicious meal"),
                        _buildCheck("Food is guaranteed hygienic"),
                        _buildCheck("Cooked quickly"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Image.network("https://images.unsplash.com/photo-1583394293214-28ded15ee548?w=400", height: 250),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
                image: const DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1466637574441-749b8f19452f?w=400"), fit: BoxFit.cover, opacity: 0.3),
              ),
              child: Column(
                children: [
                  const Text("Join our member and\nget discount up to 50%", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
                    child: Row(
                      children: [
                        const SizedBox(width: 15),
                        const Expanded(child: TextField(decoration: InputDecoration(hintText: "Enter your email", border: InputBorder.none))),
                        ElevatedButton(
                          onPressed: (){}, 
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF5BA453), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12)),
                          child: const Text("Sign In", style: TextStyle(color: Colors.white)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 50),
            const Center(child: Text("© 2026 Vegety. All rights reserved.", style: TextStyle(color: Colors.grey, fontSize: 12))),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCheck(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF5BA453), size: 18),
          const SizedBox(width: 10),
          Text(text, style: TextStyle(color: Colors.grey[600]))
        ],
      ),
    );
  }
}