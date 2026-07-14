import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/episodes/episodes_bloc.dart';
import '../../../core/episodes/episodes_event.dart';
import '../../../core/episodes/episodes_state.dart';
import '../../../core/error/app_error_kind.dart';
import '../../../di/di.dart';
import '../../../l10n/localization_helper.dart';
import '../../../domain/entities/episode.dart';
import '../../../routes/router.dart';
import '../../../themes/app_theme.dart';
import '../../../utils/extensions/episode_code_x.dart';
import '../../views/errors/grid_error_tile.dart';

/// Episodes catalog: list with infinite scroll.
@RoutePage()
class EpisodesPage extends StatefulWidget {
  const EpisodesPage({super.key});

  @override
  State<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  final _bloc = di.episodesBloc;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _bloc.add(const EpisodesEvent.loadInitialRequested());
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _bloc.close();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      _bloc.add(const EpisodesEvent.loadMoreRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<EpisodesBloc, EpisodesState>(
        builder: (context, state) {
          if (state.isBusy && state.items.isEmpty) {
            return Center(
              child: CircularProgressIndicator(color: designs.primary),
            );
          }

          if (state.hasError && state.items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: GridErrorTile(
                  message: state.errorKind?.localizedMessage(context.strings),
                  onRetry: () =>
                      _bloc.add(const EpisodesEvent.retryRequested()),
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              _bloc.add(const EpisodesEvent.refreshRequested());
              await _bloc.stream.skip(1).firstWhere((s) => !s.isBusy);
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(12),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          _EpisodeTile(episode: state.items[index]),
                      childCount: state.items.length,
                    ),
                  ),
                ),
                if (state.isLoadingMore)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child:
                            CircularProgressIndicator(color: designs.primary),
                      ),
                    ),
                  ),
                if (state.hasError && state.items.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: GridErrorTile(
                  message: state.errorKind?.localizedMessage(context.strings),
                  onRetry: () =>
                      _bloc.add(const EpisodesEvent.retryRequested()),
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

class _EpisodeTile extends StatelessWidget {
  final Episode episode;

  const _EpisodeTile({required this.episode});

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    final s = episode.episodeCode.season;
    final e = episode.episodeCode.episodeNumber;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: designs.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: designs.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'S${s.toString().padLeft(2, '0')}',
                style: context.textTheme.labelSmall?.copyWith(
                  color: designs.primary,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
              Text(
                'E${e.toString().padLeft(2, '0')}',
                style: context.textTheme.labelSmall?.copyWith(
                  color: designs.primary.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        title: Text(
          episode.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.titleSmall?.copyWith(
            color: designs.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          episode.airDate,
          style: context.textTheme.bodySmall?.copyWith(
            color: designs.textSecondary,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: designs.textSecondary),
        onTap: () => context.router.push(
          EpisodeDetailRoute(episode: episode),
        ),
      ),
    );
  }
}