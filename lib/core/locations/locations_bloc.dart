import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:injectable/injectable.dart';

import '../../data/repositories/location_repository.dart';
import '../../domain/entities/location.dart';
import '../base/paged_catalog_logic.dart';
import 'locations_event.dart';
import 'locations_state.dart';

@injectable
class LocationsBloc extends BaseBloc<LocationsEvent, LocationsState> {
  LocationsBloc(this._repository) : super(const LocationsState()) {
    _logic = PagedCatalogLogic<Location>(fetch: _repository.getLocations);
    on<LocationsEvent>(_onEvent);
  }

  final LocationRepository _repository;
  late final PagedCatalogLogic<Location> _logic;

  Future<void> _onEvent(
    LocationsEvent event,
    Emitter<LocationsState> emit,
  ) async {
    await event.when(
      loadInitialRequested: () => _onLoadInitial(emit),
      loadMoreRequested: () => _onLoadMore(emit),
      refreshRequested: () => _onRefresh(emit),
      retryRequested: () => _onRetry(emit),
    );
  }

  Future<void> _onLoadInitial(Emitter<LocationsState> emit) {
    return _logic.loadInitial(
      items: state.items,
      statusLoading: state.statusLoading,
      emit: (snap) => _apply(emit, snap),
    );
  }

  Future<void> _onLoadMore(Emitter<LocationsState> emit) {
    return _logic.loadMore(
      items: state.items,
      page: state.page,
      hasNext: state.hasNext,
      isLoadingMore: state.isLoadingMore,
      statusLoading: state.statusLoading,
      emit: (snap) => _apply(emit, snap),
    );
  }

  Future<void> _onRetry(Emitter<LocationsState> emit) {
    return _logic.retry(
      items: state.items,
      page: state.page,
      hasNext: state.hasNext,
      isLoadingMore: state.isLoadingMore,
      statusLoading: state.statusLoading,
      emit: (snap) => _apply(emit, snap),
    );
  }

  Future<void> _onRefresh(Emitter<LocationsState> emit) {
    return _logic.refresh(emit: (snap) => _apply(emit, snap));
  }

  void _apply(Emitter<LocationsState> emit, PagedCatalogSnapshot<Location> snap) {
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
