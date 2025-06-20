import 'package:flutter/material.dart';

class NumberForm extends StatefulWidget {
  const NumberForm({super.key});
  static final TextEditingController controller = TextEditingController();

  @override
  State<NumberForm> createState() => NumberFormState();
}

class NumberFormState extends State<NumberForm> {
 static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static GlobalKey<FormState> get key => _formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: NumberForm.controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Faqat raqam kiriting',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue),
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Maydon bo‘sh bo‘lishi mumkin emas';
          }
          if (num.tryParse(value.trim()) == null) {
            return 'Faqat raqam kiriting';
          }
          return null;
        },
      ),
    );
  }
}
