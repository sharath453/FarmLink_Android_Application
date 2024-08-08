import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddPolicy extends StatefulWidget {
  const AddPolicy({super.key});

  @override
  State<AddPolicy> createState() => _AddPolicyState();
}

class _AddPolicyState extends State<AddPolicy> {
  final _formKey = GlobalKey<FormState>();
  final _cropNameController = TextEditingController();
  final _policyNameController = TextEditingController();
  final _policyDescriptionController = TextEditingController();

  @override
  void dispose() {
    _cropNameController.dispose();
    _policyNameController.dispose();
    _policyDescriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final cropName = _cropNameController.text;
      final policyName = _policyNameController.text;
      final policyDescription = _policyDescriptionController.text;

      try {
        final response = await http.post(
          Uri.parse(
              'http://localhost/farmer/addpolicy.php'), // Replace with your server URL
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'crop_name': cropName,
            'policy_name': policyName,
            'policy_description': policyDescription,
          }),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data['status'] == 'success') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Policy added successfully')),
            );
            _formKey.currentState?.reset();
            _cropNameController.clear();
            _policyNameController.clear();
            _policyDescriptionController.clear();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(data['message'])),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Failed to add policy. Server returned: ${response.statusCode}')),
          );
        }
      } catch (e) {
        print('Error occurred: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to add policy. Please check your internet connection and try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Add Policy'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _cropNameController,
                decoration: const InputDecoration(
                  labelText: 'Crop Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the crop name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _policyNameController,
                decoration: const InputDecoration(
                  labelText: 'Policy Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the policy name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _policyDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Policy Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the policy description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Add Policy'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
