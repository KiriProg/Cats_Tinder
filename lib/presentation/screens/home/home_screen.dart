import 'package:cats_tinder/presentation/cubits/cats_state.dart';
import 'package:cats_tinder/presentation/widgets/dialogs/error_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:cats_tinder/domain/entities/cat.dart';
import 'package:cats_tinder/presentation/cubits/cats_cubit.dart';
import 'package:cats_tinder/presentation/widgets/buttons/like_button.dart';
import 'package:cats_tinder/presentation/widgets/buttons/dislike_button.dart';

class HomeScreen extends StatelessWidget {
  final CardSwiperController _cardSwiperController = CardSwiperController();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocListener<CatsCubit, CatsState>(
      listener: (context, state) {
        if (state.status == CatsStatus.error) {
          showNetworkErrorDialog(
            context: context,
            onRetry: () => context.read<CatsCubit>().loadCats(isRetry: true),
          );
        }
      },
      child: Scaffold(
        body: Container(
          decoration: _buildBackgroundDecoration(),
          child: Column(
            children: [
              const _AppTitle(),
              Expanded(
                child: BlocBuilder<CatsCubit, CatsState>(
                  builder: (context, state) {
                    if (state.status == CatsStatus.loading &&
                        state.cats.isEmpty) {
                      return _buildLoader();
                    }

                    if (kDebugMode) {
                      print(state.status);
                    }
                    if (state.status == CatsStatus.error &&
                        state.cats.isEmpty) {
                      return _buildErrorPlaceholder(context);
                    }

                    if (kDebugMode) {
                      print(state.cats);
                    }
                    if (state.cats.isEmpty) {
                      return _buildNoCatsPlaceholder(context);
                    }

                    return _buildCardSwiper(context, state, screenSize);
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavBar(context),
      ),
    );
  }

  Widget _buildNoCatsPlaceholder(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.pets, size: 60, color: Colors.white),
          const SizedBox(height: 20),
          const Text(
            'No cats available',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.read<CatsCubit>().loadCats(isRetry: true),
            child: const Text('Load Cats'),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildBackgroundDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.black87, Colors.grey[900]!],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

  Widget _buildLoader() {
    return Center(
      child: SizedBox(
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              backgroundColor: Colors.grey[800],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 8,
            ),
            const SizedBox(height: 20),
            const Text(
              'Loading cute cats...',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardSwiper(
      BuildContext context, CatsState state, Size screenSize) {
    if (state.cats.isEmpty) {
      return _buildNoCatsPlaceholder(context);
    }

    return CardSwiper(
      controller: _cardSwiperController,
      cardsCount: state.cats.length,
      onSwipe: (previousIndex, currentIndex, direction) =>
          _onSwipe(previousIndex, currentIndex, direction, context),
      numberOfCardsDisplayed: 3,
      backCardOffset: const Offset(0, 40),
      padding: const EdgeInsets.all(24),
      allowedSwipeDirection:
          const AllowedSwipeDirection.only(left: true, right: true),
      cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
        return _buildCatCard(context, state.cats[index], screenSize);
      },
    );
  }

  Widget _buildCatCard(BuildContext context, Cat cat, Size screenSize) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context, cat),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.grey[800],
        child: SizedBox(
          width: screenSize.width * 0.9,
          height: screenSize.height * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCatImage(cat),
              _buildCatBreed(cat),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCatImage(Cat cat) {
    return Expanded(
      flex: 3,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            cat.imageUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Center(
              child: Icon(
                Icons.error,
                size: 40,
                color: Colors.red,
              ),
            ),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildErrorPlaceholder(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 60, color: Colors.red),
          const SizedBox(height: 20),
          const Text(
            'Failed to load cats',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.read<CatsCubit>().loadCats(isRetry: true),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildCatBreed(Cat cat) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        cat.breed,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 120,
            child: DislikeButton(
              onPressed: () =>
                  _cardSwiperController.swipe(CardSwiperDirection.left),
            ),
          ),
          SizedBox(
            width: 120,
            child: LikeButton(
              onPressed: () =>
                  _cardSwiperController.swipe(CardSwiperDirection.right),
            ),
          ),
        ],
      ),
    );
  }

  BottomAppBar _buildBottomNavBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.grey[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.person, size: 40, color: Colors.white),
            onPressed: () => _navigateToProfile(context),
          ),
          BlocBuilder<CatsCubit, CatsState>(
            builder: (context, state) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon:
                        const Icon(Icons.favorite, size: 40, color: Colors.red),
                    onPressed: () => _navigateToLikedCats(context),
                  ),
                  if (state.likesCount > 0) _buildLikeCounter(state),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLikeCounter(CatsState state) {
    return Positioned(
      top: 2,
      right: 4,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          '${state.likesCount}',
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  bool _onSwipe(int previousIndex, int? currentIndex,
      CardSwiperDirection direction, BuildContext context) {
    final cubit = BlocProvider.of<CatsCubit>(context);
    cubit.swipeCat(direction, previousIndex);
    return true;
  }

  void _navigateToDetail(BuildContext context, Cat cat) {
    Navigator.pushNamed(context, '/detail', arguments: cat);
  }

  void _navigateToLikedCats(BuildContext context) {
    Navigator.pushNamed(context, '/liked');
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.pushNamed(context, '/profile');
  }
}

class _AppTitle extends StatelessWidget {
  const _AppTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 40),
      child: Text(
        'Cats Tinder',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Pacifico',
        ),
      ),
    );
  }
}
