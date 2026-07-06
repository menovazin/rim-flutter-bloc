import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:init/core/episodes/episodes_cubit.dart';
import 'package:init/data/repositories/episode_repository.dart';
import 'package:init/domain/entities/episode.dart';
import 'package:init/domain/entities/page_result.dart';
import 'package:mocktail/mocktail.dart';

class _MockEpisodeRepository extends Mock implements EpisodeRepository {}

void main() {
  group('EpisodesCubit', () {
    // spec: episodes-catalog / Episodes catalog

    late _MockEpisodeRepository repository;
    const tEpisode1 = Episode(
      id: 1,
      name: 'Pilot',
      episodeCode: 'S01E01',
      airDate: 'December 2, 2013',
      characterIds: [],
    );
    const tEpisode2 = Episode(
      id: 2,
      name: 'Lawnmower Dog',
      episodeCode: 'S01E02',
      airDate: 'December 9, 2013',
      characterIds: [],
    );
    const tPage1 = PageResult<Episode>(
      items: [tEpisode1],
      page: 1,
      totalPages: 2,
      hasNext: true,
    );
    const tPage2 = PageResult<Episode>(
      items: [tEpisode2],
      page: 2,
      totalPages: 2,
      hasNext: false,
    );

    setUp(() {
      repository = _MockEpisodeRepository();
    });

    tearDown(() {
      reset(repository);
    });

    blocTest<EpisodesCubit, EpisodesState>(
      'loadInitial emits loading then loaded',
      build: () => EpisodesCubit(repository),
      act: (cubit) => cubit.loadInitial(),
      setUp: () {
        when(() => repository.getEpisodes(1))
            .thenAnswer((_) async => tPage1);
      },
      expect: () => [
        _isLoadingState(),
        _isLoadedState(items: tPage1.items, hasNext: true),
      ],
      verify: (_) {
        verify(() => repository.getEpisodes(1)).called(1);
      },
    );

    blocTest<EpisodesCubit, EpisodesState>(
      'loadMore appends next page',
      build: () => EpisodesCubit(repository),
      seed: () => const EpisodesState(
        status: StateStatus.loaded,
        items: [tEpisode1],
        page: 1,
        hasNext: true,
      ),
      act: (cubit) => cubit.loadMore(),
      setUp: () {
        when(() => repository.getEpisodes(2))
            .thenAnswer((_) async => tPage2);
      },
      expect: () => [
        _isLoadingMoreState(),
        _isLoadedState(
          items: [tEpisode1, tEpisode2],
          hasNext: false,
          page: 2,
        ),
      ],
    );

    blocTest<EpisodesCubit, EpisodesState>(
      'refresh clears items and reloads page 1',
      build: () => EpisodesCubit(repository),
      seed: () => const EpisodesState(
        status: StateStatus.loaded,
        items: [tEpisode1],
        page: 2,
        hasNext: false,
      ),
      act: (cubit) => cubit.refresh(),
      setUp: () {
        when(() => repository.getEpisodes(1))
            .thenAnswer((_) async => tPage1);
      },
      expect: () => [
        _isRefreshState(),
        _isLoadedState(items: tPage1.items, hasNext: true),
      ],
    );

    blocTest<EpisodesCubit, EpisodesState>(
      'retry calls loadInitial when items are empty',
      build: () => EpisodesCubit(repository),
      seed: () => const EpisodesState(
        status: StateStatus.error,
        hasError: true,
      ),
      act: (cubit) => cubit.retry(),
      setUp: () {
        when(() => repository.getEpisodes(1))
            .thenAnswer((_) async => tPage1);
      },
      expect: () => [
        _isLoadingState(),
        _isLoadedState(items: tPage1.items, hasNext: true),
      ],
    );

    blocTest<EpisodesCubit, EpisodesState>(
      'retry calls loadMore when items are not empty',
      build: () => EpisodesCubit(repository),
      seed: () => const EpisodesState(
        status: StateStatus.error,
        items: [tEpisode1],
        page: 1,
        hasNext: true,
        hasError: true,
      ),
      act: (cubit) => cubit.retry(),
      setUp: () {
        when(() => repository.getEpisodes(2))
            .thenAnswer((_) async => tPage2);
      },
      expect: () => [
        _isLoadingMoreState(),
        _isLoadedState(
          items: [tEpisode1, tEpisode2],
          hasNext: false,
          page: 2,
        ),
      ],
    );

    blocTest<EpisodesCubit, EpisodesState>(
      'emits error state when repository throws',
      build: () => EpisodesCubit(repository),
      act: (cubit) => cubit.loadInitial(),
      setUp: () {
        when(() => repository.getEpisodes(1))
            .thenThrow(ApiException(message: 'error', errors: 'error'));
      },
      expect: () => [
        _isLoadingState(),
        _isLoadedState(items: const [], hasNext: true),
        _isErrorState(),
      ],
    );

    blocTest<EpisodesCubit, EpisodesState>(
      'loadInitial is idempotent when data is already present',
      build: () => EpisodesCubit(repository),
      seed: () => const EpisodesState(
        status: StateStatus.loaded,
        items: [tEpisode1],
        page: 1,
        hasNext: true,
      ),
      act: (cubit) => cubit.loadInitial(),
      expect: () => [],
      verify: (_) {
        verifyNever(() => repository.getEpisodes(any()));
      },
    );
  });
}

Matcher _isLoadingState() =>
    isA<EpisodesState>()
        .having((s) => s.status, 'status', StateStatus.loading)
        .having((s) => s.hasError, 'hasError', false);

Matcher _isLoadingMoreState() =>
    isA<EpisodesState>()
        .having((s) => s.isLoadingMore, 'isLoadingMore', true)
        .having((s) => s.hasError, 'hasError', false);

Matcher _isRefreshState() =>
    isA<EpisodesState>()
        .having((s) => s.status, 'status', StateStatus.refresh)
        .having((s) => s.items, 'items', isEmpty)
        .having((s) => s.page, 'page', 1)
        .having((s) => s.hasNext, 'hasNext', true);

Matcher _isLoadedState({
  required List<Episode> items,
  required bool hasNext,
  int page = 1,
}) =>
    isA<EpisodesState>()
        .having((s) => s.status, 'status', StateStatus.loaded)
        .having((s) => s.items, 'items', equals(items))
        .having((s) => s.page, 'page', page)
        .having((s) => s.hasNext, 'hasNext', hasNext)
        .having((s) => s.hasError, 'hasError', false);

Matcher _isErrorState() =>
    isA<EpisodesState>()
        .having((s) => s.status, 'status', StateStatus.error)
        .having((s) => s.hasError, 'hasError', true);
