import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined, size: 30, color: Colors.black),
                onPressed: () {
                  // Handle shopping bag tap
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    '2', // Example cart item count
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Pizz',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.clear),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Recent Keywords
            const Text(
              'Recent Keywords',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: const [
                Chip(label: Text('Burger')),
                Chip(label: Text('Pizza')),
                Chip(label: Text('Sushi')),
                Chip(label: Text('Sushi')), // Duplicated as in image
              ],
            ),
            const SizedBox(height: 20),

            // Suggested Restaurants
            const Text(
              'Suggested Restaurants',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) => const RestaurantListItem(),
            ),
            const SizedBox(height: 20),

            // Suggested Food Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                // Alternate between the two pizza images
                final imageName = (index % 2 == 0) ? 'pizza1.png' : 'pizza2.png';
                return FoodItemCard(imageName: imageName);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantListItem extends StatelessWidget {
  const RestaurantListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network('https://neworienthoteldanang.com/wp-content/uploads/2023/12/Bistecca-12-scaled.jpg', width: 60, height: 60, fit: BoxFit.cover), // Placeholder
      title: const Text('Pancos Restaurant'),
      subtitle: Row(
        children: const [
          Icon(Icons.star, color: Colors.red, size: 16),
          Text(' 4.7'),
        ],
      ),
      onTap: () {},
    );
  }
}

class FoodItemCard extends StatelessWidget {
  final String imageName;
  const FoodItemCard({super.key, required this.imageName});

  @override
  Widget build(BuildContext context) {
    // This is a simplified version of the card in the image
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                image: DecorationImage(
                  image: AssetImage('lib/search/$imageName'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Buffalo, Pizza', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Cafeino Coffee Club', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
