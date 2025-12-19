import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_gate.dart';

const supabaseUrl = 'https://qkulzwvtzmqovteqyyee.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFrdWx6d3Z0em1xb3Z0ZXF5eWVlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE2MTEwOTksImV4cCI6MjA3NzE4NzA5OX0.gedzHOgbqHHI2aNYAHcEJhMSaUL4fUUyt14eiY26l8o';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  runApp(const NotesApp());
}


class NotesApp extends StatelessWidget {
  const NotesApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Notes',
      theme: ThemeData(useMaterial3: true),
      home: const AuthGate(),
    );
  }
}

