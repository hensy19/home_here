import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OwnerPhotoGalleryPage extends StatefulWidget {
  final String propertyId;
  const OwnerPhotoGalleryPage({super.key, required this.propertyId});

  @override
  _OwnerPhotoGalleryPageState createState() => _OwnerPhotoGalleryPageState();
}

class _OwnerPhotoGalleryPageState extends State<OwnerPhotoGalleryPage> {
  List<String> photos = [
    'https://picsum.photos/300/200?random=1',
    'https://picsum.photos/300/200?random=2',
    'https://picsum.photos/300/200?random=3',
  ];

  final ImagePicker _picker = ImagePicker();

  Future<void> _addPhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        photos.add(image.path); // local path for demo
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Photo added successfully'), backgroundColor: Colors.green),
      );
    }
  }

  void _deletePhoto(int index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Photo'),
        content: Text('Are you sure you want to delete this photo?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text('No')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Yes')),
        ],
      ),
    );

    if (confirm ?? false) {
      setState(() {
        photos.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Photo deleted'), backgroundColor: Colors.red),
      );
    }
  }

  void _viewPhoto(String photo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PhotoPreviewPage(photo: photo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Photos'),
        centerTitle: true,
      ),
      body: photos.isEmpty
          ? Center(
              child: Text('No photos added yet', style: TextStyle(fontSize: 16)),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: photos.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  final photo = photos[index];
                  return GestureDetector(
                    onTap: () => _viewPhoto(photo),
                    child: Stack(
                      children: [
                        Hero(
                          tag: photo,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                              image: DecorationImage(
                                image: photo.startsWith('http')
                                    ? NetworkImage(photo)
                                    : FileImage(File(photo)) as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: CircleAvatar(
                            backgroundColor: Colors.black54,
                            child: IconButton(
                              icon: Icon(Icons.delete, color: Colors.white, size: 20),
                              onPressed: () => _deletePhoto(index),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPhoto,
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add_a_photo, size: 28),
      ),
    );
  }
}

// Fullscreen photo preview page with Hero animation
class PhotoPreviewPage extends StatelessWidget {
  final String photo;
  const PhotoPreviewPage({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: photo,
            child: photo.startsWith('http')
                ? Image.network(photo, fit: BoxFit.contain)
                : Image.file(File(photo), fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
