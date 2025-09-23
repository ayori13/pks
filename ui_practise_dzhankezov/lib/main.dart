import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PracticeScreen(),
    );
  }
}

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Практика 3"),
        backgroundColor: const Color.fromARGB(255, 243, 33, 33),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Привет, мир!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 227, 148, 0),
              ),
            ),

            const SizedBox(height: 20),


            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Кнопка нажата!")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 158, 238, 229),
              ),
              child: const Text("Нажми меня"),
            ),

            const SizedBox(height: 20),

            Container(
              width: 150,
              height: 100,
              color: const Color.fromARGB(255, 255, 68, 205), 
              child: const Center(
                child: Text(
                  "Контейнер",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(Icons.star, size: 40, color: Colors.orange),
                Icon(Icons.favorite, size: 40, color: Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
