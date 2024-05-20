import 'package:flutter/material.dart';
import 'package:photo_gallery_with_api/photo_gallery_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery By Api call',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      )),
      home: const PhotoGalleryScreen(),
    );
  }
}
