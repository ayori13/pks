import 'package:flutter/material.dart';
import 'package:madshop_ui_doronina/screens/product_screen.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight, 
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 1, 
              child: Image.asset(
                'assets/images/Bubbles2.png',
                fit: BoxFit.fitWidth, 
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 270),

                // Заголовок "Hello!"
                const Text(
                  'Hello!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 40),

                // Подзаголовок "Type your password"
                const Text(
                  'Type your password',
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 130),

                // Поле Password (с иконкой глаза)
                TextField(
                  obscureText: true, // Скрываем текст
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset(
                        'assets/images/eye-slash.png', // Ваша иконка глаза
                        width: 16,
                        height: 16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 70),

                // Кнопка "Start"
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E88E5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 165),
                  ),
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Ссылка "Cancel"
                Center(
                  child: TextButton(
                    onPressed: () {
                      print('Нажата ссылка Cancel');
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
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
}