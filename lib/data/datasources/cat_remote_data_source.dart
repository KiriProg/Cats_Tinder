import 'dart:convert';
import 'package:cats_tinder/domain/entities/cat.dart';
import 'package:http/http.dart' as http;

class CatRemoteDataSource {
  static const _baseUrl = 'https://api.thecatapi.com/v1';
  final http.Client client;

  CatRemoteDataSource(this.client);

  Future<List<Map<String, dynamic>>> fetchCatImages() async {
    final response = await client.get(
      Uri.parse('$_baseUrl/images/search?limit=10&has_breeds=1'),
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    }
    throw Exception('Failed to load cat images: ${response.statusCode}');
  }

  Future<Map<String, dynamic>> fetchCatDetails(String imageId) async {
    final response = await client.get(
      Uri.parse('$_baseUrl/images/$imageId'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['breeds'] is List && (data['breeds'] as List).isEmpty) {
        throw Exception('No breed info available');
      }
      return data;
    }
    throw Exception('Failed to load cat details: ${response.statusCode}');
  }

  Future<Cat> fetchFullCatInfo(String imageId) async {
    try {
      final details = await fetchCatDetails(imageId);
      return _parseCatDetails(details);
    } catch (e) {
      return Cat(
        imageUrl: 'https://via.placeholder.com/400',
        breed: 'Unknown Breed',
        description: 'No description available',
        temperament: 'No data',
        origin: 'Unknown',
        lifeSpan: 'Unknown',
        wikipediaUrl: '',
      );
    }
  }

  Cat _parseCatDetails(Map<String, dynamic> details) {
    final breeds = details['breeds'] as List;
    final breed = breeds.isNotEmpty ? breeds[0] : {};

    return Cat(
      imageUrl: details['url'] ?? '',
      breed: breed['name'] ?? 'Unknown',
      description: breed['description'] ?? 'No description',
      temperament: breed['temperament'] ?? 'No data',
      origin: breed['origin'] ?? 'Unknown',
      lifeSpan: breed['life_span'] ?? 'Unknown',
      wikipediaUrl: breed['wikipedia_url'] ?? '',
    );
  }
}
