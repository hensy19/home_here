import 'package:flutter/material.dart';
import 'add_property_page1.dart';
import 'edit_property_page.dart';

class PropertiesPage extends StatefulWidget {
  static const routeName = '/properties';

  @override
  _PropertiesPageState createState() => _PropertiesPageState();
}

class _PropertiesPageState extends State<PropertiesPage> {
  List<Map<String, String>> properties = [
    {
      'name': 'Celestia Living Girls Hostel',
      'type': 'Hostel',
      'location': 'Navrangpura, Ahmedabad — 2.5 km',
      'rating': '4.5 (128 reviews)',
      'description': 'Comfortable hostel for girls.',
      'rules': 'No loud music after 10 PM',
      'city': 'Ahmedabad',
      'state': 'Gujarat',
      'pin': '380009',
      'image': 'https://picsum.photos/200/140?random=1'
    },
    {
      'name': 'Shivangi Girls Hostel',
      'type': 'Hostel',
      'location': 'Vastrapur, Ahmedabad — 3 km',
      'rating': '4.2 (98 reviews)',
      'description': 'Safe and secure girls hostel.',
      'rules': 'No visitors after 9 PM',
      'city': 'Ahmedabad',
      'state': 'Gujarat',
      'pin': '380015',
      'image': 'https://picsum.photos/200/140?random=2'
    },
  ];

  List<Map<String, String>> filteredProperties = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProperties = List.from(properties);
    searchController.addListener(_searchProperties);
  }

  void _searchProperties() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredProperties = properties.where((p) {
        return p['name']!.toLowerCase().contains(query) ||
            p['location']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> _navigateToAddProperty() async {
    final newProperty =
        await Navigator.pushNamed(context, AddPropertyPage1.routeName);
    if (newProperty != null && newProperty is Map<String, String>) {
      setState(() {
        properties.add(newProperty);
        filteredProperties = List.from(properties);
      });
    }
  }

  Future<void> _navigateToEditProperty(Map<String, String> property, int index) async {
    final updatedProperty = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditPropertyPage(property: Map.from(property)),
      ),
    );
    if (updatedProperty != null && updatedProperty is Map<String, String>) {
      setState(() {
        properties[index] = updatedProperty;
        filteredProperties = List.from(properties);
      });
    }
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Delete Property'),
        content: Text('Are you sure you want to delete this property?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                properties.removeAt(index);
                filteredProperties = List.from(properties);
              });
              Navigator.pop(context);
            },
            child: Text('Delete'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Properties', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search properties by Name or Location',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: filteredProperties.isEmpty
                  ? Center(child: Text('No properties found'))
                  : ListView.builder(
                      itemCount: filteredProperties.length,
                      itemBuilder: (ctx, i) {
                        final p = filteredProperties[i];
                        final index = properties.indexOf(p);
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          margin: EdgeInsets.symmetric(vertical: 8),
                          elevation: 2,
                          child: ListTile(
                            contentPadding: EdgeInsets.all(12),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                p['image']!,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(p['name']!,
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(p['location']!,
                                      style: TextStyle(color: Colors.grey[600])),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.star,
                                          size: 16, color: Colors.orange),
                                      SizedBox(width: 4),
                                      Text(p['rating']!,
                                          style:
                                              TextStyle(color: Colors.grey[700])),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            trailing: PopupMenuButton(
                              onSelected: (value) {
                                if (value == 'edit') {
                                  _navigateToEditProperty(p, index);
                                } else if (value == 'delete') {
                                  _confirmDelete(index);
                                }
                              },
                              itemBuilder: (_) => [
                                PopupMenuItem(
                                  value: 'edit',
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit, color: Color(0xFF004AAD)),
                                      SizedBox(width: 8),
                                      Text('Edit'),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete, color: Colors.red),
                                      SizedBox(width: 8),
                                      Text('Delete'),
                                    ],
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
        ),
      ),
      floatingActionButton: ElevatedButton.icon(
        onPressed: _navigateToAddProperty,
        icon: Icon(Icons.add),
        label: Text('Add'),
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          backgroundColor: Color(0xFF004AAD),
          foregroundColor: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
