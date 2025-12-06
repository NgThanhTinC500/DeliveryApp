import 'package:DeliveryApp/nav_helper.dart';
import 'package:flutter/material.dart';

// --- Data Model ---
class Review {
  final String date;
  final String title;
  final int rating;
  final String comment;
  final String avatarUrl;

  Review({
    required this.date,
    required this.title,
    required this.rating,
    required this.comment,
    required this.avatarUrl,
  });
}

// --- Main Screen ---
class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data matching the screenshot
    final List<Review> reviews = [
      Review(
        date: '10/10/2025',
        title: 'Great Food and Service',
        rating: 5,
        comment: 'This dish is absolutely delicious. Breakfast delivered to your home. The chef is very friendly. I really like the chef of Home Food Order. Thank.',
        avatarUrl: 'assets/avatar_1.png', 
      ),
      Review(
        date: '10/10/2025',
        title: 'Great Food and Service',
        rating: 5,
        comment: 'The breakfast delivered to my door was fresh and hot. I was particularly impressed with the taste of the food, truly home cooked!',
        avatarUrl: 'assets/avatar_2.png',
      ),
      Review(
        date: '10/10/2025',
        title: 'Great Food and Service',
        rating: 5,
        comment: 'The breakfast was amazing, truly like home cooked food. The delivery service was convenient. I really liked the chef!',
        avatarUrl: 'assets/avatar_3.png',
      ),
      Review(
        date: '10/10/2025',
        title: 'Great Food and Service',
        rating: 4,
        comment: 'Super satisfied! Home Food Order chef was extremely friendly. Food was delicious and excellent. Many thanks.',
        avatarUrl: 'assets/avatar_4.png',
      ),
       Review(
        date: '10/10/2025',
        title: 'Great Food and Service',
        rating: 5,
        comment: 'This dish is absolutely delicious. Breakfast delivered to your home. The chef is very friendly.',
        avatarUrl: 'assets/avatar_5.png',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          width: 48,
          height: 48,
          margin: const EdgeInsets.only(left: 16.0),
          decoration: const BoxDecoration(
            color: Color(0xFFF0F4F9), // Light grey circle
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.black, size: 24),
            padding: EdgeInsets.zero,
            onPressed: () => context.pop(),
          ),
        ),
        title: const Text(
          'User review',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(24.0),
          itemCount: reviews.length,
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            return _ReviewItem(review: reviews[index]);
          },
        ),
      ),
    );
  }
}

// --- Component: Single Review Item ---
class _ReviewItem extends StatelessWidget {
  final Review review;

  const _ReviewItem({required this.review});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Avatar (Outside the card)
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(review.avatarUrl),
              fit: BoxFit.cover,
            ),
            // Fallback color/icon if image fails
            color: Colors.grey[200],
          ),
          child: review.avatarUrl.isEmpty 
             ? const Icon(Icons.person, color: Colors.grey) 
             : null,
        ),
        
        const SizedBox(width: 16),

        // 2. Review Content Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F8FA), // Light grey/blue background
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date
                Text(
                  review.date,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),

                // Title
                Text(
                  review.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),

                // Star Rating
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: Icon(
                        index < review.rating ? Icons.star : Icons.star_border,
                        color: const Color(0xFFFFB800), // Amber/Orange
                        size: 20,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),

                // Comment
                Text(
                  review.comment,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                    height: 1.4, // Line height for readability
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}