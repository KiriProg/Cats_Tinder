import 'package:cached_network_image/cached_network_image.dart';
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
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: BlocListener<CatsCubit, CatsState>(
        listener: (context, state) {
          _handleNetworkStatus(context, state);
          final isHomeScreen = ModalRoute.of(context)?.isCurrent ?? false;
          if (kDebugMode) {
            print("HomeScreen.build isHomeScreen: $isHomeScreen");
          }
          if (state.status == CatsStatus.error && isHomeScreen) {
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

  void _handleNetworkStatus(BuildContext context, CatsState state) {
    final messenger = _scaffoldMessengerKey.currentState;
    if (messenger == null) return;
    if (state.lastNetworkStatus == null ||
        state.networkStatus != state.lastNetworkStatus) {
      messenger.hideCurrentSnackBar();

      if (state.networkStatus == NetworkStatus.offline) {
        messenger.showSnackBar(
          _buildNetworkSnackBar(isOnline: false),
        );
      } else {
        messenger.showSnackBar(
          _buildNetworkSnackBar(isOnline: true),
        );
      }
    }
  }

  SnackBar _buildNetworkSnackBar({required bool isOnline}) {
    return SnackBar(
      content: Row(
        children: [
          Icon(
            isOnline ? Icons.wifi : Icons.wifi_off,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(isOnline ? 'Online' : 'Offline'),
        ],
      ),
      backgroundColor: isOnline ? Colors.green[600] : Colors.orange[600],
      duration: isOnline ? const Duration(seconds: 2) : const Duration(days: 1),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
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
    return SizedBox(
      width: screenSize.width * 0.9,
      height: screenSize.height * 0.7,
      child: GestureDetector(
        onTap: () => _navigateToDetail(context, cat),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          color: Colors.grey[800],
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Positioned.fill(
                child: _buildCatImage(cat),
              ),
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                        Colors.black,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 80,
                left: 0,
                right: 0,
                child: _buildCatBreed(cat),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: _buildActionButtons(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCatImage(Cat cat) {
    return CachedNetworkImage(
      imageUrl: cat.imageUrl,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
      errorWidget: (context, url, error) => const Center(
        child: Icon(Icons.error, size: 40, color: Colors.red),
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
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(
              blurRadius: 10,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          child: DislikeButton(
            onPressed: () =>
                _cardSwiperController.swipe(CardSwiperDirection.left),
          ),
        ),
        SizedBox(
          child: LikeButton(
            onPressed: () =>
                _cardSwiperController.swipe(CardSwiperDirection.right),
          ),
        ),
      ],
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
