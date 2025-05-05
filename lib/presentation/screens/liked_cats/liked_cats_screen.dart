import 'package:cached_network_image/cached_network_image.dart';
import 'package:cats_tinder/presentation/cubits/cats_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cats_tinder/domain/entities/cat.dart';
import 'package:cats_tinder/presentation/cubits/cats_cubit.dart';
import 'package:intl/intl.dart';

class LikedCatsScreen extends StatefulWidget {
  const LikedCatsScreen({Key? key}) : super(key: key);

  @override
  _LikedCatsScreenState createState() => _LikedCatsScreenState();
}

class _LikedCatsScreenState extends State<LikedCatsScreen> {
  String? _selectedBreed;
  Cat? _lastRemovedCat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[900],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: _buildBackgroundDecoration(),
        child: BlocBuilder<CatsCubit, CatsState>(
          builder: (context, state) {
            final breeds = _getAvailableBreeds(state.likedCats);
            final filteredCats = _filterCats(state.likedCats);

            return Column(
              children: [
                if (breeds.length > 1) _buildBreedFilter(breeds),
                Expanded(
                  child: filteredCats.isEmpty
                      ? _buildEmptyState(state.likedCats.isEmpty)
                      : _buildCatGrid(filteredCats),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  BoxDecoration _buildBackgroundDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey[850]!, Colors.grey[900]!],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

  Widget _buildBreedFilter(List<String> breeds) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[700]!),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: DropdownButton<String>(
          value: _selectedBreed ?? "All breeds",
          underline: Container(),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          dropdownColor: Colors.grey[900],
          style: const TextStyle(color: Colors.white),
          isExpanded: true,
          items: breeds.map((breed) {
            return DropdownMenuItem(
              value: breed,
              child: Text(breed, style: const TextStyle(fontSize: 16)),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() => _selectedBreed = newValue);
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool noLikes) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 60, color: Colors.grey[600]),
          const SizedBox(height: 20),
          Text(
            noLikes ? 'No favorites yet' : 'No cats of selected breed',
            style: TextStyle(fontSize: 24, color: Colors.grey[500]),
          ),
          const SizedBox(height: 10),
          Text(
            noLikes
                ? 'Swipe right on cats to add them here'
                : 'Try another breed filter',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildCatGrid(List<Cat> cats) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.8,
        ),
        itemCount: cats.length,
        itemBuilder: (context, index) {
          final cat = cats[index];
          return _buildCatCard(context, cat, index);
        },
      ),
    );
  }

  Widget _buildCatCard(BuildContext context, Cat cat, int index) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context, cat),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        color: Colors.grey[800],
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: CachedNetworkImage(
                      imageUrl: cat.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[700],
                        child: const Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[700],
                        child: const Icon(Icons.pets,
                            size: 40, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cat.breed,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('MMM d, y').format(cat.likedDate!),
                        style: TextStyle(color: Colors.grey[400], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 6,
              right: 6,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.heart_broken,
                      size: 25, color: Colors.white),
                  onPressed: () => _removeCat(context, cat, index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _confirmDismiss(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[800],
        title: const Text("Remove from favorites?",
            style: TextStyle(color: Colors.white)),
        content: const Text("This cat will be removed from your favorites.",
            style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child:
                const Text("CANCEL", style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("REMOVE", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _removeCat(BuildContext context, Cat cat, int index) async {
    final confirmed = await _confirmDismiss(context);
    if (confirmed == true) {
      try {
        final filteredCats =
            _filterCats(context.read<CatsCubit>().state.likedCats);
        context.read<CatsCubit>().removeLikedCat(cat);
        _showUndoSnackbar(context, cat);
        _lastRemovedCat = cat;

        if (filteredCats.length == 1) {
          setState(() {
            _selectedBreed = null;
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  void _showUndoSnackbar(BuildContext context, Cat cat) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${cat.breed} removed'),
        duration: const Duration(seconds: 1),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.blueAccent,
          onPressed: () {
            if (_lastRemovedCat != null) {
              context.read<CatsCubit>().likeCat(_lastRemovedCat!);
              setState(() => _selectedBreed = null);
            }
          },
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Colors.grey[800],
      ),
    );
  }

  List<String> _getAvailableBreeds(List<Cat> cats) {
    final breeds = cats.map((cat) => cat.breed).toSet().toList();
    breeds.insert(0, 'All breeds');
    return breeds;
  }

  List<Cat> _filterCats(List<Cat> cats) {
    if (_selectedBreed == null || _selectedBreed == 'All breeds') {
      return cats;
    }

    final filtered = cats.where((cat) => cat.breed == _selectedBreed).toList();

    if (filtered.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _selectedBreed = null;
          });
        }
      });
      return cats;
    }

    return filtered;
  }

  void _navigateToDetail(BuildContext context, Cat cat) {
    Navigator.pushNamed(context, '/detail', arguments: cat);
  }
}
