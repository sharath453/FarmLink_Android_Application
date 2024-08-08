import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:farmerapp/manager/addcrop.dart';
import 'package:farmerapp/manager/addpolicy.dart';
import 'package:farmerapp/user/login.dart'; // Import your LoginPage or equivalent

class AdminLandingPage extends StatelessWidget {
  const AdminLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for carousel items (URLs)
    final List<String> carouselItems = [
      'https://tse4.mm.bing.net/th?id=OIP.leUcEChYZIbEsnNYuhNvmAHaE8&pid=Api&P=0&h=180', // Replace with your actual image URLs
      'https://tse3.mm.bing.net/th?id=OIP.wIGLk6nxRtCqyj3nrM9nUgHaE6&pid=Api&P=0&h=180',
      'https://tse4.mm.bing.net/th?id=OIP.leUcEChYZIbEsnNYuhNvmAHaE8&pid=Api&P=0&h=180',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Admin'),
        automaticallyImplyLeading: false, // Remove the back button
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout), // Use the logout icon
            onPressed: () {
              // Add your logout functionality here
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LoginPage(), // Navigate to login page or another page
                ),
              );
            },
          ),
          const SizedBox(
              width:
                  16), // Add some spacing between the icon and edge of AppBar
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction:
                    1.0, // Set to 1.0 to make the carousel full width
              ),
              items: carouselItems.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(item), // Load image from network
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddCrop(),
                            ),
                          );
                        },
                        child: const Text(
                          'Add Crops',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddPolicy(),
                            ),
                          );
                        },
                        child: const Text(
                          'Add Policies',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
