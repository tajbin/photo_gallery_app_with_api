import 'package:flutter/material.dart';

class PhotoDetailsScreen extends StatefulWidget {
  final String? photoUrl;
  final String? photoTitle;
  final int? id;
  const PhotoDetailsScreen(
      {super.key,
      required this.photoUrl,
      required this.photoTitle,
      required this.id});

  @override
  State<PhotoDetailsScreen> createState() => _PhotoDetailsScreenState();
}

class _PhotoDetailsScreenState extends State<PhotoDetailsScreen> {
  final bool _photoDetailsInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Visibility(
            visible: _photoDetailsInProgress == false,
            replacement: const Center(child: CircularProgressIndicator()),
            child: Column(
              children: [
                Image.network(
                  widget.photoUrl ?? "",
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(widget.photoTitle ?? ""),
                const SizedBox(
                  height: 10,
                ),
                Text("ID: ${widget.id.toString()}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
