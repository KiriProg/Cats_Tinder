import 'package:flutter/material.dart';
import '../models/cat_model.dart';
import 'detail_screen.dart';

class LikedCatsScreen extends StatelessWidget {
  final List<Cat> likedCats;

  const LikedCatsScreen({Key? key, required this.likedCats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Cats'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.grey[900]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: likedCats.length,
          itemBuilder: (context, index) {
            final cat = likedCats[index];
            return Card(
              margin: const EdgeInsets.all(8),
              color: Colors.grey[800],
              child: ListTile(
                leading: Image.network(
                  cat.imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  cat.breed,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(cat: cat),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
