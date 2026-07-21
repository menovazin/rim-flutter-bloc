import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/characters/characters_bloc.dart';
import '../../../core/characters/characters_event.dart';
import '../../../core/characters/characters_state.dart';

import '../../../core/error/app_error_kind.dart';
import '../../../di/di.dart';
import '../../../l10n/localization_helper.dart';
import '../../../domain/entities/character.dart';
import '../../../routes/router.dart';
import '../../../themes/app_theme.dart';
import '../../../utils/extensions/character_status_x.dart';
import '../../../utils/grid_utils.dart';
import '../../views/errors/grid_error_tile.dart';

/// Characters catalog: adaptive [SliverGrid] of cards with infinite scroll.
@RoutePage()
class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final _bloc = di.charactersBloc;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _bloc.add(const CharactersEvent.loadInitialRequested());
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    unawaited(_bloc.close());
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      _bloc.add(const CharactersEvent.loadMoreRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<CharactersBloc, CharactersState>(
        builder: (context, state) {
          if (state.isBusy && state.items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.hasError && state.items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: GridErrorTile(
                  message: state.errorKind?.localizedMessage(context.strings),
                  onRetry: () =>
                      _bloc.add(const CharactersEvent.retryRequested()),
                ),
              ),
            );
          }

          if (!state.isBusy &&
              !state.hasError &&
              state.items.isEmpty) {
            return Center(child: Text(context.strings.emptyCharacters));
          }

          final crossAxisCount = context.gridCrossAxisCount;
          return RefreshIndicator(
            onRefresh: () async {
              _bloc.add(const CharactersEvent.refreshRequested());
              await _bloc.stream.skip(1).firstWhere((s) => !s.isBusy);
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(12),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.72,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _CharacterCard(
                        key: ValueKey(state.items[index].id),
                        character: state.items[index],
                      ),
                      childCount: state.items.length,
                    ),
                  ),
                ),
                if (state.isLoadingMore)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                if (state.hasError && state.items.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: GridErrorTile(
                        message:
                            state.errorKind?.localizedMessage(context.strings),
                        onRetry: () =>
                            _bloc.add(const CharactersEvent.retryRequested()),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CharacterCard extends StatelessWidget {
  final Character character;

  const _CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    return RepaintBoundary(
      child: GestureDetector(
        onTap: () {
          unawaited(
            context.router.push(CharacterDetailRoute(character: character)),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: designs.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: character.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => ColoredBox(
                      color: designs.background,
                    ),
                    errorWidget: (context, url, error) => ColoredBox(
                      color: designs.background,
                      child: Icon(
                        Icons.broken_image,
                        color: designs.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.titleSmall?.copyWith(
                        color: designs.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: character.statusColorOf(designs),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '${character.status} • ${character.species}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: designs.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
