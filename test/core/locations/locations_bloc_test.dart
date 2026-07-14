import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:init/core/locations/locations_bloc.dart';
import 'package:init/core/locations/locations_event.dart';
import 'package:init/core/locations/locations_state.dart';
import 'package:init/data/repositories/location_repository.dart';
import 'package:init/domain/entities/location.dart';
import 'package:init/domain/entities/page_result.dart';
import 'package:mocktail/mocktail.dart';

class _MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  group('LocationsBloc', () {
    // spec: locations-catalog / Locations catalog

    late _MockLocationRepository repository;
    const tLocation1 = Location(
      id: 1,
      name: 'Earth (C-137)',
      type: 'Planet',
      dimension: 'Dimension C-137',
      residentIds: [],
    );
    const tLocation2 = Location(
      id: 2,
      name: 'Abadango',
      type: 'Cluster',
      dimension: 'unknown',
      residentIds: [],
    );
    const tPage1 = PageResult<Location>(
      items: [tLocation1],
      page: 1,
      totalPages: 2,
      hasNext: true,
    );
    const tPage2 = PageResult<Location>(
      items: [tLocation2],
      page: 2,
      totalPages: 2,
      hasNext: false,
    );

    setUp(() {
      repository = _MockLocationRepository();
    });

    tearDown(() {
      reset(repository);
    });

    blocTest<LocationsBloc, LocationsState>(
      'loadInitial emits loading then loaded',
      build: () => LocationsBloc(repository),
      act: (bloc) => bloc.add(const LocationsEvent.loadInitialRequested()),
      setUp: () {
        when(() => repository.getLocations(1))
            .thenAnswer((_) async => tPage1);
      },
      expect: () => [
        _isLoadingState(),
        _isLoadedState(items: tPage1.items, hasNext: true),
      ],
      verify: (_) {
        verify(() => repository.getLocations(1)).called(1);
      },
    );

    blocTest<LocationsBloc, LocationsState>(
      'loadMore appends next page',
      build: () => LocationsBloc(repository),
      seed: () => const LocationsState(
        status: StateStatus.loaded,
        items: [tLocation1],
        page: 1,
        hasNext: true,
      ),
      act: (bloc) => bloc.add(const LocationsEvent.loadMoreRequested()),
      setUp: () {
        when(() => repository.getLocations(2))
            .thenAnswer((_) async => tPage2);
      },
      expect: () => [
        _isLoadingMoreState(),
        _isLoadedState(
          items: [tLocation1, tLocation2],
          hasNext: false,
          page: 2,
        ),
      ],
    );

    blocTest<LocationsBloc, LocationsState>(
      'refresh clears items and reloads page 1',
      build: () => LocationsBloc(repository),
      seed: () => const LocationsState(
        status: StateStatus.loaded,
        items: [tLocation1],
        page: 2,
        hasNext: false,
      ),
      act: (bloc) => bloc.add(const LocationsEvent.refreshRequested()),
      setUp: () {
        when(() => repository.getLocations(1))
            .thenAnswer((_) async => tPage1);
      },
      expect: () => [
        _isRefreshState(),
        _isLoadedState(items: tPage1.items, hasNext: true),
      ],
    );

    blocTest<LocationsBloc, LocationsState>(
      'retry calls loadInitial when items are empty',
      build: () => LocationsBloc(repository),
      seed: () => const LocationsState(
        status: StateStatus.error,
        hasError: true,
      ),
      act: (bloc) => bloc.add(const LocationsEvent.retryRequested()),
      setUp: () {
        when(() => repository.getLocations(1))
            .thenAnswer((_) async => tPage1);
      },
      expect: () => [
        _isLoadingState(),
        _isLoadedState(items: tPage1.items, hasNext: true),
      ],
    );

    blocTest<LocationsBloc, LocationsState>(
      'retry calls loadMore when items are not empty',
      build: () => LocationsBloc(repository),
      seed: () => const LocationsState(
        status: StateStatus.error,
        items: [tLocation1],
        page: 1,
        hasNext: true,
        hasError: true,
      ),
      act: (bloc) => bloc.add(const LocationsEvent.retryRequested()),
      setUp: () {
        when(() => repository.getLocations(2))
            .thenAnswer((_) async => tPage2);
      },
      expect: () => [
        _isLoadingMoreState(),
        _isLoadedState(
          items: [tLocation1, tLocation2],
          hasNext: false,
          page: 2,
        ),
      ],
    );

    blocTest<LocationsBloc, LocationsState>(
      'emits error state when repository throws',
      build: () => LocationsBloc(repository),
      act: (bloc) => bloc.add(const LocationsEvent.loadInitialRequested()),
      setUp: () {
        when(() => repository.getLocations(1))
            .thenThrow(ApiException(message: 'error', errors: 'error'));
      },
      expect: () => [
        _isLoadingState(),
        _isLoadedState(items: const [], hasNext: true),
        _isErrorState(),
      ],
    );

    blocTest<LocationsBloc, LocationsState>(
      'loadInitial is idempotent when data is already present',
      build: () => LocationsBloc(repository),
      seed: () => const LocationsState(
        status: StateStatus.loaded,
        items: [tLocation1],
        page: 1,
        hasNext: true,
      ),
      act: (bloc) => bloc.add(const LocationsEvent.loadInitialRequested()),
      expect: () => [],
      verify: (_) {
        verifyNever(() => repository.getLocations(any()));
      },
    );
  });
}

Matcher _isLoadingState() =>
    isA<LocationsState>()
        .having((s) => s.status, 'status', StateStatus.loading)
        .having((s) => s.hasError, 'hasError', false);

Matcher _isLoadingMoreState() =>
    isA<LocationsState>()
        .having((s) => s.isLoadingMore, 'isLoadingMore', true)
        .having((s) => s.hasError, 'hasError', false);

Matcher _isRefreshState() =>
    isA<LocationsState>()
        .having((s) => s.status, 'status', StateStatus.refresh)
        .having((s) => s.items, 'items', isEmpty)
        .having((s) => s.page, 'page', 1)
        .having((s) => s.hasNext, 'hasNext', true);

Matcher _isLoadedState({
  required List<Location> items,
  required bool hasNext,
  int page = 1,
}) =>
    isA<LocationsState>()
        .having((s) => s.status, 'status', StateStatus.loaded)
        .having((s) => s.items, 'items', equals(items))
        .having((s) => s.page, 'page', page)
        .having((s) => s.hasNext, 'hasNext', hasNext)
        .having((s) => s.hasError, 'hasError', false);

Matcher _isErrorState() =>
    isA<LocationsState>()
        .having((s) => s.status, 'status', StateStatus.error)
        .having((s) => s.hasError, 'hasError', true);