import 'dart:async';

import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../data/repositories/location_repository.dart';
import '../../domain/entities/location.dart';

part 'locations_state.dart';
part 'locations_cubit.freezed.dart';

/// Cubit driving the paginated locations catalog (infinite scroll).
@injectable
class LocationsCubit extends BaseCubit<LocationsState> {
  final LocationRepository _repository;

  LocationsCubit(this._repository) : super(const LocationsState());

  Future<void> loadInitial() async {
    if (state.items.isNotEmpty || state.statusLoading) return;
    emit(state.copyWith(status: StateStatus.loading, hasError: false));

    final result = await safeAction2(() => _repository.getLocations(1));
    if (result == null) {
      emit(state.copyWith(status: StateStatus.error, hasError: true));
      return;
    }

    emit(state.copyWith(
      status: StateStatus.loaded,
      items: result.items,
      page: 1,
      hasNext: result.hasNext,
      hasError: false,
    ));
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasNext || state.statusLoading) return;
    emit(state.copyWith(isLoadingMore: true, hasError: false));

    final next = state.page + 1;
    final result = await safeAction2(() => _repository.getLocations(next));
    if (result == null) {
      emit(state.copyWith(isLoadingMore: false, hasError: true));
      return;
    }

    emit(state.copyWith(
      status: StateStatus.loaded,
      items: [...state.items, ...result.items],
      page: next,
      hasNext: result.hasNext,
      isLoadingMore: false,
      hasError: false,
    ));
  }

  Future<void> retry() {
    return state.items.isEmpty ? loadInitial() : loadMore();
  }

  Future<void> refresh() async {
    emit(state.copyWith(
      status: StateStatus.refresh,
      items: [],
      page: 1,
      hasNext: true,
      hasError: false,
      isLoadingMore: false,
    ));

    final result = await safeAction2(() => _repository.getLocations(1));
    if (result == null) {
      emit(state.copyWith(status: StateStatus.error, hasError: true));
      return;
    }

    emit(state.copyWith(
      status: StateStatus.loaded,
      items: result.items,
      page: 1,
      hasNext: result.hasNext,
      hasError: false,
    ));
  }
}
