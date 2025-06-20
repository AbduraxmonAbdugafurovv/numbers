import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('saved_facts');

    return Scaffold(
      appBar: AppBar(title: const Text('Saqlanganlar')),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('Hozircha hech narsa saqlanmagan.'));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final item = box.getAt(index);
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(item['fact'] ?? 'Fakt yoʻq'),
                  subtitle: Text('Raqam: ${item['number']}  |  Kategoriya: ${item['category']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      box.deleteAt(index);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
