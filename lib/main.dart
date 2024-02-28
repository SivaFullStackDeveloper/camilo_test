import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Infinite List Demo',
      home: InfiniteListPage(),
    );
  }
}

class InfiniteListPage extends StatefulWidget {
  @override
  _InfiniteListPageState createState() => _InfiniteListPageState();
}

class _InfiniteListPageState extends State<InfiniteListPage> {
   List<Map<String, String>> ?_allItems;
   List<Map<String, String>> ?_filteredItems;

  @override
  void initState() {
    super.initState();
    _loadItemsFromJson();
  }

  Future<void> _loadItemsFromJson() async {
    final jsonString = await rootBundle.loadString('assets/data.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    _allItems = jsonList.map((item) => Map<String, String>.from(item)).toList();
    _filteredItems = List<Map<String, String>>.from(_allItems!);
    setState(() {}); // Update the UI
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = _allItems!.where((item) {
        final name = item['name'] ?? '';
        final description = item['description'] ?? '';
        return name.toLowerCase().contains(query.toLowerCase()) ||
            description.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infinite List Demo'),
      ),
      body: _allItems == null
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterItems,
              decoration: InputDecoration(
                labelText: 'Filter',
                hintText: 'Enter filter text',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: InfiniteList(items: _filteredItems!),
          ),
        ],
      ),
    );
  }
}

class InfiniteList extends StatelessWidget {
  final List<Map<String, String>> items;

  const InfiniteList({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text(item['name'] ?? ''),
          subtitle: Text(item['description'] ?? ''),
        );
      },
    );
  }
}
