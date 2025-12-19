import 'package:flutter/material.dart';
import 'package:madshop_ui_doronina/screens/favourites_screen.dart';
import 'package:madshop_ui_doronina/screens/cart_screen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> productImages = [
      'https://basket-03.wbbasket.ru/vol373/part37324/37324097/images/big/1.webp',
      'https://basket-16.wbbasket.ru/vol2543/part254342/254342534/images/hq/9.webp',
      'https://basket-05.wbbasket.ru/vol924/part92436/92436270/images/big/8.webp',
      'https://basket-03.wbbasket.ru/vol395/part39565/39565985/images/hq/1.webp',
      'https://basket-17.wbbasket.ru/vol2817/part281717/281717581/images/big/7.webp',
      'https://basket-26.wbbasket.ru/vol4771/part477147/477147401/images/big/1.webp',
      'https://basket-14.wbbasket.ru/vol2096/part209687/209687380/images/big/4.webp',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Shop'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Container(
              width: 290,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 9),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Clothing',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: GridView.builder(
          itemCount: productImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12, // Уменьшил с 70 до 12
            childAspectRatio: 0.65, // Добавил соотношение сторон
          ),
          itemBuilder: (context, index) {
            return ProductCard(
              imageUrl: productImages[index],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: Image.asset('assets/images/Component 1.png', width: 24, height: 30),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavouritesScreen()),
                );
              },
              icon: Image.asset('assets/images/Frame.png', width: 24, height: 30),
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

class ProductCard extends StatefulWidget {
  final String imageUrl;
  const ProductCard({super.key, required this.imageUrl});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;
  bool isInCart = false;

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
              SizedBox(
                height: 185, 
                width: double.infinity,
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Text('Ошибка загрузки'));
                  },
                ),
              ),
              Positioned(
                top: 4, // Уменьшил отступ
                left: 4,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Image.asset(
                    isFavorite ? 'assets/images/Frame1.png' : 'assets/images/wishlist.png',
                    width: 24, // Уменьшил размер
                    height: 30,
                  ),
                ),
              ),
              Positioned(
                bottom: 4, // Уменьшил отступ
                left: 4,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isInCart = !isInCart;
                    });
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Image.asset(
                    isInCart ? 'assets/images/Cart1.png' : 'assets/images/cart2.png',
                    width: 22, // Уменьшил размер
                    height: 22,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8), // Уменьшил отступы
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lorem ipsum dolor sit amet consectetur',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12), // Уменьшил шрифт
                ),
                const SizedBox(height: 4), // Уменьшил отступ
                const Text(
                  '\$17,00',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold), // Уменьшил шрифт
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}