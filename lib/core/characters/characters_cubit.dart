import 'dart:async';

import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../data/repositories/character_repository.dart';
import '../../domain/entities/character.dart';

part 'characters_state.dart';
part 'characters_cubit.freezed.dart';

/// Cubit driving the paginated characters catalog (infinite scroll).
@injectable
class CharactersCubit extends BaseCubit<CharactersState> {
  final CharacterRepository _repository;

  CharactersCubit(this._repository) : super(const CharactersState());

  /// Loads the first page. No-op if data is already present (kept-alive tab).
  Future<void> loadInitial() async {
    if (state.items.isNotEmpty || state.statusLoading) return;
    emit(state.copyWith(status: StateStatus.loading, hasError: false));

    final result = await safeAction2(() => _repository.getCharacters(1));
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

  /// Loads the next page and appends it to the current list.
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasNext || state.statusLoading) return;
    emit(state.copyWith(isLoadingMore: true, hasError: false));

    final next = state.page + 1;
    final result = await safeAction2(() => _repository.getCharacters(next));
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

  /// Retries the failed request (initial or pagination).
  Future<void> retry() {
    return state.items.isEmpty ? loadInitial() : loadMore();
  }
}
