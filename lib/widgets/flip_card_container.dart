import 'package:flutter/material.dart';
import 'dart:math';

class FlipLoginSignup extends StatefulWidget {
  const FlipLoginSignup({super.key});

  @override
  State<FlipLoginSignup> createState() => _FlipLoginSignupState();
}

class _FlipLoginSignupState extends State<FlipLoginSignup> {
  bool showLogin = true;

  void toggleView() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 1000),
          transitionBuilder: (child, animation) {
            final rotate = Tween(begin: pi, end: 0.0).animate(animation);
            return AnimatedBuilder(
              animation: rotate,
              child: child,
              builder: (context, child) {
                final isUnder = (child?.key as ValueKey<bool>).value != showLogin;

                var tilt = (animation.value - 0.5).abs() - 0.5;
                tilt *= isUnder ? -0.004 : 0.004;
                final value = isUnder ? min(rotate.value, pi / 2) : rotate.value;

                return Transform(
                  transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
                  alignment: Alignment.center,
                  child: child,
                );
              },
            );
          },
          layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
          switchInCurve: Curves.easeInOutBack,
          switchOutCurve: Curves.easeInOutBack,
          child: showLogin
              ? LoginView(key: const ValueKey(true), toggle: toggleView)
              : SignupView(key: const ValueKey(false), toggle: toggleView),
        ),
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  final VoidCallback toggle;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginView({super.key, required this.toggle});

  bool get isButtonEnabled =>
      emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Login', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress, // Using built-in TextField
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isButtonEnabled
                  ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logging in...')),
                );
              }
                  : null,
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: toggle,
              child: const Text('Need an account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}

class SignupView extends StatelessWidget {
  final VoidCallback toggle;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignupView({super.key, required this.toggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Sign Up', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress, // Using built-in TextField
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                debugPrint('Name: ${nameController.text}');
                debugPrint('Email: ${emailController.text}');
                debugPrint('Password: ${passwordController.text}');
              },
              child: const Text('Create Account'),
            ),
            TextButton(
              onPressed: toggle,
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}