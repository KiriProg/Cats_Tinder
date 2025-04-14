import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cats_tinder/domain/entities/cat.dart';

class CatListTile extends StatelessWidget {
  final Cat cat;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const CatListTile({
    Key? key,
    required this.cat,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: Colors.grey[800],
      child: ListTile(
        leading: _buildCatImage(),
        title: Text(
          cat.breed,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          'Liked on: ${cat.likedDate.toString().split(' ')[0]}',
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildCatImage() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: cat.imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          errorWidget: (context, url, error) => const Center(
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
}
