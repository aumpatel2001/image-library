import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CategoryPage(category: 'all'),
    );
  }
}

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
    'people': [
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Categories')),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories.keys.elementAt(index);
            return ListTile(
              title: Text(category, style: const TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageListScreen(
                      category: category,
                      imagePaths: categories[category]!,
                    ),
                  ),
                );
              },
            );
          },
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

  @override
  void initState() {
    super.initState();
    imagePaths = List.from(widget.imagePaths);
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => imagePaths.add(pickedFile.path));
    }
  }

  Future<void> _downloadImage(String imagePath) async {
    try {
      if (await Permission.storage.request().isGranted) {
        final directory = await getApplicationDocumentsDirectory();
        final file = File(imagePath);
        final newFile = File('${directory.path}/${file.path.split('/').last}');
        await file.copy(newFile.path);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Saved to ${newFile.path}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download failed: $e')),
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
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: imagePaths.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      imagePaths[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 50),
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.download),
                        onPressed: () => _downloadImage(imagePaths[index]),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
