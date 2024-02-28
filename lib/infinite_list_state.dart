// infinite_list_state.dart
import 'package:equatable/equatable.dart';

abstract class InfiniteListState extends Equatable {
  const InfiniteListState();

  @override
  List<Object> get props => [];
}

class InfiniteListInitial extends InfiniteListState {}

class InfiniteListLoading extends InfiniteListState {}

class InfiniteListLoaded extends InfiniteListState {
  final List<Map<String, dynamic>> items;
  final List<Map<String, dynamic>> filteredItems;

  const InfiniteListLoaded({required this.items, List<Map<String, dynamic>>? filteredItems})
      : filteredItems = filteredItems ?? items;

  @override
  List<Object> get props => [items, filteredItems];
}

class InfiniteListError extends InfiniteListState {
  final String message;

  const InfiniteListError({required this.message});

  @override
  List<Object> get props => [message];
}
