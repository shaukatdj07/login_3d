import 'package:flutter/material.dart';
import 'dart:math'; // Add this import for pi constant
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showLoginForm = false;

  bool get isButtonEnabled =>
      emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xFF1A2980), Color(0xFF26D0CE)],
            center: Alignment(0, -0.3),
            radius: 1.2,
          ),
        ),
        child: Center(
          child: MouseRegion(
            onEnter: (_) => setState(() => showLoginForm = true),
            onExit: (_) => setState(() => showLoginForm = false),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              transitionBuilder: (child, animation) {
                final rotate = Tween(begin: pi, end: 0.0).animate(animation);
                return AnimatedBuilder(
                  animation: rotate,
                  child: child,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.rotationY(rotate.value),
                      alignment: Alignment.center,
                      child: child,
                    );
                  },
                );
              },
              child: showLoginForm ? _buildLoginForm() : _buildClosedBox(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClosedBox() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.indigo, Colors.deepPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.blueAccent,
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Center(
        child: Icon(Icons.lock_outline, size: 80, color: Colors.white),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(color: Colors.black45, blurRadius: 20, spreadRadius: 2),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.cyanAccent, Colors.lightBlueAccent],
            ).createShader(bounds),
            child: const Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildTextField(emailController, 'Email'),
          const SizedBox(height: 16),
          _buildTextField(passwordController, 'Password', isPassword: true),
          const SizedBox(height: 24),
          _buildLoginButton(),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignupScreen()),
              );
            },
            child: const Text(
              "Need an account? Sign up",
              style: TextStyle(
                fontSize: 13,
                color: Colors.white70,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      onChanged: (_) => setState(() {}),
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.cyanAccent),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.cyan),
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.cyanAccent, width: 2),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return GestureDetector(
      onTap: isButtonEnabled
          ? () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logging in...')),
        );
      }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 50,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isButtonEnabled ? Colors.cyan : Colors.grey[800],
          borderRadius: BorderRadius.circular(12),
          boxShadow: isButtonEnabled
              ? [
            BoxShadow(
              color: Colors.cyanAccent.withOpacity(0.8),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ]
              : [],
        ),
        child: Text(
          'Login',
          style: TextStyle(
            fontSize: 18,
            color: isButtonEnabled ? Colors.black : Colors.grey,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            shadows: isButtonEnabled
                ? const [
              Shadow(blurRadius: 18, color: Colors.white),
            ]
                : [],
          ),
        ),
      ),
    );
  }
}