import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/episodes/episodes_cubit.dart';
import '../../../di/di.dart';
import '../../../domain/entities/episode.dart';
import '../../../routes/router.dart';
import '../../../themes/app_theme.dart';
import '../../views/errors/grid_error_tile.dart';

/// Episodes catalog: list with infinite scroll.
@RoutePage()
class EpisodesPage extends StatefulWidget {
  const EpisodesPage({super.key});

  @override
  State<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  final _cubit = locator<EpisodesCubit>();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _cubit.loadInitial();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _cubit.close();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      _cubit.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<EpisodesCubit, EpisodesState>(
        builder: (context, state) {
          if (state.isBusy && state.items.isEmpty) {

            return const Center(child: CircularProgressIndicator());
          }

          if (state.hasError && state.items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: GridErrorTile(onRetry: _cubit.retry),
              ),
            );
          }

          return CustomScrollView(
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
                    child: GridErrorTile(onRetry: _cubit.retry),
                  ),
                ),
            ],
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
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: designs.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: CircleAvatar(
          backgroundColor: designs.primary.withValues(alpha: 0.15),
          child: Icon(Icons.movie_outlined, color: designs.primary),
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
          '${episode.episodeCode} • ${episode.airDate}',
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
