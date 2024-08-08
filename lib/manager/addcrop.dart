import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddCrop extends StatefulWidget {
  const AddCrop({super.key});

  @override
  State<AddCrop> createState() => _AddCropState();
}

class _AddCropState extends State<AddCrop> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _soilTypeController = TextEditingController();
  final _climateConditionController = TextEditingController();
  final _startSeasonController = TextEditingController();
  final _endSeasonController = TextEditingController();
  final _policyNameController = TextEditingController();
  final _policyDescriptionController = TextEditingController();
  final _pricePerKgController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _soilTypeController.dispose();
    _climateConditionController.dispose();
    _startSeasonController.dispose();
    _endSeasonController.dispose();
    _policyNameController.dispose();
    _policyDescriptionController.dispose();
    _pricePerKgController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final response = await http.post(
          Uri.parse(
              'http://localhost/farmer/addcrop.php'), // Replace with your server URL
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'crop_name': _nameController.text,
            'soil_type': _soilTypeController.text,
            'climate_condition': _climateConditionController.text,
            'season_start': _startSeasonController.text,
            'season_end': _endSeasonController.text,
            'government_policy': _policyNameController.text,
            'description': _policyDescriptionController.text,
            'price_per_kg': _pricePerKgController.text,
          }),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data['status'] == 'success') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Crop added successfully')),
            );
            _formKey.currentState?.reset();
            // Optionally, clear text controllers
            _nameController.clear();
            _soilTypeController.clear();
            _climateConditionController.clear();
            _startSeasonController.clear();
            _endSeasonController.clear();
            _policyNameController.clear();
            _policyDescriptionController.clear();
            _pricePerKgController.clear();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(data['message'])),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Failed to add crop. Server returned an error: ${response.statusCode}')),
          );
        }
      } catch (e) {
        print('Error occurred: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to add crop. Please check your internet connection and try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Add Crop'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
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
                controller: _soilTypeController,
                decoration: const InputDecoration(
                  labelText: 'Soil Type',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the soil type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _climateConditionController,
                decoration: const InputDecoration(
                  labelText: 'Climate Condition',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the climate condition';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _startSeasonController,
                decoration: const InputDecoration(
                  labelText: 'Start Season',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the start season';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _endSeasonController,
                decoration: const InputDecoration(
                  labelText: 'End Season',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the end season';
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
                controller: _pricePerKgController,
                decoration: const InputDecoration(
                  labelText: 'Price per kg',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price per kg';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Add Crop'),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
