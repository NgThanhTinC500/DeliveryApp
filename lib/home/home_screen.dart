import 'dart:async';
import 'package:DeliveryApp/baodg/cart_screen.dart';
import 'package:DeliveryApp/baodg/food_detail_screen.dart';
import 'package:DeliveryApp/nav_helper.dart';
import 'package:flutter/material.dart';
import 'package:DeliveryApp/search/search_screen.dart';
import 'package:DeliveryApp/menu/menu_screen.dart';
import 'package:DeliveryApp/offer/offer_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _carouselTimer;
  String _selectedCategory = 'BEEFSTEAK';

  final List<String> _carouselImages = [
    'https://www.shutterstock.com/image-photo/burger-special-discount-banner-blank-260nw-2408928973.jpg',
    'https://img.pikbest.com/templates/20240602/food-burger-offer-sale-restaurant-web-banner-template-design-layout_10587340.jpg!w700wp',
    'https://img.pikbest.com/templates/20240602/food-burger-offer-sale-restaurant-web-banner-design_10587343.jpg!bw700',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showOfferDialog();
      _startCarouselTimer();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _carouselTimer?.cancel();
    super.dispose();
  }

  void _startCarouselTimer() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) return;
      int nextPage = _pageController.page!.round() + 1;
      if (nextPage >= _carouselImages.length) {
        nextPage = 0;
      }
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  void _showOfferDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const OfferDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const MenuScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(-1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ));
              },
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'DELIVER TO',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              'Hotel Lab office ▼',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                context.push(CartScreen());
                // TODO: replace with navigation to cart screen, e.g.:
                // Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
              },
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.shopping_bag, color: Colors.white),
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.green, width: 1),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: const Text(
                      '2',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search dishes, restaurant',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Categories
            const Text(
              'Categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryChip(
                    label: 'BEEFSTEAK',
                    emoji: '🥩',
                    isSelected: _selectedCategory == 'BEEFSTEAK',
                    onTap: () {
                      setState(() {
                        _selectedCategory = 'BEEFSTEAK';
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  CategoryChip(
                    label: 'HOTDOG',
                    emoji: '🌭',
                    isSelected: _selectedCategory == 'HOTDOG',
                    onTap: () {
                      setState(() {
                        _selectedCategory = 'HOTDOG';
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  CategoryChip(
                    label: 'PIZZA',
                    emoji: '🍕',
                    isSelected: _selectedCategory == 'PIZZA',
                    onTap: () {
                      setState(() {
                        _selectedCategory = 'PIZZA';
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Carousel Banner
            SizedBox(
              height: 150,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemCount: _carouselImages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: NetworkImage(_carouselImages[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Near Restaurant
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Near Restaurant',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('See All >',
                      style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const RestaurantCard(),
            const SizedBox(height: 20),

            // Recommend for you
            const Text(
              'RECOMMEND FOR YOU',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: 6,
              itemBuilder: (context, index) => const RecommendedItemCard(),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final String emoji;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.emoji,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        avatar: Text(emoji, style: const TextStyle(fontSize: 18)),
        label: Text(label,
            style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold)),
        backgroundColor: isSelected ? Colors.green : Colors.grey[200],
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.2),
      child: GestureDetector(
        onTap: () {
          context.push(const FoodDetailScreen());
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/28/71/47/c2/seafood-buffet-at-mezz.jpg?w=900&h=500&s=1'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Chilli garlic restaurant',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text('Burger - Chicken - Riche - Wing',
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      Text(' 4.7',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 16),
                      Icon(Icons.delivery_dining, color: Colors.red, size: 16),
                      Text(' Free',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 16),
                      Icon(Icons.timer_outlined, color: Colors.grey, size: 16),
                      Text(' 20 min',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecommendedItemCard extends StatelessWidget {
  const RecommendedItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.push(const FoodDetailScreen());
              },
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://namviethathanh.com/wp-content/uploads/2019/05/7.C%C6%A1m-th%E1%BB%8Bt-kho-n%E1%BA%A5m-60k.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Com thit kho',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('30.000đ',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: IconButton(
                        icon: const Icon(Icons.add,
                            color: Colors.white, size: 15),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
