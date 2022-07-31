import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_drive/container_page.dart';
import 'dart:math';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool isValidForm = false;
  bool isLoading = false;

  final pattern = r'(?=.*?[A-Z])(?=.*?[0-9])';

  setRandomLoginID() async {
    int max = 6;
    int randomID = Random().nextInt(max) + 1;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('userLoginId', randomID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: loginForm(),
      ),
    );
  }

  Widget loginForm() => Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _formKey.currentState!.validate()
                    ? setState(() => isValidForm = true)
                    : setState(() => isValidForm = false),
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null),
            const SizedBox(height: 16),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _formKey.currentState!.validate()
                  ? setState(() => isValidForm = true)
                  : setState(() => isValidForm = false),
              validator: (value) {
                // final bool isValid = EmailValidator.validate(value);
                if ((value != null && value.length < 7)) {
                  return 'more than 6 char';
                } else if (value != null && !value.contains(RegExp(pattern))) {
                  return 'contain number and uppercase';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(60),
              ),
              onPressed: isValidForm
                  ? () {
                      setState(() => isLoading = true);
                      setRandomLoginID();
                      Future.delayed(
                        const Duration(seconds: 3),
                        () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const ContainerPage(),
                              ),
                              (route) => false);
                        },
                      );
                    }
                  : null,
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text('Sign In'),
            )
          ],
        ),
      );
}
