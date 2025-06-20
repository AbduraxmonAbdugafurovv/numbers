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

  // Widget _buildDropdown() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 16),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.blue, width: 1.5),
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: DropdownButtonHideUnderline(
  //       child: DropdownButton<String>(
  //         value: _selectedCategory,
  //         isExpanded: true,
  //         hint: const Text('Kategoriya tanlang'),
  //         items:
  //             _categories.map((category) {
  //               return DropdownMenuItem<String>(
  //                 value: category,
  //                 child: Text(
  //                   category.toUpperCase(),
  //                   style: const TextStyle(color: Colors.black),
  //                 ),
  //               );
  //             }).toList(),
  //         onChanged: (newValue) {
  //           setState(() {
  //             _selectedCategory = newValue!;
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildForm() {
  //   return Form(
  //     key: _formKey,
  //     child: TextFormField(
  //       controller: _controller,
  //       keyboardType: TextInputType.number,
  //       decoration: InputDecoration(
  //         labelText: 'Faqat raqam kiriting',
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10),
  //           borderSide: const BorderSide(color: Colors.blue),
  //         ),
  //       ),
  //       validator: (value) {
  //         if (value == null || value.trim().isEmpty) {
  //           return 'Maydon bo‘sh bo‘lishi mumkin emas';
  //         }
  //         if (num.tryParse(value.trim()) == null) {
  //           return 'Faqat raqam kiriting';
  //         }
  //         return null;
  //       },
  //     ),
  //   );
  // }

  // Widget _buildSubmitButton() {
  //   return InkWell(
  //     onTap: _handleSubmit,
  //     child: Container(
  //       alignment: Alignment.center,
  //       height: 53,
  //       width: double.infinity,
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.blue),
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: const Text(
  //         "Ma'lumotlarni chiqarish",
  //         style: TextStyle(color: Colors.blue, fontSize: 17),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildButtonsRow() {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: Column(
  //           children: [
  //             _customButton(
  //               name: "random/trivia",
  //               onTap: () {
  //                 _fetchNumbers(number: "random", category: "trivia");
  //               },
  //             ),
  //             const SizedBox(height: 20),
  //             _customButton(
  //               name: "random/year",
  //               onTap: () {
  //                 _fetchNumbers(number: "random", category: "year");
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(width: 20),
  //       Expanded(
  //         child: Column(
  //           children: [
  //             _customButton(
  //               name: "random/date",
  //               onTap: () {
  //                 _fetchNumbers(number: "random", category: "date");
  //               },
  //             ),
  //             const SizedBox(height: 20),
  //             _customButton(
  //               name: "random/math",
  //               onTap: () {
  //                 _fetchNumbers(number: "random", category: "math");
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildSavedButton() {
  //   return SizedBox(
  //     height: 50,
  //     width: double.infinity,
  //     child: OutlinedButton(
  //       onPressed: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (_) => const SavedPage()),
  //         );
  //       },
  //       style: OutlinedButton.styleFrom(
  //         backgroundColor: Colors.blue.shade100,
  //         side: const BorderSide(width: 2, color: Colors.blue),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //       ),
  //       child: const Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Icon(Icons.save, size: 30),
  //           SizedBox(width: 5),
  //           Text("Saqlanganlar"),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _customButton({required VoidCallback onTap, required String name}) {
  //   return SizedBox(
  //     height: 53,
  //     width: double.infinity,
  //     child: OutlinedButton(
  //       onPressed: onTap,
  //       style: OutlinedButton.styleFrom(
  //         side: const BorderSide(color: Colors.blue, width: 1.5),
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //       ),
  //       child: Text(
  //         name,
  //         style: const TextStyle(
  //           color: Colors.blue,
  //           fontWeight: FontWeight.w500,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // void _handleSubmit() async {
  //   if (_formKey.currentState?.validate() ?? false) {
  //     final number = _controller.text.trim();
  //     final category = _selectedCategory;

  //     if (category == null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text("Kategoriya tanlanmagan"),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //       return;
  //     }

  //     try {
  //       final result = await _apiService.fetchNumberFact(
  //         number: number,
  //         category: category,
  //       );
  //       _showResultModal(result, number, category);
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
  //       );
  //     }
  //   }
  // }

  // void _showResultModal(String fact, String number, String category) {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     isScrollControlled: true,
  //     builder: (context) {
  //       return Padding(
  //         padding: const EdgeInsets.all(20),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Center(
  //               child: Container(width: 40, height: 4, color: Colors.grey[400]),
  //             ),
  //             const SizedBox(height: 20),
  //             Text(
  //               "Raqam: $number",
  //               style: const TextStyle(
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             const SizedBox(height: 8),
  //             Text(
  //               "Kategoriya: ${category.toUpperCase()}",
  //               style: const TextStyle(fontSize: 14, color: Colors.grey),
  //             ),
  //             const Divider(height: 30),
  //             Text(fact, style: const TextStyle(fontSize: 16)),
  //             const SizedBox(height: 20),
  //             SizedBox(
  //               width: double.infinity,
  //               child: ElevatedButton.icon(
  //                 onPressed: () {
  //                   _saveFact(number, category, fact);
  //                   Navigator.pop(context); // Modalni yopish
  //                 },
  //                 icon: const Icon(Icons.save),
  //                 label: const Text("Saqlash"),
  //                 style: ElevatedButton.styleFrom(
                    
  //                   backgroundColor: Colors.blue,
  //                   foregroundColor: Colors.white,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                   padding: const EdgeInsets.symmetric(vertical: 14),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _saveFact(String number, String category, String fact) {
  //   // Bu yerda Hive, sqflite yoki boshqa storage yozishingiz mumkin
   

  //    final box = Hive.box('saved_facts');

  // final savedItem = {
  //   'number': number,
  //   'category': category,
  //   'fact': fact,
  // };

  // box.add(savedItem); // List tarzida saqlanadi

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       content: Text('Maʼlumot saqlandi!'),
  //       backgroundColor: Colors.green,
  //     ),
  //   );
  // }

  // _fetchNumbers({number = "random/", category}) async {
  //   try {
  //     final result = await _apiService.fetchNumberFact(
  //       number: number,
  //       category: category,
  //     );
  //     _showResultDialog(result);
      
  //   } catch (e) {
  //     // ignore: use_build_context_synchronously
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
  //     );
  //   }
  // }

  // void _showResultDialog(String text) {
  //   showDialog(
  //     context: context,
  //     builder:
  //         (_) => AlertDialog(
  //           title: const Text('Natija'),
  //           content: Text(text),
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         ),
  //   );
  // }
}
