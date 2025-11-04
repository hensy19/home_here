import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'gallery_page.dart';
import 'reserve_page.dart';
import 'review_page.dart';

class DetailsPage extends StatelessWidget {
  final Map<String, String> hostelData;

  const DetailsPage({super.key, required this.hostelData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Image with back button + badge
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    child: _buildImage(hostelData["image"]!),
                  ),
                  // Back button
                  Positioned(
                    top: 10,
                    left: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  // Gallery Icon
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.photo_library, color: Color(0xFF1976D2)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => GalleryPage(
                                images: [hostelData["image"]!],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Category Badge (moved lower to avoid overlap with gallery icon)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1976D2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _getCategoryFromName(hostelData["name"]!),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hostel Title + Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            hostelData["name"]!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          hostelData["price"]!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1976D2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Location + Rating
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          hostelData["location"]!,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const Spacer(),
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 2),
                        Text(
                          hostelData["reviews"] ?? "No reviews",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // About Section
                    const Text(
                      "About",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      hostelData["description"] ?? "No description available.",
                      style: const TextStyle(color: Colors.black87, height: 1.4),
                    ),

                    const SizedBox(height: 20),

                    // Reviews Section
                    const Text(
                      "Reviews (3)",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),

                    _buildReview(
                      name: "Priya Sharma",
                      time: "2 weeks ago",
                      review:
                          "Amazing place! Very clean and the owner is super helpful. Would definitely recommend to other students.",
                    ),
                    const SizedBox(height: 10),
                    _buildReview(
                      name: "Sneha Patel",
                      time: "4 weeks ago",
                      review:
                          "Good location near universities. WiFi is excellent and food quality is nice.",
                    ),
                    const SizedBox(height: 10),
                    _buildReview(
                      name: "Rahul Kumar",
                      time: "4 weeks ago",
                      review:
                          "Comfortable stay with good amenities. The common area is well maintained.",
                    ),

                    const SizedBox(height: 10),

                    // Write a review button
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: Color(0xFF1976D2)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ReviewPage()),
                        );
                      },
                      icon: const Icon(Icons.edit, color: Color(0xFF1976D2)),
                      label: const Text(
                        "Write a review",
                        style: TextStyle(color: Color(0xFF1976D2)),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Contact Owner Section
                    const Text(
                      "Contact Owner",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              CircleAvatar(
                                backgroundColor: Color(0xFF1976D2),
                                child: Text(
                                  "MR",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Mr. Suresh Reddy",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              Text(
                                "Property Owner",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: const [
                              Icon(Icons.call, size: 20, color: Colors.black87),
                              SizedBox(width: 6),
                              Text("+91 98765 43210"),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Image.asset(
                                'assets/whatsapp.png',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(width: 6),
                              const Text("+91 98765 43210"),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1976D2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ReservePage(hostelData: hostelData),
                                ),
                              );
                            },
                            child: const Center(
                              child: Text(
                                "Request for Visit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // House Rules
                    const Text(
                      "House Rules",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text("• Check-in: 10:00 AM – 6:00 PM"),
                    const Text("• Visitors allowed until 8:00 PM"),
                    const Text("• No smoking inside premises"),
                    const Text("• Maintain cleanliness in common areas"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Helper to decide category from name
  String _getCategoryFromName(String name) {
    final lower = name.toLowerCase();
    if (lower.contains("pg")) return "PG";
    if (lower.contains("hostel")) return "Hostel";
    if (lower.contains("flat")) return "Flat";
    return "Stay";
  }

  // 🔹 Review Card Widget
  Widget _buildReview({
    required String name,
    required String time,
    required String review,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(name[0], style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
                  const Spacer(),
                  Text(time, style: const TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: List.generate(
                  5,
                  (index) => const Icon(Icons.star, size: 16, color: Colors.amber),
                ),
              ),
              const SizedBox(height: 4),
              Text(review),
            ],
          ),
        ),
      ],
    );
  }

  // 🔹 Helper to handle network/local images
  Widget _buildImage(String url) {
    if (url.startsWith("http")) {
      return CachedNetworkImage(
        imageUrl: url,
        width: double.infinity,
        height: 220,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            Container(width: double.infinity, height: 220, color: Colors.grey[300]),
        errorWidget: (context, url, error) =>
            Container(
              width: double.infinity,
              height: 220,
              color: Colors.grey[300],
              child: const Icon(Icons.image_not_supported),
            ),
      );
    } else {
      return Image.asset(
        url,
        width: double.infinity,
        height: 220,
        fit: BoxFit.cover,
      );
    }
  }
}
