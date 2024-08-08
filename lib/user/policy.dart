import 'package:farmerapp/user/landing.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Define the Policy class
class Policy {
  final String name;
  final String policyName;
  final String policyDescription;

  Policy({
    required this.name,
    required this.policyName,
    required this.policyDescription,
  });

  // Factory method to create a Policy instance from JSON data
  factory Policy.fromJson(Map<String, dynamic> json) {
    return Policy(
      name: json['name'],
      policyName: json['policy_name'],
      policyDescription: json['policy_description'],
    );
  }
}

void main() {
  runApp(const PolicyApp());
}

class PolicyApp extends StatelessWidget {
  const PolicyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crop Policies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PolicyPage(),
    );
  }
}

// Dummy LandingPage class
class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Landing Page'),
        backgroundColor: Colors.amber,
      ),
      body: Center(child: const Text('Welcome to the Landing Page!')),
    );
  }
}

class PolicyPage extends StatefulWidget {
  const PolicyPage({Key? key}) : super(key: key);

  @override
  _PolicyPageState createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  late Future<List<Policy>> _policies;

  @override
  void initState() {
    super.initState();
    _policies = _fetchPolicies();
  }

  Future<List<Policy>> _fetchPolicies() async {
    final response =
        await http.get(Uri.parse('http://localhost/farmer/getpolicy.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Policy.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load policies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Policies'),
        backgroundColor: Colors.amber,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Landing(),
              ),
            );
          },
        ),
      ),
      body: FutureBuilder<List<Policy>>(
        future: _policies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No policies available'));
          }

          final policies = snapshot.data!;

          return ListView.builder(
            itemCount: policies.length,
            itemBuilder: (context, index) {
              final policy = policies[index];
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        policy.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Policy Name: ${policy.policyName}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Description: ${policy.policyDescription}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
