import 'package:flutter/material.dart';
import 'package:numbersapp/screens/saved_page.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SavedPage()),
          );
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.blue.shade100,
          side: const BorderSide(width: 2, color: Colors.blue),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.save, size: 30),
            SizedBox(width: 5),
            Text("Saved"),
          ],
        ),
      ),
    );
  }
}
