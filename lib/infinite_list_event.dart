// infinite_list_event.dart
import 'package:equatable/equatable.dart';

abstract class InfiniteListEvent extends Equatable {
  const InfiniteListEvent();

  @override
  List<Object> get props => [];
}

class FetchItems extends InfiniteListEvent {}

class FilterChanged extends InfiniteListEvent {
  final String filter;

  const FilterChanged({required this.filter});

  @override
  List<Object> get props => [filter];
}
