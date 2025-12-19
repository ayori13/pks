import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'notes_page.dart';

final supabase = Supabase.instance.client;

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
    String? _errorMessage;


  // Функция для входа
  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await supabase.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // После успешного входа автоматически перейдем на NotesPage
    } catch (error) {
      // Показываем ошибку через SnackBar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка входа: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Функция для регистрации
Future<void> _signUp() async {
  setState(() {
    _isLoading = true;
    _errorMessage = null;
  });

  try {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    
    print('Пытаемся зарегистрировать: $email');
    
    final AuthResponse response = await supabase.auth.signUp(
      email: email,
      password: password,
    );
    
    print('Успешно! User ID: ${response.user?.id}');
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Регистрация успешна! Теперь войдите.'),
          backgroundColor: Colors.green,
        ),
      );
    }
  } catch (error) {
    print('Полная ошибка: $error');
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка регистрации: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        // Если пользователь вошел, показываем страницу заметок
        if (supabase.auth.currentUser != null) {
          return const NotesPage();
        }

        // Если не вошел, показываем форму входа
        return Scaffold(
          appBar: AppBar(
            title: const Text('Вход в приложение'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Поле для email
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Поле для пароля
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Пароль',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true, // Скрываем пароль
                ),
                
                const SizedBox(height: 20),
                
                // Кнопка входа
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  Column(
                    children: [
                      // Кнопка входа
                      FilledButton(
                        onPressed: _signIn,
                        child: const Text('Войти'),
                      ),
                      
                      const SizedBox(height: 10),
                      
                      // Кнопка регистрации
                      OutlinedButton(
                        onPressed: _signUp,
                        child: const Text('Зарегистрироваться'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}