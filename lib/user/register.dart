import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  Future<void> _register() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final fullName = _fullNameController.text;
    final email = _emailController.text;
    final phoneNumber = _phoneNumberController.text;

    final response = await http.post(
      Uri.parse(
          'http://localhost/farmer/register.php'), // Replace with your PHP script URL
      body: {
        'username': username,
        'password': password,
        'full_name': fullName,
        'email': email,
        'phone_number': phoneNumber,
      },
    );

    final responseData = json.decode(response.body);

    if (responseData['status'] == 'success') {
      // Handle success and navigate back to login page
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful')),
      );

      // Delay to allow the snackbar to be visible
      await Future.delayed(Duration(seconds: 1));
      Navigator.pop(context); // Navigate back to the login page
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Registration failed: ${responseData['message']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
