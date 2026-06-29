import 'package:equatable/equatable.dart';

/// Generic page-based pagination result returned by repositories.
///
/// Wraps the loaded [items] together with pagination metadata coming from the
/// Rick & Morty REST API `info` object (`pages`, `next`).
class PageResult<T> extends Equatable {
  final List<T> items;
  final int page;
  final int totalPages;
  final bool hasNext;

  const PageResult({
    required this.items,
    required this.page,
    required this.totalPages,
    required this.hasNext,
  });

  @override
  List<Object?> get props => [items, page, totalPages, hasNext];
}
