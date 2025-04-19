import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:ui';  
import 'login_page.dart';
import 'register_page.dart';
import 'settings_page.dart';
import 'theme_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, List<String>> categories = const {
    'Live Wallpapers': [
      'assets/live_wallpapers/live1.gif',
      'assets/live_wallpapers/live2.gif',
      'assets/live_wallpapers/live3.gif',
      'assets/live_wallpapers/live4.gif',
      'assets/live_wallpapers/live5.gif',
      'assets/live_wallpapers/live6.gif',
      'assets/live_wallpapers/live7.gif',
      'assets/live_wallpapers/live8.gif',
      'assets/live_wallpapers/live9.gif',
      'assets/live_wallpapers/live10.gif',
    ],
    'Animals': [
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
  };

  // Image descriptions map
  final Map<String, String> imageDescriptions = const {
    // Live Wallpaper descriptions
    'assets/live_wallpapers/live1.gif': 'Dynamic ocean waves crashing on a sunset beach',
    'assets/live_wallpapers/live2.gif': 'Floating particles in space with vibrant colors',
    'assets/live_wallpapers/live3.gif': 'Raindrops falling on a crystal clear surface',
    'assets/live_wallpapers/live4.gif': 'Aurora borealis dancing in the night sky',
    'assets/live_wallpapers/live5.gif': 'Geometric patterns morphing and transforming',
    'assets/live_wallpapers/live6.gif': 'Cherry blossoms falling in a gentle breeze',
    'assets/live_wallpapers/live7.gif': 'Abstract fluid art in motion',
    'assets/live_wallpapers/live8.gif': 'Neon city lights pulsing at night',
    'assets/live_wallpapers/live9.gif': 'Peaceful forest scene with swaying trees',
    'assets/live_wallpapers/live10.gif': 'Cosmic galaxy spiral in motion',
    
    // Existing descriptions
    'assets/animals/img1.jpg': 'Majestic lion in the wild, showcasing its powerful presence.',
    'assets/animals/img2.jpg': 'Colorful tropical parrot perched on a branch.',
    'assets/animals/img3.jpg': 'Playful dolphins jumping in the ocean waves.',
    'assets/animals/img4.jpg': 'Elegant tiger prowling through tall grass.',
    'assets/animals/img5.jpg': 'Baby elephant playing with its family.',
    'assets/animals/img6.jpg': 'Graceful giraffe reaching for leaves in the savanna.',
    // Add more descriptions as needed
  };

  void _showImageDialog(String imagePath, String category) {
    bool isLiveWallpaper = imagePath.toLowerCase().endsWith('.gif');
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Hero(
                    tag: imagePath,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.contain,
                        gaplessPlayback: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  if (isLiveWallpaper)
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.motion_photos_on,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'LIVE WALLPAPER',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      imageDescriptions[imagePath] ?? 'No description available',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => _setWallpaper(context, imagePath, isLiveWallpaper),
                          icon: Icon(
                            isLiveWallpaper
                                ? Icons.play_circle_outline
                                : Icons.wallpaper,
                            color: Colors.white,
                          ),
                          label: Text(
                            isLiveWallpaper
                                ? 'Set Live Wallpaper'
                                : 'Set as Wallpaper',
                            style: const TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _downloadImage(context, imagePath),
                          icon: const Icon(
                            Icons.download,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Download',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
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
  }

  Future<void> _setWallpaper(BuildContext context, String imagePath, bool isLive) async {
    try {
      // Request storage permission
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Storage permission is required'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Show loading indicator
      if (!context.mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Get the temporary directory
      final directory = await getTemporaryDirectory();
      final String tempPath = '${directory.path}/temp_wallpaper${isLive ? '.gif' : '.jpg'}';

      // Copy the asset to a temporary file
      ByteData data = await rootBundle.load(imagePath);
      List<int> bytes = data.buffer.asUint8List();
      await File(tempPath).writeAsBytes(bytes);

      // Set the wallpaper
      if (isLive) {
        // For live wallpapers, use platform-specific method
        const platform = MethodChannel('wallpaper_channel');
        try {
          await platform.invokeMethod('setLiveWallpaper', {'path': tempPath});
        } on PlatformException catch (e) {
          throw 'Failed to set live wallpaper: ${e.message}';
        }
      } else {
        // For static wallpapers, use system wallpaper setting
        const platform = MethodChannel('wallpaper_channel');
        try {
          await platform.invokeMethod('setWallpaper', {'path': tempPath});
        } on PlatformException catch (e) {
          throw 'Failed to set wallpaper: ${e.message}';
        }
      }

      // Clean up the temporary file
      await File(tempPath).delete();

      // Close loading indicator and show success message
      if (!context.mounted) return;
      Navigator.pop(context); // Close loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isLive ? 'Live wallpaper set successfully!' : 'Wallpaper set successfully!',
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      // Close loading indicator if open
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to set wallpaper: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _downloadImage(BuildContext context, String imagePath) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Get the downloads directory
      final directory = await getDownloadsDirectory();
      if (directory == null) throw 'Could not access downloads directory';

      // Generate a unique filename
      final String fileName = imagePath.split('/').last;
      final String filePath = '${directory.path}/$fileName';

      // Copy the asset to the downloads directory
      ByteData data = await rootBundle.load(imagePath);
      List<int> bytes = data.buffer.asUint8List();
      await File(filePath).writeAsBytes(bytes);

      // Close loading indicator
      Navigator.pop(context);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image saved to downloads: $fileName'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      // Close loading indicator if open
      if (context.mounted) {
        Navigator.pop(context);
      }

      // Show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to download image: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _showAllImages(BuildContext context, String category, List<String> images) {
    bool isLiveWallpaper = category == 'Live Wallpapers';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        isLiveWallpaper ? Icons.motion_photos_on : Icons.category,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        category,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75, // This will make the images slightly taller than wide
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _showImageDialog(images[index], category),
                    child: Hero(
                      tag: images[index],
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                images[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                            if (isLiveWallpaper)
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(
                                        Icons.motion_photos_on,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'LIVE',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(String category, List<String> images) {
    bool isLiveWallpaper = category == 'Live Wallpapers';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      isLiveWallpaper ? Icons.motion_photos_on : Icons.category,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        category,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () => _showAllImages(context, category, images),
                icon: const Icon(Icons.grid_view, color: Colors.white),
                label: const Text(
                  'View All',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: GestureDetector(
                  onTap: () => _showImageDialog(images[index], category),
                  child: Stack(
                    children: [
                      Hero(
                        tag: images[index],
                        child: Container(
                          width: 150,
                          height: 192,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.cover,
                              gaplessPlayback: true,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: Icon(
                                      Icons.error_outline,
                                      color: Colors.grey,
                                      size: 32,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      if (isLiveWallpaper)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.motion_photos_on,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'LIVE',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Image Gallery',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.purple],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.photo_library,
                      size: 64,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Menu",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home, color: Colors.white),
                title: const Text("Home", style: TextStyle(color: Colors.white)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.white),
                title: const Text("Settings", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.login, color: Colors.white),
                title: const Text("Login", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_add, color: Colors.white),
                title: const Text("Register", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                ...categories.entries.map((entry) => _buildCategorySection(entry.key, entry.value)).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 