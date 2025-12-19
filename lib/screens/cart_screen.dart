import 'package:flutter/material.dart';
import 'package:madshop_ui_doronina/screens/favourites_screen.dart';
import 'package:madshop_ui_doronina/screens/product_screen.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int totalItems = 2;
  double totalPrice = 34.00; // Начальная цена

  void updateTotal(int change) {
    setState(() {
      totalItems += change;
      totalPrice += 17.00 * change; // 17.00 - цена одного товара
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text('Cart'),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                totalItems.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(18.0),
              children: [
                CartItem(
                  imageUrl: 'https://basket-03.wbbasket.ru/vol373/part37324/37324097/images/big/1.webp',
                  title: 'Lorem ipsum dolor sit amet consectetur.',
                  price: '\$17,00',
                  onQuantityChanged: updateTotal,
                ),
                SizedBox(height: 16),
                CartItem(
                  imageUrl: 'https://basket-16.wbbasket.ru/vol2543/part254342/254342534/images/hq/9.webp',
                  title: 'Lorem ipsum dolor sit amet consectetur.',
                  price: '\$17,00',
                  onQuantityChanged: updateTotal,
                  
                ),
              ],
            ),
          ),
          // Нижняя панель с итогом
          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
                children: [
                  // Текст слева
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('\$${totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                  SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                    child: const Text(
                      'Checkout',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavouritesScreen()),
                );
              },
              icon: Image.asset('assets/images/Frame.png', width: 24, height: 30),
            ),
            IconButton(
              onPressed: () {},
              icon: Image.asset('assets/images/Group 1954.png', width: 24, height: 30),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String price;
  final Function(int) onQuantityChanged;

  const CartItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.onQuantityChanged,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 1;

  void increment() {
    setState(() {
      quantity++;
    });
    widget.onQuantityChanged(1);
  }

  void decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
      widget.onQuantityChanged(-1);
    }
  }

  void removeItem() {
    widget.onQuantityChanged(-quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          // Картинка товара С Stack
          Stack(
            children: [
              Container(
                width: 100,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Иконка корзины - ТЕПЕРЬ В Stack
              Positioned(
                bottom: 6,  // снизу
                left: 6,    // слева
                child: IconButton(
                  onPressed: removeItem,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Image.asset('assets/images/Frame2.png', width: 35, height: 35),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),

                const SizedBox(height: 10),
                // Цена и счетчик на одном уровне
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.price,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    // Счетчик
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          // Минус
                          IconButton(
                            onPressed: decrement,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                            icon: Image.asset('assets/images/Less.png', width: 30, height: 30),
                          ),
                          // Количество
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              quantity.toString(),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          // Плюс
                          IconButton(
                            onPressed: increment,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                            icon: Image.asset('assets/images/More.png', width: 30, height: 30),
                          ),
                        ],
                      ),
                    ),
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