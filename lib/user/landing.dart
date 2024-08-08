import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmerapp/user/crop.dart';
import 'package:farmerapp/user/login.dart';
import 'package:farmerapp/user/policy.dart';
import 'package:flutter/material.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  final List<String> imgList = [
    'https://tse4.mm.bing.net/th?id=OIP.VldvHyaNOVQ7NyykbTxEkQHaE8&pid=Api&P=0&h=180',
    'https://tse2.mm.bing.net/th?id=OIP.DqamVa0TeS9btFBmpy5laQHaDt&pid=Api&P=0&h=180',
    'https://thumbs.dreamstime.com/b/young-indian-farmer-using-smartphone-green-cotton-field-young-indian-farmer-using-smartphone-green-cotton-field-220513763.jpg',
    'https://tse2.mm.bing.net/th?id=OIP.hSV3fPHnDKnGU8Q9gPtSjgHaE7&pid=Api&P=0&h=180',
    'https://tse4.mm.bing.net/th?id=OIP.w4NPhKDah0f7OEHnpc8WHAHaE8&pid=Api&P=0&h=180',
  ];

  final List<Map<String, String>> tools = [
    {
      'image':
          'https://5.imimg.com/data5/SELLER/Default/2023/9/347883711/WU/AG/FS/36836460/tactor-dozer-new-available-1000x1000.jpg',
      'name': 'Tractor',
      'description':
          'A tractor is a powerful vehicle designed for pulling and operating agricultural machinery. It can be used for various tasks such as plowing, tilling, planting, and hauling heavy loads. Modern tractors are equipped with advanced technology, GPS systems, and automated steering to enhance productivity and efficiency.'
    },
    {
      'image':
          'https://images.nightcafe.studio/jobs/lQA5rYjxgldCcJSzntZ9/lQA5rYjxgldCcJSzntZ9--2--jmnnd.jpg?tr=w-1600,c-at_max',
      'name': 'Plow',
      'description':
          'A plow is a farming implement used to prepare the soil for planting by turning over the upper layer, bringing fresh nutrients to the surface, and burying weeds and crop remains. There are different types of plows, including moldboard plows, chisel plows, and disc plows, each designed for specific soil conditions and purposes.'
    },
    {
      'image':
          'https://img.freepik.com/premium-photo/precision-sowing-isolated-seeder-with-white-background-generative-ai_506134-19447.jpg',
      'name': 'Seeder',
      'description':
          'A seeder is a machine used to sow seeds evenly and at the correct depth in the soil. It ensures proper spacing between seeds, which helps in achieving optimal crop density and reducing competition for nutrients and sunlight. Seeders come in various types, such as broadcast seeders, precision seeders, and air seeders, catering to different crop requirements.'
    },
    {
      'image':
          'https://t4.ftcdn.net/jpg/00/87/66/65/360_F_87666594_GO11Iy5RoBoHBfo9ZNczZ0OIiHwOVlGb.jpg',
      'name': 'Harvester',
      'description':
          'A harvester is a machine used to efficiently gather mature crops from the fields. There are different types of harvesters, such as combine harvesters, which are used for grains like wheat, corn, and barley, and specialized harvesters for crops like potatoes, cotton, and sugarcane. Combine harvesters can perform multiple functions, including reaping, threshing, and winnowing.'
    },
    {
      'image':
          'https://img.freepik.com/premium-photo/smart-irrigation-system-saving-water-improving-ai-generated-illustration_866663-14161.jpg',
      'name': 'Irrigation System',
      'description':
          'An irrigation system is a network of pipes, pumps, and sprinklers designed to deliver water to crops in a controlled manner. It ensures that crops receive adequate water, especially in regions with insufficient rainfall. Common types of irrigation systems include drip irrigation, which delivers water directly to the root zone, and sprinkler irrigation, which sprays water over the crops like rainfall.'
    },
    {
      'image':
          'https://t4.ftcdn.net/jpg/05/07/56/83/360_F_507568339_eFJlKtkqUAUpq1vXre10szMIqbNVZEzQ.jpg',
      'name': 'Fusarium Wilt',
      'description':
          ' Fusarium wilt is a soil-borne fungal disease caused by species of the genus Fusarium. It affects a wide range of crops, including tomatoes, bananas, and legumes. Infected plants show symptoms like yellowing and wilting of leaves, stunted growth, and brown streaks in the vascular tissue. The fungus can persist in soil for many years, making crop rotation and resistant varieties important management strategies.'
    },
    {
      'image':
          'https://www.shutterstock.com/image-photo/downy-mildew-disease-on-cucumber-600nw-2352095207.jpg',
      'name': 'Downy Mildew',
      'description':
          'Downy mildew is a disease caused by various species of oomycetes that affects crops like grapes, lettuce, cucumbers, and onions. It manifests as yellow or pale green spots on the upper leaf surfaces, with a characteristic downy growth of fungal spores on the undersides. The disease thrives in cool, humid conditions and can severely reduce crop yields and quality.'
    },
    {
      'image':
          'https://cdn.britannica.com/61/185161-050-726ED959/spots-Orange-cedar-apple-rust-disease-apple-leaf.jpg',
      'name': 'Rust',
      'description':
          'Rust is a fungal disease that affects many cereal crops, including wheat, barley, and oats. It produces reddish-brown, orange, or yellow pustules on leaves and stems. There are various types of rust, such as stem rust, leaf rust, and stripe rust, each targeting different parts of the plant. Rust infections can lead to significant yield losses and weakened plants.'
    },
    {
      'image':
          'https://www.researchgate.net/publication/350688504/figure/fig1/AS:1014241893031939@1618825519311/Early-blight-symptoms-exhibited-by-all-the-isolates-on-potato-detached-leaves-Both-sides.jpg',
      'name': 'Late Blight',
      'description':
          'Late blight is a serious disease caused by the oomycete pathogen Phytophthora infestans, affecting crops like potatoes and tomatoes. It is characterized by water-soaked lesions on leaves, stems, and tubers, which turn brown and rot. The disease spreads rapidly in cool, moist conditions and can devastate entire crops if not managed promptly.'
    },
    {
      'image':
          'https://img.freepik.com/premium-photo/simple-illustration-powdery-mildew-spots-leaves_1177187-37136.jpg',
      'name': 'Powdery Mildew',
      'description':
          'Powdery mildew is a fungal disease that affects a wide range of crops, including cereals, vegetables, fruits, and ornamental plants. It appears as white or gray powdery spots on the leaves, stems, and flowers. The disease can stunt plant growth, reduce yields, and affect the quality of produce. It thrives in warm, dry conditions and spreads through wind-blown spores.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        title: Text('Welcome'),
        leading: IconButton(
          onPressed: _openDrawer,
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        actions: [],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Text(
                '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.pending_actions),
              title: const Text('Crops details'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Crop()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Policies'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PolicyApp()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: const Text('Log Out'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items: imgList
                  .map((item) => Container(
                        child: Center(
                            child: Image.network(item,
                                fit: BoxFit.cover, width: 1000)),
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Tools',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // Display tools in rows
            Column(
              children: tools.map((tool) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(tool['image']!,
                            fit: BoxFit.cover,
                            height: 150,
                            width: double.infinity),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            tool['name']!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(tool['description']!),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
