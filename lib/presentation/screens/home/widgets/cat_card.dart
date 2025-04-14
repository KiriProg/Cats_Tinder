import 'package:cats_tinder/domain/entities/cat.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CatCard extends StatelessWidget {
  final Cat cat;
  final VoidCallback onTap;
  final double width;
  final double height;

  const CatCard({
    Key? key,
    required this.cat,
    required this.onTap,
    this.width = double.infinity,
    this.height = 400,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.grey[800],
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildImage(),
              _buildBreed(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Expanded(
      flex: 3,
      child: CachedNetworkImage(
        imageUrl: cat.imageUrl,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        errorWidget: (context, url, error) => const Center(
          child: Icon(
            Icons.pets,
            size: 60,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildBreed() {
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
}
