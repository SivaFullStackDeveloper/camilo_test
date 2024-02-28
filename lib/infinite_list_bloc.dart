// infinite_list_bloc.dart
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import 'infinite_list_event.dart';
import 'infinite_list_state.dart';

class InfiniteListBloc extends Bloc<InfiniteListEvent, InfiniteListState> {
  InfiniteListBloc() : super(InfiniteListInitial()) {
    on<FetchItems>(_onFetchItems);
  }

  Future<void> _onFetchItems(FetchItems event, Emitter<InfiniteListState> emit) async {
    try {
      final jsonString = await rootBundle.loadString('assets/data.json');
      final List<dynamic> data = json.decode(jsonString);
      print(data);
      emit(InfiniteListLoaded(items: List<Map<String, String>>.from(data)));
    } catch (e) {
      emit(InfiniteListError(message: 'Failed to fetch items'));
    }
  }

  @override
  Stream<InfiniteListState> mapEventToState(
      InfiniteListEvent event,
      ) async* {
    if (event is FilterChanged) {
      yield* _mapFilterChangedToState(event.filter);
    }
  }

  Stream<InfiniteListState> _mapFilterChangedToState(String filter) async* {
    final currentState = state;
    if (currentState is InfiniteListLoaded) {
      final filteredItems = currentState.items.where((item) =>
      item['name']!.toLowerCase().contains(filter.toLowerCase()) ||
          item['description']!.toLowerCase().contains(filter.toLowerCase())).toList();
      yield InfiniteListLoaded(items: currentState.items, filteredItems: filteredItems);
    }
  }
}
