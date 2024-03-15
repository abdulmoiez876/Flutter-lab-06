import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saved Suggestions',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const SavedSuggestionsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SavedSuggestionsScreen extends StatefulWidget {
  const SavedSuggestionsScreen({Key? key}) : super(key: key);

  @override
  State<SavedSuggestionsScreen> createState() => _SavedSuggestionsScreenState();
}

class _SavedSuggestionsScreenState extends State<SavedSuggestionsScreen> {
  final List<String> savedSuggestions = [
    "Sunflower",
    "Mountain",
    "Coffee",
    "Galaxy",
    "Waterfall",
    "Rainbow",
    "Sushi",
    "Campfire",
    "Lighthouse",
    "Dragonfly",
    "Whale",
    "Fireworks",
    "Butterfly",
    "Hot Air Balloon",
    "Thunderstorm",
    "Maple Tree",
    "Desert Oasis",
    "Northern Lights",
    "Moonlight",
    "Crystal",
    "Space Shuttle",
    "Tornado",
    "Aurora",
    "Rainforest",
    "Volcano"
  ];
  List<bool> isSelected = List.generate(25, (_) => false);

  bool anyItemSelected() {
    return isSelected.contains(true);
  }

  void deleteSelectedItems() {
    setState(() {
      for (int i = savedSuggestions.length - 1; i >= 0; i--) {
        if (isSelected[i]) {
          savedSuggestions.removeAt(i);
          isSelected.removeAt(i);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Saved Suggestions',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.white,
            onPressed: () {
              if (anyItemSelected()) {
                _showConfirmationDialog();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No Item Selected'),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: savedSuggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(savedSuggestions[index]),
            trailing: isSelected[index]
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
            onTap: () {
              setState(() {
                isSelected[index] = !isSelected[index];
              });
            },
          );
        },
      ),
    );
  }

  Future<void> _showConfirmationDialog() async {
    List<String> selectedItems = [];
    for (int i = 0; i < savedSuggestions.length; i++) {
      if (isSelected[i]) {
        selectedItems.add(savedSuggestions[i]);
      }
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Selected Items?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text(
                    'Are you sure you want to delete the following items?'),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: selectedItems.map((item) => Text(item)).toList(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                deleteSelectedItems();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
