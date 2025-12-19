import 'package:flutter/material.dart';
import 'package:madshop_ui_doronina/screens/cart_screen.dart';
import 'package:madshop_ui_doronina/screens/product_screen.dart';
class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> favouriteImages = [
      'https://basket-03.wbbasket.ru/vol373/part37324/37324097/images/big/1.webp',
      'https://basket-16.wbbasket.ru/vol2543/part254342/254342534/images/hq/9.webp',
      'https://basket-05.wbbasket.ru/vol924/part92436/92436270/images/big/8.webp',
      'https://basket-03.wbbasket.ru/vol395/part39565/39565985/images/hq/1.webp',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Favourites'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: GridView.builder(
          itemCount: favouriteImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            return FavouriteCard(
              imageUrl: favouriteImages[index],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductScreen()),
                );
              },
              icon: Image.asset('assets/images/Shop.png', width: 24, height: 30),
            ),
            IconButton(
              onPressed: () {},
              icon: Image.asset('assets/images/Vector.png', width: 24, height: 30),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
              icon: Image.asset('assets/images/Cart.png', width: 24, height: 30),
            ),
          ],
        ),
      ),
    );
  }
}

class FavouriteCard extends StatelessWidget {
  final String imageUrl;
  const FavouriteCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 185,
                width: double.infinity,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Text('Ошибка'));
                  },
                ),
              ),
              Positioned(
                top: 6,
                left: 6,
                child: IconButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Image.asset(
                    'assets/images/Frame1.png', // Красное сердечко
                    width: 22,
                    height: 22,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Lorem ipsum dolor sit amet consectetur',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const Text(
                    '\$17,00',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}