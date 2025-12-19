import 'package:flutter/material.dart';
import 'package:madshop_ui_doronina/screens/login_screen.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight, 
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 1, 
              child: Image.asset(
                'assets/images/Bubbles.png',
                fit: BoxFit.fitWidth, 
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 150),
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 150),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Email', 
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60),
                      borderSide: BorderSide.none,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right:10),
                        child: Image.asset(
                          'assets/images/eye-slash.png',
                          width: 16,
                          height: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Your number',
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left:10),
                        child: Image.asset(
                          'assets/images/Flag.png',
                          width: 24,
                          height: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40), 
                  ElevatedButton(
                    onPressed:() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E88E5), // Синий цвет кнопки
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Круглые углы
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 160),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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