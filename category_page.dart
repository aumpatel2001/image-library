import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';

// Category List Screen
class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, required this.category});
  final String category;

  final Map<String, List<String>> categories = const {
    'Animal': [
      'assets/animals/img1.jpg',
      'assets/animals/img2.jpg',
      'assets/animals/img3.jpg',
      'assets/animals/img4.jpg',
      'assets/animals/img5.jpg',
      'assets/animals/img6.jpg',
      'assets/animals/img8.jpg',
      'assets/animals/img9.jpg',
      'assets/animals/img10.jpg',
      'assets/animals/img11.jpg',
      'assets/animals/img12.jpg',
      'assets/animals/img13.jpg',
      'assets/animals/img14.jpg',
      'assets/animals/img15.jpg',
      'assets/animals/img16.jpg',
      'assets/animals/img17.jpg',
      'assets/animals/img18.jpg',
      'assets/animals/img19.jpg',
      'assets/animals/img20.jpg',
    ],
    'Technology': [
      'assets/Technology/img1.jpg',
      'assets/Technology/img2.jpg',
      'assets/Technology/img3.jpg',
      'assets/Technology/img4.jpg',
      'assets/Technology/img5.jpg',
      'assets/Technology/img6.jpg',
      'assets/Technology/img7.jpg',
      'assets/Technology/img8.jpg',
      'assets/Technology/img9.jpg',
      'assets/Technology/img10.jpg',
      'assets/Technology/img11.jpg',
      'assets/Technology/img12.jpg',
      'assets/Technology/img13.jpg',
      'assets/Technology/img14.jpg',
      'assets/Technology/img15.jpg',
      'assets/Technology/img16.jpg',
      'assets/Technology/img17.jpg',
      'assets/Technology/img18.jpg',
      'assets/Technology/img19.jpg',
      'assets/Technology/img20.jpg',
    ],
    'Sports': [
      'assets/sports/img1.jpg',
      'assets/sports/img2.jpg',
      'assets/sports/img3.jpg',
      'assets/sports/img4.jpg',
      'assets/sports/img5.jpg',
      'assets/sports/img6.jpg',
      'assets/sports/img7.jpg',
      'assets/sports/img8.jpg',
      'assets/sports/img9.jpg',
      'assets/sports/img10.jpg',
      'assets/sports/img11.jpg',
      'assets/sports/img12.jpg',
      'assets/sports/img13.jpg',
      'assets/sports/img14.jpg',
      'assets/sports/img15.jpg',
      'assets/sports/img16.jpg',
      'assets/sports/img17.jpg',
      'assets/sports/img18.jpg',
      'assets/sports/img19.jpg',
      'assets/sports/img20.jpg',
    ],
    'Nature': [
      'assets/nature/img1.jpg',
      'assets/nature/img2.jpg',
      'assets/nature/img3.jpg',
      'assets/nature/img4.jpg',
      'assets/nature/img5.jpg',
      'assets/nature/img6.jpg',
      'assets/nature/img7.jpg',
      'assets/nature/img8.jpg',
      'assets/nature/img9.jpg',
      'assets/nature/img10.jpg',
      'assets/nature/img11.jpg',
      'assets/nature/img12.jpg',
      'assets/nature/img13.jpg',
      'assets/nature/img14.jpg',
      'assets/nature/img15.jpg',
      'assets/nature/img16.jpg',
      'assets/nature/img17.jpg',
      'assets/nature/img18.jpg',
      'assets/nature/img19.jpg',
      'assets/nature/img20.jpg',
    ],
    'Art': [
      'assets/art/img1.jpg',
      'assets/art/img2.jpg',
      'assets/art/img3.jpg',
      'assets/art/img4.jpg',
      'assets/art/img5.jpg',
      'assets/art/img6.jpg',
      'assets/art/img7.jpg',
      'assets/art/img8.jpg',
      'assets/art/img9.jpg',
      'assets/art/img10.jpg',
      'assets/art/img11.jpg',
      'assets/art/img12.jpg',
      'assets/art/img13.jpg',
      'assets/art/img14.jpg',
      'assets/art/img15.jpg',
      'assets/art/img16.jpg',
      'assets/art/img17.jpg',
      'assets/art/img18.jpg',
      'assets/art/img19.jpg',
      'assets/art/img20.jpg',
    ],
    'Cities': [
      'assets/cities/img1.jpg',
      'assets/cities/img2.jpg',
      'assets/cities/img3.jpg',
      'assets/cities/img4.jpg',
      'assets/cities/img5.jpg',
      'assets/cities/img6.jpg',
      'assets/cities/img7.jpg',
      'assets/cities/img8.jpg',
      'assets/cities/img9.jpg',
      'assets/cities/img10.jpg',
      'assets/cities/img11.jpg',
      'assets/cities/img12.jpg',
      'assets/cities/img13.jpg',
      'assets/cities/img14.jpg',
      'assets/cities/img15.jpg',
      'assets/cities/img16.jpg',
      'assets/cities/img17.jpg',
      'assets/cities/img18.jpg',
      'assets/cities/img19.jpg',
      'assets/cities/img20.jpg',
    ],
    'People': [
      'assets/people/img1.jpg',
      'assets/people/img2.jpg',
      'assets/people/img3.jpg',
      'assets/people/img4.jpg',
      'assets/people/img5.jpg',
      'assets/people/img6.jpg',
      'assets/people/img8.jpg',
      'assets/people/img9.jpg',
      'assets/people/img10.jpg',
      'assets/people/img11.jpg',
      'assets/people/img12.jpg',
      'assets/people/img13.jpg',
      'assets/people/img14.jpg',
      'assets/people/img15.jpg',
      'assets/people/img16.jpg',
      'assets/people/img17.jpg',
      'assets/people/img18.jpg',
      'assets/people/img19.jpg',
      'assets/people/img20.jpg',
    ],
    'Food': [
      'assets/food/img1.jpg',
      'assets/food/img2.jpg',
      'assets/food/img3.jpg',
      'assets/food/img4.jpg',
      'assets/food/img5.jpg',
      'assets/food/img6.jpg',
      'assets/food/img8.jpg',
      'assets/food/img9.jpg',
      'assets/food/img10.jpg',
      'assets/food/img11.jpg',
      'assets/food/img12.jpg',
      'assets/food/img13.jpg',
      'assets/food/img14.jpg',
      'assets/food/img15.jpg',
      'assets/food/img16.jpg',
      'assets/food/img17.jpg',
      'assets/food/img18.jpg',
      'assets/food/img19.jpg',
      'assets/food/img20.jpg',
    ]
  };

  // Image descriptions map
  final Map<String, String> imageDescriptions = const {
    // Animal images
    'assets/animals/img1.jpg': 'A beautifull Duck.',
    'assets/animals/img2.jpg': 'A beautifull Dog.',
    'assets/animals/img3.jpg': 'A beautifull Cat.',
    'assets/animals/img4.jpg': 'A beautifull Bird.',
    'assets/animals/img5.jpg': 'A beautifull Fish.',
    'assets/animals/img6.jpg': 'Graceful giraffe reaching for leaves in the savanna.',
    'assets/animals/img8.jpg': 'Curious red panda exploring its environment.',
    'assets/animals/img9.jpg': 'Majestic eagle soaring through mountain peaks.',
    'assets/animals/img10.jpg': 'Peaceful pandas enjoying bamboo shoots.',
    'assets/animals/img11.jpg': 'Arctic fox in its natural snowy habitat.',
    'assets/animals/img12.jpg': 'Family of meerkats standing guard.',
    'assets/animals/img13.jpg': 'Gentle sea turtle gliding through coral reefs.',
    'assets/animals/img14.jpg': 'Magnificent whale breaching the ocean surface.',
    'assets/animals/img15.jpg': 'Rare snow leopard in mountain terrain.',
    'assets/animals/img16.jpg': 'Vibrant peacock displaying its feathers.',
    'assets/animals/img17.jpg': 'Adorable koala resting in eucalyptus tree.',
    'assets/animals/img18.jpg': 'Swift cheetah in full sprint.',
    'assets/animals/img19.jpg': 'Wise owl perched in twilight.',
    'assets/animals/img20.jpg': 'Playful penguins on Antarctic ice.',

    // Technology images
    'assets/Technology/img1.jpg': 'Latest smartphone showcasing innovative design.',
    'assets/Technology/img2.jpg': 'Advanced robotics in manufacturing.',
    'assets/Technology/img3.jpg': 'Virtual reality headset in action.',
    'assets/Technology/img4.jpg': 'Electric vehicle charging station.',
    'assets/Technology/img5.jpg': 'Modern laptop with edge-to-edge display.',
    'assets/Technology/img6.jpg': 'Smart home automation system.',
    'assets/Technology/img7.jpg': 'Drone capturing aerial photography.',
    'assets/Technology/img8.jpg': 'Artificial intelligence visualization.',
    'assets/Technology/img9.jpg': '5G network tower installation.',
    'assets/Technology/img10.jpg': 'Solar panel array powering homes.',
    'assets/Technology/img11.jpg': 'Quantum computing processor.',
    'assets/Technology/img12.jpg': 'Augmented reality glasses prototype.',
    'assets/Technology/img13.jpg': 'Smart watch with health monitoring.',
    'assets/Technology/img14.jpg': 'Electric car charging station.',
    'assets/Technology/img15.jpg': 'Blockchain technology visualization.',
    'assets/Technology/img16.jpg': 'Advanced medical imaging equipment.',
    'assets/Technology/img17.jpg': 'Smart city infrastructure.',
    'assets/Technology/img18.jpg': 'Cybersecurity system interface.',
    'assets/Technology/img19.jpg': 'Renewable energy technology.',
    'assets/Technology/img20.jpg': 'Space exploration technology.',

    // Sports images
    'assets/sports/img1.jpg': 'Intense football match moment.',
    'assets/sports/img2.jpg': 'Basketball player dunking dramatically.',
    'assets/sports/img3.jpg': 'Tennis player serving at championship.',
    'assets/sports/img4.jpg': 'Olympic swimming competition.',
    'assets/sports/img5.jpg': 'Mountain biking extreme sports.',
    'assets/sports/img6.jpg': 'Soccer player scoring goal.',
    'assets/sports/img7.jpg': 'Marathon runners at sunrise.',
    'assets/sports/img8.jpg': 'Rock climbing adventure sport.',
    'assets/sports/img9.jpg': 'Skateboarding tricks in action.',
    'assets/sports/img10.jpg': 'Boxing match intense moment.',
    'assets/sports/img11.jpg': 'Surfing perfect wave.',
    'assets/sports/img12.jpg': 'Ice hockey game action.',
    'assets/sports/img13.jpg': 'Golf player perfect swing.',
    'assets/sports/img14.jpg': 'Rugby match tackle.',
    'assets/sports/img15.jpg': 'Volleyball beach tournament.',
    'assets/sports/img16.jpg': 'Cricket match winning moment.',
    'assets/sports/img17.jpg': 'Formula 1 racing action.',
    'assets/sports/img18.jpg': 'Gymnastics perfect routine.',
    'assets/sports/img19.jpg': 'Baseball home run celebration.',
    'assets/sports/img20.jpg': 'Skiing down powder snow.',

    // Nature images
    'assets/nature/img1.jpg': 'Stunning sunset over mountain range.',
    'assets/nature/img2.jpg': 'Pristine beach with crystal clear water.',
    'assets/nature/img3.jpg': 'Dense rainforest canopy.',
    'assets/nature/img4.jpg': 'Northern lights dancing in sky.',
    'assets/nature/img5.jpg': 'Desert sand dunes at dawn.',
    'assets/nature/img6.jpg': 'Waterfall in tropical paradise.',
    'assets/nature/img7.jpg': 'Alpine lake reflection.',
    'assets/nature/img8.jpg': 'Cherry blossoms in spring.',
    'assets/nature/img9.jpg': 'Autumn forest colors.',
    'assets/nature/img10.jpg': 'Snow-capped mountain peak.',
    'assets/nature/img11.jpg': 'Coral reef underwater scene.',
    'assets/nature/img12.jpg': 'Rolling hills in countryside.',
    'assets/nature/img13.jpg': 'Volcanic eruption spectacle.',
    'assets/nature/img14.jpg': 'Misty morning in valley.',
    'assets/nature/img15.jpg': 'Rainbow after storm.',
    'assets/nature/img16.jpg': 'Cave crystal formations.',
    'assets/nature/img17.jpg': 'Wildflower meadow bloom.',
    'assets/nature/img18.jpg': 'Giant redwood forest.',
    'assets/nature/img19.jpg': 'Glacier ice formation.',
    'assets/nature/img20.jpg': 'Desert oasis at sunset.',

    // Art images
    'assets/art/img1.jpg': 'Abstract modern painting.',
    'assets/art/img2.jpg': 'Classical sculpture masterpiece.',
    'assets/art/img3.jpg': 'Street art mural.',
    'assets/art/img4.jpg': 'Digital art creation.',
    'assets/art/img5.jpg': 'Contemporary installation.',
    'assets/art/img6.jpg': 'Traditional pottery craft.',
    'assets/art/img7.jpg': 'Oil painting landscape.',
    'assets/art/img8.jpg': 'Glass blowing artwork.',
    'assets/art/img9.jpg': 'Photography exhibition piece.',
    'assets/art/img10.jpg': 'Metal sculpture installation.',
    'assets/art/img11.jpg': 'Watercolor painting scene.',
    'assets/art/img12.jpg': 'Mixed media artwork.',
    'assets/art/img13.jpg': 'Textile art design.',
    'assets/art/img14.jpg': 'Graffiti art expression.',
    'assets/art/img15.jpg': 'Performance art moment.',
    'assets/art/img16.jpg': 'Light installation art.',
    'assets/art/img17.jpg': 'Ceramic art piece.',
    'assets/art/img18.jpg': 'Wood carving detail.',
    'assets/art/img19.jpg': 'Paper art creation.',
    'assets/art/img20.jpg': 'Digital sculpture render.',

    // Cities images
    'assets/cities/img1.jpg': 'New York skyline at night.',
    'assets/cities/img2.jpg': 'Tokyo street life.',
    'assets/cities/img3.jpg': 'Paris Eiffel Tower view.',
    'assets/cities/img4.jpg': 'London historic architecture.',
    'assets/cities/img5.jpg': 'Dubai modern buildings.',
    'assets/cities/img6.jpg': 'Venice canal scene.',
    'assets/cities/img7.jpg': 'Singapore garden city.',
    'assets/cities/img8.jpg': 'Rome ancient ruins.',
    'assets/cities/img9.jpg': 'Hong Kong harbor view.',
    'assets/cities/img10.jpg': 'Sydney opera house.',
    'assets/cities/img11.jpg': 'Amsterdam canal houses.',
    'assets/cities/img12.jpg': 'Barcelona street art.',
    'assets/cities/img13.jpg': 'San Francisco bridge.',
    'assets/cities/img14.jpg': 'Moscow Red Square.',
    'assets/cities/img15.jpg': 'Rio carnival scene.',
    'assets/cities/img16.jpg': 'Istanbul grand bazaar.',
    'assets/cities/img17.jpg': 'Berlin wall art.',
    'assets/cities/img18.jpg': 'Mumbai city life.',
    'assets/cities/img19.jpg': 'Seoul night market.',
    'assets/cities/img20.jpg': 'Cairo pyramids view.',

    // People images
    'assets/people/img1.jpg': 'Street photographer at work.',
    'assets/people/img2.jpg': 'Children playing in park.',
    'assets/people/img3.jpg': 'Elder telling stories.',
    'assets/people/img4.jpg': 'Artist in their studio.',
    'assets/people/img5.jpg': 'Farmer in the fields.',
    'assets/people/img6.jpg': 'Musicians performing live.',
    'assets/people/img8.jpg': 'Traditional dance performance.',
    'assets/people/img9.jpg': 'Market vendor smiling.',
    'assets/people/img10.jpg': 'Family picnic moment.',
    'assets/people/img11.jpg': 'Street performer show.',
    'assets/people/img12.jpg': 'Teacher with students.',
    'assets/people/img13.jpg': 'Chef preparing food.',
    'assets/people/img14.jpg': 'Craftsman at work.',
    'assets/people/img15.jpg': 'Athletes training.',
    'assets/people/img16.jpg': 'Fashion designer creating.',
    'assets/people/img17.jpg': 'Doctor with patient.',
    'assets/people/img18.jpg': 'Construction worker.',
    'assets/people/img19.jpg': 'Scientist in lab.',
    'assets/people/img20.jpg': 'Volunteer helping others.',

    // Food images
    'assets/food/img1.jpg': 'Gourmet pasta dish.',
    'assets/food/img2.jpg': 'Fresh sushi platter.',
    'assets/food/img3.jpg': 'Colorful fruit arrangement.',
    'assets/food/img4.jpg': 'Artisanal bread display.',
    'assets/food/img5.jpg': 'Grilled steak perfection.',
    'assets/food/img6.jpg': 'Homemade pizza creation.',
    'assets/food/img8.jpg': 'Decadent chocolate dessert.',
    'assets/food/img9.jpg': 'Fresh seafood selection.',
    'assets/food/img10.jpg': 'Traditional curry dish.',
    'assets/food/img11.jpg': 'Breakfast spread.',
    'assets/food/img12.jpg': 'Street food delicacy.',
    'assets/food/img13.jpg': 'Vegetarian salad bowl.',
    'assets/food/img14.jpg': 'Ice cream sundae.',
    'assets/food/img15.jpg': 'Coffee art design.',
    'assets/food/img16.jpg': 'BBQ grill feast.',
    'assets/food/img17.jpg': 'Mexican taco spread.',
    'assets/food/img18.jpg': 'French pastries.',
    'assets/food/img19.jpg': 'Asian noodle soup.',
    'assets/food/img20.jpg': 'Mediterranean mezze.'
  };

  String _getImageDescription(String imagePath) {
    return imageDescriptions[imagePath] ?? 'A beautiful image from our collection';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Categories'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final categoryName = categories.keys.elementAt(index);
              final categoryData = categories[categoryName]!;
              
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageListScreen(
                        category: categoryName,
                        imagePaths: categoryData,
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(categoryData[0]),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            categoryName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Tap to view',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Image List Screen
class ImageListScreen extends StatefulWidget {
  final String category;
  final List<String> imagePaths;

  const ImageListScreen({super.key, required this.category, required this.imagePaths});

  @override
  _ImageListScreenState createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  final ImagePicker _picker = ImagePicker();
  List<String> imagePaths = [];

  // Add image descriptions map
  final Map<String, String> imageDescriptions = const {
    // Animal images
    'assets/animals/img1.jpg': 'Majestic lion in the wild, showcasing its powerful presence.',
    'assets/animals/img2.jpg': 'Colorful tropical parrot perched on a branch.',
    'assets/animals/img3.jpg': 'Playful dolphins jumping in the ocean waves.',
    'assets/animals/img4.jpg': 'Elegant tiger prowling through tall grass.',
    'assets/animals/img5.jpg': 'Baby elephant playing with its family.',
    'assets/animals/img6.jpg': 'Graceful giraffe reaching for leaves in the savanna.',
    'assets/animals/img8.jpg': 'Curious red panda exploring its environment.',
    'assets/animals/img9.jpg': 'Majestic eagle soaring through mountain peaks.',
    'assets/animals/img10.jpg': 'Peaceful pandas enjoying bamboo shoots.',
    'assets/animals/img11.jpg': 'Arctic fox in its natural snowy habitat.',
    'assets/animals/img12.jpg': 'Family of meerkats standing guard.',
    'assets/animals/img13.jpg': 'Gentle sea turtle gliding through coral reefs.',
    'assets/animals/img14.jpg': 'Magnificent whale breaching the ocean surface.',
    'assets/animals/img15.jpg': 'Rare snow leopard in mountain terrain.',
    'assets/animals/img16.jpg': 'Vibrant peacock displaying its feathers.',
    'assets/animals/img17.jpg': 'Adorable koala resting in eucalyptus tree.',
    'assets/animals/img18.jpg': 'Swift cheetah in full sprint.',
    'assets/animals/img19.jpg': 'Wise owl perched in twilight.',
    'assets/animals/img20.jpg': 'Playful penguins on Antarctic ice.',

    // Technology images
    'assets/Technology/img1.jpg': 'Latest smartphone showcasing innovative design.',
    'assets/Technology/img2.jpg': 'Advanced robotics in manufacturing.',
    'assets/Technology/img3.jpg': 'Virtual reality headset in action.',
    'assets/Technology/img4.jpg': 'Electric vehicle charging station.',
    'assets/Technology/img5.jpg': 'Modern laptop with edge-to-edge display.',
    'assets/Technology/img6.jpg': 'Smart home automation system.',
    'assets/Technology/img7.jpg': 'Drone capturing aerial photography.',
    'assets/Technology/img8.jpg': 'Artificial intelligence visualization.',
    'assets/Technology/img9.jpg': '5G network tower installation.',
    'assets/Technology/img10.jpg': 'Solar panel array powering homes.',
    'assets/Technology/img11.jpg': 'Quantum computing processor.',
    'assets/Technology/img12.jpg': 'Augmented reality glasses prototype.',
    'assets/Technology/img13.jpg': 'Smart watch with health monitoring.',
    'assets/Technology/img14.jpg': 'Electric car charging station.',
    'assets/Technology/img15.jpg': 'Blockchain technology visualization.',
    'assets/Technology/img16.jpg': 'Advanced medical imaging equipment.',
    'assets/Technology/img17.jpg': 'Smart city infrastructure.',
    'assets/Technology/img18.jpg': 'Cybersecurity system interface.',
    'assets/Technology/img19.jpg': 'Renewable energy technology.',
    'assets/Technology/img20.jpg': 'Space exploration technology.',

    // Sports images
    'assets/sports/img1.jpg': 'Intense football match moment.',
    'assets/sports/img2.jpg': 'Basketball player dunking dramatically.',
    'assets/sports/img3.jpg': 'Tennis player serving at championship.',
    'assets/sports/img4.jpg': 'Olympic swimming competition.',
    'assets/sports/img5.jpg': 'Mountain biking extreme sports.',
    'assets/sports/img6.jpg': 'Soccer player scoring goal.',
    'assets/sports/img7.jpg': 'Marathon runners at sunrise.',
    'assets/sports/img8.jpg': 'Rock climbing adventure sport.',
    'assets/sports/img9.jpg': 'Skateboarding tricks in action.',
    'assets/sports/img10.jpg': 'Boxing match intense moment.',
    'assets/sports/img11.jpg': 'Surfing perfect wave.',
    'assets/sports/img12.jpg': 'Ice hockey game action.',
    'assets/sports/img13.jpg': 'Golf player perfect swing.',
    'assets/sports/img14.jpg': 'Rugby match tackle.',
    'assets/sports/img15.jpg': 'Volleyball beach tournament.',
    'assets/sports/img16.jpg': 'Cricket match winning moment.',
    'assets/sports/img17.jpg': 'Formula 1 racing action.',
    'assets/sports/img18.jpg': 'Gymnastics perfect routine.',
    'assets/sports/img19.jpg': 'Baseball home run celebration.',
    'assets/sports/img20.jpg': 'Skiing down powder snow.',

    // Nature images
    'assets/nature/img1.jpg': 'Stunning sunset over mountain range.',
    'assets/nature/img2.jpg': 'Pristine beach with crystal clear water.',
    'assets/nature/img3.jpg': 'Dense rainforest canopy.',
    'assets/nature/img4.jpg': 'Northern lights dancing in sky.',
    'assets/nature/img5.jpg': 'Desert sand dunes at dawn.',
    'assets/nature/img6.jpg': 'Waterfall in tropical paradise.',
    'assets/nature/img7.jpg': 'Alpine lake reflection.',
    'assets/nature/img8.jpg': 'Cherry blossoms in spring.',
    'assets/nature/img9.jpg': 'Autumn forest colors.',
    'assets/nature/img10.jpg': 'Snow-capped mountain peak.',
    'assets/nature/img11.jpg': 'Coral reef underwater scene.',
    'assets/nature/img12.jpg': 'Rolling hills in countryside.',
    'assets/nature/img13.jpg': 'Volcanic eruption spectacle.',
    'assets/nature/img14.jpg': 'Misty morning in valley.',
    'assets/nature/img15.jpg': 'Rainbow after storm.',
    'assets/nature/img16.jpg': 'Cave crystal formations.',
    'assets/nature/img17.jpg': 'Wildflower meadow bloom.',
    'assets/nature/img18.jpg': 'Giant redwood forest.',
    'assets/nature/img19.jpg': 'Glacier ice formation.',
    'assets/nature/img20.jpg': 'Desert oasis at sunset.',

    // Art images
    'assets/art/img1.jpg': 'Abstract modern painting.',
    'assets/art/img2.jpg': 'Classical sculpture masterpiece.',
    'assets/art/img3.jpg': 'Street art mural.',
    'assets/art/img4.jpg': 'Digital art creation.',
    'assets/art/img5.jpg': 'Contemporary installation.',
    'assets/art/img6.jpg': 'Traditional pottery craft.',
    'assets/art/img7.jpg': 'Oil painting landscape.',
    'assets/art/img8.jpg': 'Glass blowing artwork.',
    'assets/art/img9.jpg': 'Photography exhibition piece.',
    'assets/art/img10.jpg': 'Metal sculpture installation.',
    'assets/art/img11.jpg': 'Watercolor painting scene.',
    'assets/art/img12.jpg': 'Mixed media artwork.',
    'assets/art/img13.jpg': 'Textile art design.',
    'assets/art/img14.jpg': 'Graffiti art expression.',
    'assets/art/img15.jpg': 'Performance art moment.',
    'assets/art/img16.jpg': 'Light installation art.',
    'assets/art/img17.jpg': 'Ceramic art piece.',
    'assets/art/img18.jpg': 'Wood carving detail.',
    'assets/art/img19.jpg': 'Paper art creation.',
    'assets/art/img20.jpg': 'Digital sculpture render.',

    // Cities images
    'assets/cities/img1.jpg': 'New York skyline at night.',
    'assets/cities/img2.jpg': 'Tokyo street life.',
    'assets/cities/img3.jpg': 'Paris Eiffel Tower view.',
    'assets/cities/img4.jpg': 'London historic architecture.',
    'assets/cities/img5.jpg': 'Dubai modern buildings.',
    'assets/cities/img6.jpg': 'Venice canal scene.',
    'assets/cities/img7.jpg': 'Singapore garden city.',
    'assets/cities/img8.jpg': 'Rome ancient ruins.',
    'assets/cities/img9.jpg': 'Hong Kong harbor view.',
    'assets/cities/img10.jpg': 'Sydney opera house.',
    'assets/cities/img11.jpg': 'Amsterdam canal houses.',
    'assets/cities/img12.jpg': 'Barcelona street art.',
    'assets/cities/img13.jpg': 'San Francisco bridge.',
    'assets/cities/img14.jpg': 'Moscow Red Square.',
    'assets/cities/img15.jpg': 'Rio carnival scene.',
    'assets/cities/img16.jpg': 'Istanbul grand bazaar.',
    'assets/cities/img17.jpg': 'Berlin wall art.',
    'assets/cities/img18.jpg': 'Mumbai city life.',
    'assets/cities/img19.jpg': 'Seoul night market.',
    'assets/cities/img20.jpg': 'Cairo pyramids view.',

    // People images
    'assets/people/img1.jpg': 'Street photographer at work.',
    'assets/people/img2.jpg': 'Children playing in park.',
    'assets/people/img3.jpg': 'Elder telling stories.',
    'assets/people/img4.jpg': 'Artist in their studio.',
    'assets/people/img5.jpg': 'Farmer in the fields.',
    'assets/people/img6.jpg': 'Musicians performing live.',
    'assets/people/img8.jpg': 'Traditional dance performance.',
    'assets/people/img9.jpg': 'Market vendor smiling.',
    'assets/people/img10.jpg': 'Family picnic moment.',
    'assets/people/img11.jpg': 'Street performer show.',
    'assets/people/img12.jpg': 'Teacher with students.',
    'assets/people/img13.jpg': 'Chef preparing food.',
    'assets/people/img14.jpg': 'Craftsman at work.',
    'assets/people/img15.jpg': 'Athletes training.',
    'assets/people/img16.jpg': 'Fashion designer creating.',
    'assets/people/img17.jpg': 'Doctor with patient.',
    'assets/people/img18.jpg': 'Construction worker.',
    'assets/people/img19.jpg': 'Scientist in lab.',
    'assets/people/img20.jpg': 'Volunteer helping others.',

    // Food images
    'assets/food/img1.jpg': 'Gourmet pasta dish.',
    'assets/food/img2.jpg': 'Fresh sushi platter.',
    'assets/food/img3.jpg': 'Colorful fruit arrangement.',
    'assets/food/img4.jpg': 'Artisanal bread display.',
    'assets/food/img5.jpg': 'Grilled steak perfection.',
    'assets/food/img6.jpg': 'Homemade pizza creation.',
    'assets/food/img8.jpg': 'Decadent chocolate dessert.',
    'assets/food/img9.jpg': 'Fresh seafood selection.',
    'assets/food/img10.jpg': 'Traditional curry dish.',
    'assets/food/img11.jpg': 'Breakfast spread.',
    'assets/food/img12.jpg': 'Street food delicacy.',
    'assets/food/img13.jpg': 'Vegetarian salad bowl.',
    'assets/food/img14.jpg': 'Ice cream sundae.',
    'assets/food/img15.jpg': 'Coffee art design.',
    'assets/food/img16.jpg': 'BBQ grill feast.',
    'assets/food/img17.jpg': 'Mexican taco spread.',
    'assets/food/img18.jpg': 'French pastries.',
    'assets/food/img19.jpg': 'Asian noodle soup.',
    'assets/food/img20.jpg': 'Mediterranean mezze.'
  };

  String _getImageDescription(String imagePath) {
    return imageDescriptions[imagePath] ?? 'A beautiful image from our collection';
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePaths.add(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    imagePaths = List.from(widget.imagePaths);
  }

  void _showImageDialog(BuildContext context, String imagePath, List<String> categoryImages) {
    int currentIndex = categoryImages.indexOf(imagePath);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details) {
                  if (details.primaryVelocity! > 0) {
                    // Swiped right - show previous image
                    if (currentIndex > 0) {
                      setState(() {
                        currentIndex--;
                      });
                    }
                  } else if (details.primaryVelocity! < 0) {
                    // Swiped left - show next image
                    if (currentIndex < categoryImages.length - 1) {
                      setState(() {
                        currentIndex++;
                      });
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                        child: Image.asset(
                          categoryImages[currentIndex],
                          fit: BoxFit.contain,
                          height: MediaQuery.of(context).size.height * 0.6,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              imageDescriptions[categoryImages[currentIndex]] ?? 'No description available',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Swipe left or right to navigate',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.close, color: Colors.white),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                //const SizedBox(width: 20),
                                IconButton(
                                  icon: const Icon(Icons.download, color: Colors.white),
                                  onPressed: () => _downloadImage(context, categoryImages[currentIndex]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _downloadImage(BuildContext context, String imagePath) async {
    try {
      if (await Permission.storage.request().isGranted) {
        final directory = await getApplicationDocumentsDirectory();
        final fileName = imagePath.split('/').last;
        final newPath = '${directory.path}/$fileName';

        // Copy the asset to the documents directory
        final ByteData data = await rootBundle.load(imagePath);
        final bytes = data.buffer.asUint8List();
        final File file = File(newPath);
        await file.writeAsBytes(bytes);

        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image saved to $newPath'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Storage permission denied'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: _pickImage,
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: imagePaths.isEmpty
            ? const Center(child: Text("No Images Available", style: TextStyle(color: Colors.white)))
            : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0,
                ),
                itemCount: imagePaths.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _showImageDialog(context, imagePaths[index], imagePaths),
                    child: Card(
                      elevation: 8,
                      shadowColor: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                imagePaths[index],
                                fit: BoxFit.cover,
                                cacheWidth: 300,
                                cacheHeight: 300,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      color: Colors.grey[300],
                                      child: const Icon(
                                        Icons.broken_image,
                                        size: 50,
                                        color: Colors.white54,
                                      ),
                                    ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.6),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12,
                                  ),
                                  child: const Text(
                                    'Tap to view',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}