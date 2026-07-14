import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:init/core/characters/characters_bloc.dart';
import 'package:init/core/characters/characters_event.dart';
import 'package:init/core/characters/characters_state.dart';
import 'package:init/data/repositories/character_repository.dart';
import 'package:init/domain/entities/character.dart';
import 'package:init/domain/entities/page_result.dart';
import 'package:mocktail/mocktail.dart';

class _MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  group('CharactersBloc', () {
    // spec: characters-catalog / Characters catalog

    late _MockCharacterRepository repository;
    const tCharacter1 = Character(
      id: 1,
      name: 'Rick Sanchez',
      status: 'Alive',
      species: 'Human',
      type: '',
      gender: 'Male',
      image: '',
      originName: '',
      originUrl: '',
      locationName: '',
      locationUrl: '',
      episodeIds: [],
    );
    const tCharacter2 = Character(
      id: 2,
      name: 'Morty Smith',
      status: 'Alive',
      species: 'Human',
      type: '',
      gender: 'Male',
      image: '',
      originName: '',
      originUrl: '',
      locationName: '',
      locationUrl: '',
      episodeIds: [],
    );
    const tPage1 = PageResult<Character>(
      items: [tCharacter1],
      page: 1,
      totalPages: 2,
      hasNext: true,
    );
    const tPage2 = PageResult<Character>(
      items: [tCharacter2],
      page: 2,
      totalPages: 2,
      hasNext: false,
    );

    setUp(() {
      repository = _MockCharacterRepository();
    });

    tearDown(() {
      reset(repository);
    });

    blocTest<CharactersBloc, CharactersState>(
      'loadInitial emits loading then loaded',
      build: () => CharactersBloc(repository),
      act: (bloc) => bloc.add(const CharactersEvent.loadInitialRequested()),
      setUp: () {
        when(() => repository.getCharacters(1))
            .thenAnswer((_) async => tPage1);
      },
      expect: () => [
        _isLoadingState(),
        _isLoadedState(items: tPage1.items, hasNext: true),
      ],
      verify: (_) {
        verify(() => repository.getCharacters(1)).called(1);
      },
    );

    blocTest<CharactersBloc, CharactersState>(
      'loadMore appends next page',
      build: () => CharactersBloc(repository),
      seed: () => const CharactersState(
        status: StateStatus.loaded,
        items: [tCharacter1],
        page: 1,
        hasNext: true,
      ),
      act: (bloc) => bloc.add(const CharactersEvent.loadMoreRequested()),
      setUp: () {
        when(() => repository.getCharacters(2))
            .thenAnswer((_) async => tPage2);
      },
      expect: () => [
        _isLoadingMoreState(),
        _isLoadedState(
          items: [tCharacter1, tCharacter2],
          hasNext: false,
          page: 2,
        ),
      ],
    );

    blocTest<CharactersBloc, CharactersState>(
      'refresh clears items and reloads page 1',
      build: () => CharactersBloc(repository),
      seed: () => const CharactersState(
        status: StateStatus.loaded,
        items: [tCharacter1],
        page: 2,
        hasNext: false,
      ),
      act: (bloc) => bloc.add(const CharactersEvent.refreshRequested()),
      setUp: () {
        when(() => repository.getCharacters(1))
            .thenAnswer((_) async => tPage1);
      },
      expect: () => [
        _isRefreshState(),
        _isLoadedState(items: tPage1.items, hasNext: true),
      ],
    );

    blocTest<CharactersBloc, CharactersState>(
      'retry calls loadInitial when items are empty',
      build: () => CharactersBloc(repository),
      seed: () => const CharactersState(
        status: StateStatus.error,
        hasError: true,
      ),
      act: (bloc) => bloc.add(const CharactersEvent.retryRequested()),
      setUp: () {
        when(() => repository.getCharacters(1))
            .thenAnswer((_) async => tPage1);
      },
      expect: () => [
        _isLoadingState(),
        _isLoadedState(items: tPage1.items, hasNext: true),
      ],
    );

    blocTest<CharactersBloc, CharactersState>(
      'retry calls loadMore when items are not empty',
      build: () => CharactersBloc(repository),
      seed: () => const CharactersState(
        status: StateStatus.error,
        items: [tCharacter1],
        page: 1,
        hasNext: true,
        hasError: true,
      ),
      act: (bloc) => bloc.add(const CharactersEvent.retryRequested()),
      setUp: () {
        when(() => repository.getCharacters(2))
            .thenAnswer((_) async => tPage2);
      },
      expect: () => [
        _isLoadingMoreState(),
        _isLoadedState(
          items: [tCharacter1, tCharacter2],
          hasNext: false,
          page: 2,
        ),
      ],
    );

    blocTest<CharactersBloc, CharactersState>(
      'emits error state when repository throws',
      build: () => CharactersBloc(repository),
      act: (bloc) => bloc.add(const CharactersEvent.loadInitialRequested()),
      setUp: () {
        when(() => repository.getCharacters(1))
            .thenThrow(ApiException(message: 'error', errors: 'error'));
      },
      expect: () => [
        _isLoadingState(),
        _isLoadedState(items: const [], hasNext: true),
        _isErrorState(),
      ],
    );

    blocTest<CharactersBloc, CharactersState>(
      'loadInitial is idempotent when data is already present',
      build: () => CharactersBloc(repository),
      seed: () => const CharactersState(
        status: StateStatus.loaded,
        items: [tCharacter1],
        page: 1,
        hasNext: true,
      ),
      act: (bloc) => bloc.add(const CharactersEvent.loadInitialRequested()),
      expect: () => [],
      verify: (_) {
        verifyNever(() => repository.getCharacters(any()));
      },
    );
  });
}

Matcher _isLoadingState() =>
    isA<CharactersState>()
        .having((s) => s.status, 'status', StateStatus.loading)
        .having((s) => s.hasError, 'hasError', false);

Matcher _isLoadingMoreState() =>
    isA<CharactersState>()
        .having((s) => s.isLoadingMore, 'isLoadingMore', true)
        .having((s) => s.hasError, 'hasError', false);

Matcher _isRefreshState() =>
    isA<CharactersState>()
        .having((s) => s.status, 'status', StateStatus.refresh)
        .having((s) => s.items, 'items', isEmpty)
        .having((s) => s.page, 'page', 1)
        .having((s) => s.hasNext, 'hasNext', true);

Matcher _isLoadedState({
  required List<Character> items,
  required bool hasNext,
  int page = 1,
}) =>
    isA<CharactersState>()
        .having((s) => s.status, 'status', StateStatus.loaded)
        .having((s) => s.items, 'items', equals(items))
        .having((s) => s.page, 'page', page)
        .having((s) => s.hasNext, 'hasNext', hasNext)
        .having((s) => s.hasError, 'hasError', false);

Matcher _isErrorState() =>
    isA<CharactersState>()
        .having((s) => s.status, 'status', StateStatus.error)
        .having((s) => s.hasError, 'hasError', true);