import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final int totalSwipes;
  final int likedCats;

  const ProfileScreen(
      {Key? key, required this.totalSwipes, required this.likedCats})
      : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _breed = 'Your Breed';
  bool _isEditingBreed = false;
  final TextEditingController _breedController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadBreed();
  }

  @override
  void dispose() {
    _breedController.dispose();
    super.dispose();
  }

  Future<void> _loadBreed() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _breed = prefs.getString('breed') ?? 'Your Breed';
      _breedController.text = _breed;
    });
  }

  Future<void> _saveBreed(String newBreed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('breed', newBreed);
    setState(() {
      _breed = newBreed;
      _isEditingBreed = false;
    });
  }

  void _editBreed() {
    setState(() {
      _isEditingBreed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.grey[900]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/default_avatar.png'),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isEditingBreed)
                      Expanded(
                        child: TextField(
                          controller: _breedController,
                          onSubmitted: _saveBreed,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      )
                    else
                      Text(
                        _breed,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    IconButton(
                      icon:
                          const Icon(Icons.edit, color: Colors.white, size: 24),
                      onPressed: _editBreed,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Total Swipes: ${widget.totalSwipes}',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                'Liked Cats: ${widget.likedCats}',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
