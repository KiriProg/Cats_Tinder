import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../models/cat_model.dart';
import '../services/cat_service.dart';
import 'detail_screen.dart';
import 'liked_cats_screen.dart';
import 'profile_screen.dart';
import '../widgets/like_button.dart';
import '../widgets/dislike_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CatService _catService = CatService();
  final CardSwiperController _cardSwiperController = CardSwiperController();
  final List<Cat> _cats = [];
  final List<Cat> _likedCats = [];
  int _likesCount = 0;
  int _totalSwipes = 0;

  @override
  void initState() {
    super.initState();
    _loadCats();
  }

  Future<void> _loadCats() async {
    try {
      List<Cat> cats = await _catService.fetchCats();
      setState(() {
        _cats.addAll(cats);
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error loading cats: $e');
      }
    }
  }

  void _onLike() {
    _cardSwiperController.swipe(CardSwiperDirection.right);
  }

  void _onDislike() {
    _cardSwiperController.swipe(CardSwiperDirection.left);
  }

  void _onCatTap(Cat cat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(cat: cat),
      ),
    );
  }

  void _openLikedCatsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LikedCatsScreen(likedCats: _likedCats),
      ),
    );
  }

  void _openProfileScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(
          totalSwipes: _totalSwipes,
          likedCats: _likesCount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.grey[900]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'Cats Tinder',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Pacifico',
              ),
            ),
            Expanded(
              child: _cats.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : CardSwiper(
                      controller: _cardSwiperController,
                      cardsCount: _cats.length,
                      onSwipe: _onSwipe,
                      onUndo: _onUndo,
                      numberOfCardsDisplayed: 3,
                      backCardOffset: const Offset(0, 40),
                      padding: const EdgeInsets.all(24),
                      allowedSwipeDirection: const AllowedSwipeDirection.only(
                          left: true, right: true),
                      cardBuilder: (context, index, percentThresholdX,
                          percentThresholdY) {
                        final cat = _cats[index];
                        return GestureDetector(
                          onTap: () => _onCatTap(cat),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: Colors.grey[800],
                            child: SizedBox(
                              width: screenWidth * 0.9,
                              height: screenHeight * 0.7,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Image.network(
                                      cat.imageUrl,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      cat.breed,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: screenWidth * 0.3,
                                          child: DislikeButton(
                                              onPressed: _onDislike),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.3,
                                          child: LikeButton(onPressed: _onLike),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 1, color: Colors.grey),
          BottomAppBar(
            color: Colors.grey[900],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.person, color: Colors.white, size: 40),
                  onPressed: _openProfileScreen,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite,
                          color: Colors.red, size: 40),
                      onPressed: _openLikedCatsScreen,
                    ),
                    Positioned(
                      top: 2,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '$_likesCount',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    setState(() {
      _totalSwipes++;
      if (direction == CardSwiperDirection.right) {
        _likesCount++;
        _likedCats.add(_cats[previousIndex]);
      }
    });

    if (previousIndex > 7) {
      _loadCats();
    }

    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    return true;
  }
}
