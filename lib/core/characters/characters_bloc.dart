import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:injectable/injectable.dart';

import '../../data/repositories/character_repository.dart';
import '../../domain/entities/character.dart';
import '../base/paged_catalog_logic.dart';
import 'characters_event.dart';
import 'characters_state.dart';

@injectable
class CharactersBloc extends BaseBloc<CharactersEvent, CharactersState> {
  CharactersBloc(this._repository) : super(const CharactersState()) {
    _logic = PagedCatalogLogic<Character>(fetch: _repository.getCharacters);
    on<CharactersEvent>(_onEvent);
  }

  final CharacterRepository _repository;
  late final PagedCatalogLogic<Character> _logic;

  Future<void> _onEvent(
    CharactersEvent event,
    Emitter<CharactersState> emit,
  ) async {
    await event.when(
      loadInitialRequested: () => _onLoadInitial(emit),
      loadMoreRequested: () => _onLoadMore(emit),
      refreshRequested: () => _onRefresh(emit),
      retryRequested: () => _onRetry(emit),
    );
  }

  Future<void> _onLoadInitial(Emitter<CharactersState> emit) {
    return _logic.loadInitial(
      items: state.items,
      statusLoading: state.statusLoading,
      emit: (snap) => _apply(emit, snap),
    );
  }

  Future<void> _onLoadMore(Emitter<CharactersState> emit) {
    return _logic.loadMore(
      items: state.items,
      page: state.page,
      hasNext: state.hasNext,
      isLoadingMore: state.isLoadingMore,
      statusLoading: state.statusLoading,
      emit: (snap) => _apply(emit, snap),
    );
  }

  Future<void> _onRetry(Emitter<CharactersState> emit) {
    return _logic.retry(
      items: state.items,
      page: state.page,
      hasNext: state.hasNext,
      isLoadingMore: state.isLoadingMore,
      statusLoading: state.statusLoading,
      emit: (snap) => _apply(emit, snap),
    );
  }

  Future<void> _onRefresh(Emitter<CharactersState> emit) {
    return _logic.refresh(emit: (snap) => _apply(emit, snap));
  }

  void _apply(Emitter<CharactersState> emit, PagedCatalogSnapshot<Character> snap) {
    final error = snap.error;
    if (error != null) {
      // BaseBloc.handleError2 may emit an intermediate state before ours.
      _handleError(error);
    }
    emit(state.copyWith(
      status: snap.status,
      items: snap.items,
      page: snap.page,
      hasNext: snap.hasNext,
      isLoadingMore: snap.isLoadingMore,
      hasError: snap.hasError,
      errorKind: snap.errorKind,
    ));
  }

  void _handleError(Object error) {
    if (error is BaseException) {
      handleError2(error);
    } else {
      handleError2(BaseException(message: '$error'));
    }
  }
}
