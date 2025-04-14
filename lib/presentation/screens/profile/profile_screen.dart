import 'package:cats_tinder/presentation/cubits/cats_cubit.dart';
import 'package:cats_tinder/presentation/cubits/cats_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _breedController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _breedController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus && _isEditing) {
      _saveBreed();
    }
  }

  void _saveBreed() {
    final newBreed = _breedController.text.trim();
    if (newBreed.isNotEmpty) {
      context.read<CatsCubit>().updateBreed(newBreed);
    }
    setState(() => _isEditing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocBuilder<CatsCubit, CatsState>(
        builder: (context, state) {
          return Container(
            decoration: _buildBackgroundDecoration(),
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildProfileHeader(context, state),
                  const SizedBox(height: 32),
                  _buildStatisticsSection(state),
                ],
              ),
            ),
          );
        },
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

  Widget _buildProfileHeader(BuildContext context, CatsState state) {
    return Column(
      children: [
        _buildAvatar(),
        const SizedBox(height: 16),
        _isEditing
            ? _buildBreedTextField(state)
            : _buildBreedDisplay(context, state),
      ],
    );
  }

  Widget _buildAvatar() {
    return const CircleAvatar(
      radius: 60,
      child: Icon(
        Icons.people,
        color: Colors.blueGrey,
        size: 40,
      ),
    );
  }

  Widget _buildBreedDisplay(BuildContext context, CatsState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          state.favoriteBreed,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildBreedTextField(CatsState state) {
    return SizedBox(
      width: 200,
      child: Text(
        state.favoriteBreed,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildStatisticsSection(CatsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Statistics',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        _buildStatCard(
          icon: Icons.swipe,
          title: 'Total Swipes',
          value: state.totalSwipes.toString(),
          color: Colors.blue,
        ),
        _buildStatCard(
          icon: Icons.favorite,
          title: 'Liked Cats',
          value: state.likesCount.toString(),
          color: Colors.red,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(color: Colors.white70)),
        subtitle: Text(value,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
