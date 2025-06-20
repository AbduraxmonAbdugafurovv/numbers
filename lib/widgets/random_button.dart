import 'package:flutter/material.dart';
import '../service/api_service.dart';

class RandomButtons extends StatelessWidget {
  const RandomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              _button(context, name: "random/trivia", category: "trivia"),
              const SizedBox(height: 20),
              _button(context, name: "random/year", category: "year"),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            children: [
              _button(context, name: "random/date", category: "date"),
              const SizedBox(height: 20),
              _button(context, name: "random/math", category: "math"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _button(BuildContext context, {required String name, required String category}) {
    return SizedBox(
      height: 53,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => _fetchRandom(context, category),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.blue, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  void _fetchRandom(BuildContext context, String category) async {
    try {
      final result = await ApiService().fetchNumberFact(number: "random", category: category);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Natija'),
          content: Text(result.fact),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }
  }
}
