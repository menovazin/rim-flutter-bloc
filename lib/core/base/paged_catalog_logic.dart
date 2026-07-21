import 'package:flutter_base_kit/flutter_base_kit.dart';

import '../../domain/entities/page_result.dart';
import '../error/app_error_kind.dart';

/// Immutable snapshot of catalog list fields after one pagination step.
class PagedCatalogSnapshot<T> {
  final StateStatus status;
  final List<T> items;
  final int page;
  final bool hasNext;
  final bool isLoadingMore;
  final bool hasError;
  final AppErrorKind? errorKind;

  /// Raw error for [BaseBloc.handleError2]; set only on failure snaps.
  final Object? error;

  const PagedCatalogSnapshot({
    required this.status,
    required this.items,
    required this.page,
    required this.hasNext,
    required this.isLoadingMore,
    required this.hasError,
    this.errorKind,
    this.error,
  });
}

/// Shared loadInitial / loadMore / refresh / retry for catalog blocs.
///
/// Emits progressive snapshots via [emit] so loading/refresh states are
/// visible while the network request is in flight.
class PagedCatalogLogic<T> {
  PagedCatalogLogic({
    required Future<PageResult<T>> Function(int page) fetch,
  }) : _fetch = fetch;

  final Future<PageResult<T>> Function(int page) _fetch;

  Future<void> loadInitial({
    required List<T> items,
    required bool statusLoading,
    required void Function(PagedCatalogSnapshot<T> snap) emit,
  }) async {
    if (items.isNotEmpty || statusLoading) return;

    emit(PagedCatalogSnapshot<T>(
      status: StateStatus.loading,
      items: items,
      page: 1,
      hasNext: true,
      isLoadingMore: false,
      hasError: false,
    ));

    try {
      final result = await _fetch(1);
      emit(PagedCatalogSnapshot<T>(
        status: StateStatus.loaded,
        items: result.items,
        page: 1,
        hasNext: result.hasNext,
        isLoadingMore: false,
        hasError: false,
      ));
    } catch (error) {
      emit(PagedCatalogSnapshot<T>(
        status: StateStatus.error,
        items: items,
        page: 1,
        hasNext: true,
        isLoadingMore: false,
        hasError: true,
        errorKind: appErrorKindFrom(error),
        error: error,
      ));
    }
  }

  Future<void> loadMore({
    required List<T> items,
    required int page,
    required bool hasNext,
    required bool isLoadingMore,
    required bool statusLoading,
    required void Function(PagedCatalogSnapshot<T> snap) emit,
  }) async {
    if (isLoadingMore || !hasNext || statusLoading) return;

    emit(PagedCatalogSnapshot<T>(
      status: StateStatus.loaded,
      items: items,
      page: page,
      hasNext: hasNext,
      isLoadingMore: true,
      hasError: false,
    ));

    final next = page + 1;
    try {
      final result = await _fetch(next);
      emit(PagedCatalogSnapshot<T>(
        status: StateStatus.loaded,
        items: [...items, ...result.items],
        page: next,
        hasNext: result.hasNext,
        isLoadingMore: false,
        hasError: false,
      ));
    } catch (error) {
      emit(PagedCatalogSnapshot<T>(
        status: StateStatus.loaded,
        items: items,
        page: page,
        hasNext: hasNext,
        isLoadingMore: false,
        hasError: true,
        errorKind: appErrorKindFrom(error),
        error: error,
      ));
    }
  }

  Future<void> refresh({
    required void Function(PagedCatalogSnapshot<T> snap) emit,
  }) async {
    emit(PagedCatalogSnapshot<T>(
      status: StateStatus.refresh,
      items: const [],
      page: 1,
      hasNext: true,
      isLoadingMore: false,
      hasError: false,
    ));

    try {
      final result = await _fetch(1);
      emit(PagedCatalogSnapshot<T>(
        status: StateStatus.loaded,
        items: result.items,
        page: 1,
        hasNext: result.hasNext,
        isLoadingMore: false,
        hasError: false,
      ));
    } catch (error) {
      emit(PagedCatalogSnapshot<T>(
        status: StateStatus.error,
        items: const [],
        page: 1,
        hasNext: true,
        isLoadingMore: false,
        hasError: true,
        errorKind: appErrorKindFrom(error),
        error: error,
      ));
    }
  }

  Future<void> retry({
    required List<T> items,
    required int page,
    required bool hasNext,
    required bool isLoadingMore,
    required bool statusLoading,
    required void Function(PagedCatalogSnapshot<T> snap) emit,
  }) {
    if (items.isEmpty) {
      return loadInitial(
        items: items,
        statusLoading: statusLoading,
        emit: emit,
      );
    }
    return loadMore(
      items: items,
      page: page,
      hasNext: hasNext,
      isLoadingMore: isLoadingMore,
      statusLoading: statusLoading,
      emit: emit,
    );
  }
}
