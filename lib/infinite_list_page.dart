// infinite_list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'infinite_list_bloc.dart';
import 'infinite_list_event.dart';
import 'infinite_list_state.dart';

class InfiniteListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infinite List'),
      ),
      body: Column(
        children: [
          FilterTextField(),
          Expanded(child: InfiniteList()),
        ],
      ),
    );
  }
}

class FilterTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {
          BlocProvider.of<InfiniteListBloc>(context).add(FilterChanged(filter: value));
        },
        decoration: InputDecoration(
          labelText: 'Filter',
          hintText: 'Enter filter text',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}

class InfiniteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfiniteListBloc, InfiniteListState>(
      builder: (context, state) {
        if (state is InfiniteListLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is InfiniteListLoaded) {
          final List<Map<String, dynamic>> itemsToShow = state.filteredItems.isNotEmpty ? state.filteredItems : state.items;
          return ListView.builder(
            itemCount: itemsToShow.length,
            itemBuilder: (context, index) {
              final item = itemsToShow[index];
              return ListTile(
                title: Text(item['name'] ?? ''),
                subtitle: Text(item['description'] ?? ''),
              );
            },
          );
        } else if (state is InfiniteListError) {
          return Center(
            child: Text('Error: ${state.message}'),
          );
        } else {
          return SizedBox(); // Placeholder
        }
      },
    );
  }
}

