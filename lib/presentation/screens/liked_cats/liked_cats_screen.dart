import 'package:cats_tinder/presentation/cubits/cats_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cats_tinder/domain/entities/cat.dart';
import 'package:cats_tinder/presentation/cubits/cats_cubit.dart';

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
      appBar: AppBar(title: const Text('Liked Cats')),
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
                      : _buildCatList(filteredCats),
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
        colors: [Colors.black87, Colors.grey[900]!],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

  Widget _buildBreedFilter(List<String> breeds) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Text('Filter:', style: TextStyle(color: Colors.white)),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
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
                    child: Text(breed),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() => _selectedBreed = newValue);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool noLikes) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.favorite_border, size: 60, color: Colors.white54),
          const SizedBox(height: 20),
          Text(
            noLikes ? 'No likes yet' : 'No cats of selected breed',
            style: const TextStyle(fontSize: 24, color: Colors.white54),
          ),
        ],
      ),
    );
  }

  Widget _buildCatList(List<Cat> cats) {
    return ListView.builder(
      itemCount: cats.length,
      itemBuilder: (context, index) {
        final cat = cats[index];
        return Dismissible(
          key: Key('${cat.imageUrl}_$index'),
          background: _buildDismissibleBackground(),
          direction: DismissDirection.endToStart,
          confirmDismiss: (_) => _confirmDismiss(context),
          onDismissed: (_) => _removeCat(context, cat, index),
          child: _buildCatListItem(context, cat, index),
        );
      },
    );
  }

  Container _buildDismissibleBackground() {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      child: const Icon(Icons.delete, color: Colors.white),
    );
  }

  Future<bool?> _confirmDismiss(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm"),
        content: const Text("Delete this cat from favorites?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("CANCEL"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("DELETE"),
          ),
        ],
      ),
    );
  }

  Card _buildCatListItem(BuildContext context, Cat cat, int index) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: Colors.grey[800],
      child: ListTile(
        leading: _buildCatImage(cat),
        title: Text(cat.breed, style: const TextStyle(color: Colors.white)),
        subtitle: Text(
          'Liked on: ${cat.likedDate.toString().split(' ')[0]}',
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _removeCat(context, cat, index),
        ),
        onTap: () => _navigateToDetail(context, cat),
      ),
    );
  }

  Widget _buildCatImage(Cat cat) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          cat.imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          },
          errorBuilder: (_, __, ___) => const Center(
            child: Icon(
              Icons.pets,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _removeCat(BuildContext context, Cat cat, int index) {
    final filteredCats = _filterCats(context.read<CatsCubit>().state.likedCats);

    context.read<CatsCubit>().removeLikedCat(cat);
    _showUndoSnackbar(context, cat);
    _lastRemovedCat = cat;

    if (filteredCats.length == 1) {
      setState(() {
        _selectedBreed = null;
      });
    }
  }

  void _showUndoSnackbar(BuildContext context, Cat cat) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${cat.breed} removed from favorites'),
        duration: const Duration(seconds: 1),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            if (_lastRemovedCat != null) {
              context.read<CatsCubit>().likeCat(_lastRemovedCat!);
              setState(() => _selectedBreed = null);
            }
          },
        ),
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
