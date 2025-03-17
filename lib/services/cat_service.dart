import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/cat_model.dart';

class CatService {
  final String _baseUrl = 'https://api.thecatapi.com/v1';

  Future<List<Cat>> fetchCats() async {
    int attempts = 0;
    while (attempts < 5) {
      try {
        final response = await http.get(
          Uri.parse('$_baseUrl/images/search?limit=10&has_breeds=1'),
        );

        if (response.statusCode == 200) {
          List<dynamic> data = json.decode(response.body);
          List<Cat> cats = [];

          for (var image in data) {
            final String imageId = image['id'];
            final detailResponse = await _fetchCatDetails(imageId);

            if (detailResponse != null) {
              cats.add(detailResponse);
            }
          }

          return cats;
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error loading cats: $e');
        }
      }

      attempts++;
    }
    return [];
  }

  Future<Cat?> _fetchCatDetails(String imageId) async {
    int attempts = 0;
    while (attempts < 5) {
      try {
        final response = await http.get(
          Uri.parse('$_baseUrl/images/$imageId'),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> detailData = json.decode(response.body);
          final List<dynamic> breeds = detailData['breeds'];

          if (breeds.isNotEmpty) {
            final breed = breeds[0];
            return Cat(
              imageUrl: detailData['url'],
              breed: breed['name'],
              description: breed['description'] ?? 'No description available',
              temperament: breed['temperament'] ?? 'No temperament info',
              origin: breed['origin'] ?? 'Unknown origin',
              lifeSpan: breed['life_span'] ?? 'Unknown',
              wikipediaUrl: breed['wikipedia_url'] ?? '',
            );
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error loading cat details: $e');
        }
      }

      attempts++;
    }

    return Cat(
      imageUrl: 'https://via.placeholder.com/400',
      breed: 'Не удалось загрузить',
      description: 'Не удалось загрузить',
      temperament: 'Не удалось загрузить',
      origin: 'Не удалось загрузить',
      lifeSpan: 'Не удалось загрузить',
      wikipediaUrl: '',
    );
  }
}
