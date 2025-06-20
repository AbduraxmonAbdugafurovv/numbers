import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:numbersapp/models/models.dart';
import '../service/api_service.dart';
import 'category_dropdown.dart';
import 'number_form.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleSubmit(context),
      child: Container(
        alignment: Alignment.center,
        height: 53,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          "Get Info",
          style: TextStyle(color: Colors.blue, fontSize: 17),
        ),
      ),
    );
  }

  void _handleSubmit(BuildContext context) async {
    final formKey = NumberFormState.key;
    if (formKey.currentState?.validate() ?? false) {
      final number = NumberForm.controller.text.trim();
      final category = CategoryDropdown.selectedCategory;

      if (category == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Kategoriya tanlanmagan"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      try {
        final result = await ApiService().fetchNumberFact(
          number: number,
          category: category,
        );
        _showResultModal(context, result.fact, number, category);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _showResultModal(
    BuildContext context,
    String fact,
    String number,
    String category,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(width: 40, height: 4, color: Colors.grey[400]),
              ),
              const SizedBox(height: 20),
              Text(
                "Number: $number",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "CAtegory: ${category.toUpperCase()}",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const Divider(height: 30),
              Text(fact, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final box = Hive.box('saved_facts');
                    final item = NumberFactModel(
                      number: number,
                      category: category,
                      fact: fact,
                    );
                    // final item = {'number': number, 'category': category, 'fact': fact};
                    box.add(item);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Info saved!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  icon: const Icon(Icons.save),
                  label: const Text("SAve"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
