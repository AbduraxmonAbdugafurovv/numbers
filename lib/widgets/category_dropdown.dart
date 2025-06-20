import 'package:flutter/material.dart';

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({super.key});

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();

  static String? selectedCategory;
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  final List<String> _categories = ['math', 'trivia', 'date', 'year'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: CategoryDropdown.selectedCategory,
          hint: const Text('Kategoriya tanlang'),
          isExpanded: true,
          items: _categories.map((category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(
                category.toUpperCase(),
                style: const TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              CategoryDropdown.selectedCategory = newValue!;
            });
          },
        ),
      ),
    );
  }
}
