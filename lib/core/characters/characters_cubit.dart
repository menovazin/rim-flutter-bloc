import 'dart:async';

import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/app_error_kind.dart';
import '../../data/repositories/character_repository.dart';
import '../../domain/entities/character.dart';

part 'characters_state.dart';
part 'characters_cubit.freezed.dart';

@injectable
class CharactersCubit extends BaseCubit<CharactersState> {
  final CharacterRepository _repository;

  CharactersCubit(this._repository) : super(const CharactersState());

  Future<void> loadInitial() async {
    if (state.items.isNotEmpty || state.statusLoading) return;
    emit(state.copyWith(
      status: StateStatus.loading,
      hasError: false,
      errorKind: null,
    ));

    try {
      final result = await _repository.getCharacters(1);
      emit(state.copyWith(
        status: StateStatus.loaded,
        items: result.items,
        page: 1,
        hasNext: result.hasNext,
        hasError: false,
        errorKind: null,
      ));
    } catch (error) {
      _handleError(error);
      emit(state.copyWith(
        status: StateStatus.error,
        hasError: true,
        errorKind: appErrorKindFrom(error),
      ));
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasNext || state.statusLoading) return;
    emit(state.copyWith(
      isLoadingMore: true,
      hasError: false,
      errorKind: null,
    ));

    final next = state.page + 1;
    try {
      final result = await _repository.getCharacters(next);
      emit(state.copyWith(
        status: StateStatus.loaded,
        items: [...state.items, ...result.items],
        page: next,
        hasNext: result.hasNext,
        isLoadingMore: false,
        hasError: false,
        errorKind: null,
      ));
    } catch (error) {
      _handleError(error);
      emit(state.copyWith(
        isLoadingMore: false,
        hasError: true,
        errorKind: appErrorKindFrom(error),
      ));
    }
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
      errorKind: null,
      isLoadingMore: false,
    ));

    try {
      final result = await _repository.getCharacters(1);
      emit(state.copyWith(
        status: StateStatus.loaded,
        items: result.items,
        page: 1,
        hasNext: result.hasNext,
        hasError: false,
        errorKind: null,
      ));
    } catch (error) {
      _handleError(error);
      emit(state.copyWith(
        status: StateStatus.error,
        hasError: true,
        errorKind: appErrorKindFrom(error),
      ));
    }
  }

  void _handleError(Object error) {
    if (error is BaseException) {
      handleError2(error);
    } else {
      handleError2(BaseException(message: '$error'));
    }
  }
}