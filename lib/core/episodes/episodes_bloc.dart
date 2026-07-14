import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:injectable/injectable.dart';

import '../error/app_error_kind.dart';
import '../../data/repositories/episode_repository.dart';
import 'episodes_event.dart';
import 'episodes_state.dart';

@injectable
class EpisodesBloc extends BaseBloc<EpisodesEvent, EpisodesState> {
  EpisodesBloc(this._repository) : super(const EpisodesState()) {
    on<EpisodesEvent>(_onEvent);
  }

  final EpisodeRepository _repository;

  Future<void> _onEvent(
    EpisodesEvent event,
    Emitter<EpisodesState> emit,
  ) async {
    await event.when(
      loadInitialRequested: () => _onLoadInitial(emit),
      loadMoreRequested: () => _onLoadMore(emit),
      refreshRequested: () => _onRefresh(emit),
      retryRequested: () => _onRetry(emit),
    );
  }

  Future<void> _onLoadInitial(Emitter<EpisodesState> emit) async {
    if (state.items.isNotEmpty || state.statusLoading) return;
    emit(state.copyWith(
      status: StateStatus.loading,
      hasError: false,
      errorKind: null,
    ));

    try {
      final result = await _repository.getEpisodes(1);
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

  Future<void> _onLoadMore(Emitter<EpisodesState> emit) async {
    if (state.isLoadingMore || !state.hasNext || state.statusLoading) return;
    emit(state.copyWith(
      isLoadingMore: true,
      hasError: false,
      errorKind: null,
    ));

    final next = state.page + 1;
    try {
      final result = await _repository.getEpisodes(next);
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

  Future<void> _onRetry(Emitter<EpisodesState> emit) async {
    if (state.items.isEmpty) {
      await _onLoadInitial(emit);
    } else {
      await _onLoadMore(emit);
    }
  }

  Future<void> _onRefresh(Emitter<EpisodesState> emit) async {
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
      final result = await _repository.getEpisodes(1);
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