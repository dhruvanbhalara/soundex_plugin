import 'package:flutter/material.dart';
import 'package:soundex_plugin/soundex_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _allNames = ['Robert', 'Rupert', 'Rubin', 'Ashcraft', 'Ashcroft', 'Tymczak', 'Pfister', 'Honeyman'];
  List<String> _filteredNames = [];

  @override
  void initState() {
    super.initState();
    _filteredNames = _allNames;
  }
// When a user types a name into the search bar, the app encodes the input using Soundex.
// It then compares this code against the Soundex codes of the names in the _allNames list.
// Names with matching Soundex codes are displayed in the list view.
  void _filterNames(String enteredText) {
    String encodedSearch = SoundexPlugin.encode(enteredText);
    setState(() {
      _filteredNames = _allNames.where((name) {
        return SoundexPlugin.encode(name).startsWith(encodedSearch);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Soundex Search Example'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Search Names',
                  border: OutlineInputBorder(),
                ),
                onChanged: _filterNames,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filteredNames[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
