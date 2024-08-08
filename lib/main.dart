import 'package:farmerapp/user/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: true, // This enables the debug banner
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          SplashPage(
            imageUrl:
                'https://tse2.mm.bing.net/th?id=OIP.46miTyhvCD0V6v9ImcZShwHaFj&pid=Api&P=0&h=180',
            text: 'Welcome to the App!',
            backgroundColor: Colors.blueAccent,
          ),
          SplashPage(
            imageUrl:
                'https://tse2.mm.bing.net/th?id=OIP.wmvGziTFxkPO0x_-LG7I0AHaE7&pid=Api&P=0&h=180',
            text: 'Discover Features',
            backgroundColor: Colors.greenAccent,
          ),
          SplashPage(
            imageUrl:
                'https://upload.wikimedia.org/wikipedia/commons/9/9b/Former_in_tamilnadu.jpg',
            text: 'Get Started!',
            showNextButton: true,
            onNext: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            backgroundColor: Colors.orangeAccent,
          ),
        ],
      ),
    );
  }
}

class SplashPage extends StatelessWidget {
  final String imageUrl;
  final String text;
  final bool showNextButton;
  final VoidCallback? onNext;
  final Color backgroundColor;

  const SplashPage({
    required this.imageUrl,
    required this.text,
    this.showNextButton = false,
    this.onNext,
    this.backgroundColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                imageUrl,
                width: 300.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              text,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            if (showNextButton) ...[
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onNext,
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
