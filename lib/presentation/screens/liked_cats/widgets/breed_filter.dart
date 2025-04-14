import 'package:flutter/material.dart';

class BreedFilter extends StatelessWidget {
  final List<String> breeds;
  final String? selectedBreed;
  final ValueChanged<String?> onChanged;

  const BreedFilter({
    Key? key,
    required this.breeds,
    required this.selectedBreed,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Text(
            'Filter:',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButton<String>(
                value: selectedBreed,
                underline: Container(),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                dropdownColor: Colors.grey[900],
                style: const TextStyle(color: Colors.white),
                isExpanded: true,
                items: breeds.map((String breed) {
                  return DropdownMenuItem<String>(
                    value: breed,
                    child: Text(breed),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
