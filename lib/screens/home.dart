import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:numbersapp/screens/saved_page.dart';
import 'package:numbersapp/service/api_service.dart';
import 'package:numbersapp/widgets/category_dropdown.dart';
import 'package:numbersapp/widgets/number_form.dart';
import 'package:numbersapp/widgets/random_button.dart';
import 'package:numbersapp/widgets/save_button.dart';
import 'package:numbersapp/widgets/submit_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final ApiService _apiService = ApiService();

  final List<String> _categories = ['math', 'trivia', 'date', 'year'];
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Numbers")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50),
            CategoryDropdown(),
            SizedBox(height: 30),
            NumberForm(),
            SizedBox(height: 20),
            SubmitButton(),
            SizedBox(height: 70),
            RandomButtons(),
            SizedBox(height: 40),
            SaveButton(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
