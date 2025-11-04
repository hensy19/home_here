import 'package:flutter/material.dart';
import 'owner_photo_gallery.dart';

class EditPropertyPage extends StatefulWidget {
  final Map<String, String> property;

  const EditPropertyPage({super.key, required this.property});

  @override
  _EditPropertyPageState createState() => _EditPropertyPageState();
}

class _EditPropertyPageState extends State<EditPropertyPage> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String type;
  late String description;
  late String rules;
  late String city;
  late String stateName;
  late String pin;

  List<Map<String, String>> reviews = [
    {'user': 'Mina Sharma', 'comment': 'Nice property!', 'id': '1'},
    {'user': 'Piya Tandel', 'comment': 'Very clean.', 'id': '2'},
    {'user': 'Fairy Patel', 'comment': 'Loved the stay!', 'id': '3'},
    {'user': 'Tej Patel', 'comment': 'Great location.', 'id': '4'},
  ];

  @override
  void initState() {
    super.initState();
    name = widget.property['name'] ?? '';
    type = widget.property['type'] ?? 'Hostel';
    description = widget.property['description'] ?? '';
    rules = widget.property['rules'] ?? '';
    city = widget.property['city'] ?? '';
    stateName = widget.property['state'] ?? '';
    pin = widget.property['pin'] ?? '';
  }

  void _saveProperty() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final updatedProperty = {
        'name': name,
        'type': type,
        'description': description,
        'rules': rules,
        'city': city,
        'state': stateName,
        'pin': pin,
        'location': '$city, $stateName — 0 km',
        'rating': widget.property['rating'] ?? 'New',
        'image': widget.property['image'] ?? 'https://picsum.photos/200/140?random=5',
      };

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Expanded(child: Text('Edited Successfully!')),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: Duration(seconds: 2),
        ),
      );

      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.pop(context, updatedProperty);
      });
    }
  }

  void _deleteReview(String id) {
    setState(() {
      reviews.removeWhere((r) => r['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Review deleted'), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Property'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 90),
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  // --- Basic Info ---
                  Text('Basic Information',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  TextFormField(
                    initialValue: name,
                    decoration: InputDecoration(
                      labelText: 'Property Name *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSaved: (v) => name = v ?? '',
                    validator: (v) => v == null || v.isEmpty ? 'Enter name' : null,
                  ),
                  SizedBox(height: 16),
                  Text('Property Type *', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 11),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: ['Hostel', 'Flat', 'PG'].map((t) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio<String>(
                            value: t,
                            groupValue: type,
                            onChanged: (v) => setState(() => type = v!),
                            activeColor: Colors.blueAccent,
                          ),
                          SizedBox(width: 8),
                          Text(t),
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    initialValue: description,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSaved: (v) => description = v ?? '',
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    initialValue: rules,
                    decoration: InputDecoration(
                      labelText: 'House Rules',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSaved: (v) => rules = v ?? '',
                  ),
                  SizedBox(height: 16),
                  Text('Location', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  TextFormField(
                    initialValue: city,
                    decoration: InputDecoration(
                      labelText: 'City *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSaved: (v) => city = v ?? '',
                    validator: (v) => v == null || v.isEmpty ? 'Enter city' : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    initialValue: stateName,
                    decoration: InputDecoration(
                      labelText: 'State *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSaved: (v) => stateName = v ?? '',
                    validator: (v) => v == null || v.isEmpty ? 'Enter state' : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    initialValue: pin,
                    decoration: InputDecoration(
                      labelText: 'PIN code *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSaved: (v) => pin = v ?? '',
                    validator: (v) => v == null || v.isEmpty ? 'Enter PIN code' : null,
                  ),
                  SizedBox(height: 32),

                  // --- Reviews ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Reviews',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      reviews.isNotEmpty
                          ? TextButton(
                              onPressed: () => setState(() => reviews.clear()),
                              child: Text('Delete All'),
                            )
                          : SizedBox(),
                    ],
                  ),
                  reviews.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            'No reviews yet',
                            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                          ),
                        )
                      : Column(
                          children: reviews.map((r) {
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 6),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                title: Text(r['user']!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 16)),
                                subtitle: Text(r['comment']!, style: TextStyle(fontSize: 15)),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _deleteReview(r['id']!),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                  SizedBox(height: 24),

                  // --- Photo Gallery ---
                  Text('Property Photos',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  ElevatedButton.icon(
                    icon: Icon(Icons.photo_library, color: const Color(0xFF1976D2)),
                    label: Text('Manage Photos', style: TextStyle(color: const Color(0xFF1976D2))),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 240, 243, 252),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      elevation: 4,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OwnerPhotoGalleryPage(
                              propertyId: widget.property['id'] ?? '0'),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),

            // --- Save Button fixed at bottom with attractive look ---
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: ElevatedButton(
                onPressed: _saveProperty,
                child: Text('Save Changes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: const Color(0xFF1976D2),
                  elevation: 6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
