import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitpall/app/services/api_service.dart';
import 'profile_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> handleLogin() async {
    setState(() => isLoading = true);

    try {
      final token = await ApiService.login(
        emailController.text,
        passwordController.text,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : handleLogin,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
