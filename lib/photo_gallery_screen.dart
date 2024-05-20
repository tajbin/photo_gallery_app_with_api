import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'package:photo_gallery_with_api/photo_details.dart';
import 'package:photo_gallery_with_api/photo_model.dart';

class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({super.key});

  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  List<PhotoModel> photoList = [];
  bool _photoGalleryListInProgress = false;
  bool _hasError = false;

  @override
  void initState() {
    _getPhotoList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Gallery App"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Visibility(
          visible: _photoGalleryListInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: _hasError
              ? const Center(child: Text(("Photo Gallery Load Failed")))
              : ListView.builder(
                  itemCount: photoList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: _buildPhotoList(photoList[index]),
                    );
                  }),
        ),
      ),
    );
  }

  Widget _buildPhotoList(PhotoModel photoItem) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhotoDetailsScreen(
                photoUrl: photoItem.imgUrl,
                photoTitle: photoItem.title,
                id: photoItem.id,
              ),
            ));
      },
      child: ListTile(
        leading: Image.network(photoItem.thumbnailImgUrl ?? "unknown",
            fit: BoxFit.fill),
        title: Text(photoItem.title ?? ""),
      ),
    );
  }

  Future<void> _getPhotoList() async {
    _photoGalleryListInProgress = true;
    setState(() {});
    photoList.clear();
    String productUrl = "https://jsonplaceholder.typicode.com/photos";
    Uri uri = Uri.parse(productUrl);

    try {
      http.Response response =
          await http.get(uri).timeout(const Duration(seconds: 10));
      //print(response.statusCode);

      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body) as List;
        for (Map<String, dynamic> json in decodeData) {
          PhotoModel photoModel = PhotoModel.fromJson(json);
          photoList.add(photoModel);
        }
      }
    } catch (e) {
      _hasError = true;
      //print(e);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Photo Gallery Loading Failed")));
    }

    _photoGalleryListInProgress = false;
    setState(() {});
  }
}
