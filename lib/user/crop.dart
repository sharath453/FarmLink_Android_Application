import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Define the CropDetail class
class CropDetail {
  final String name;
  final String soilType;
  final String climateCondition;
  final String startSeason;
  final String endSeason;
  final String policyName;
  final String policyDescription;
  final double pricePerKg;

  CropDetail({
    required this.name,
    required this.soilType,
    required this.climateCondition,
    required this.startSeason,
    required this.endSeason,
    required this.policyName,
    required this.policyDescription,
    required this.pricePerKg,
  });

  // Factory method to create a CropDetail instance from JSON data
  factory CropDetail.fromJson(Map<String, dynamic> json) {
    return CropDetail(
      name: json['name'] as String,
      soilType: json['soilType'] as String,
      climateCondition: json['climateCondition'] as String,
      startSeason: json['startSeason'] as String,
      endSeason: json['endSeason'] as String,
      policyName: json['policyName'] as String,
      policyDescription: json['policyDescription'] as String,
      pricePerKg: double.tryParse(json['pricePerKg'].toString()) ?? 0.0,
    );
  }
}

// Define the Crop widget
class Crop extends StatefulWidget {
  const Crop({Key? key}) : super(key: key);

  @override
  _CropDetailsState createState() => _CropDetailsState();
}

class _CropDetailsState extends State<Crop> {
  // Future to hold the crop details
  late Future<List<CropDetail>> _cropDetails;

  @override
  void initState() {
    super.initState();
    _cropDetails = _fetchCropDetails();
  }

  // Method to fetch crop details from the PHP backend
  Future<List<CropDetail>> _fetchCropDetails() async {
    final response =
        await http.get(Uri.parse('http://localhost/farmer/getcrop.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => CropDetail.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load crop details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Details'),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<List<CropDetail>>(
        future: _cropDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          }

          final cropDetails = snapshot.data!;

          return ListView.builder(
            itemCount: cropDetails.length,
            itemBuilder: (context, index) {
              final cropDetail = cropDetails[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cropDetail.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Soil Type: ${cropDetail.soilType}'),
                      Text('Climate Condition: ${cropDetail.climateCondition}'),
                      Text('Start Season: ${cropDetail.startSeason}'),
                      Text('End Season: ${cropDetail.endSeason}'),
                      Text(
                          'Price per kg: \$${cropDetail.pricePerKg.toStringAsFixed(2)}'),
                      SizedBox(height: 10),
                      Text(
                        'Government Policy',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text('Policy Name: ${cropDetail.policyName}'),
                      Text('Description: ${cropDetail.policyDescription}'),
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
