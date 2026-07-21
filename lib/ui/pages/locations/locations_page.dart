import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/locations/locations_bloc.dart';
import '../../../core/locations/locations_event.dart';
import '../../../core/locations/locations_state.dart';
import '../../../core/error/app_error_kind.dart';
import '../../../di/di.dart';
import '../../../l10n/localization_helper.dart';
import '../../../domain/entities/location.dart';
import '../../../routes/router.dart';
import '../../../themes/app_theme.dart';
import '../../../utils/extensions/location_type_x.dart';
import '../../views/errors/grid_error_tile.dart';

/// Locations catalog: list with infinite scroll.
@RoutePage()
class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  final _bloc = di.locationsBloc;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _bloc.add(const LocationsEvent.loadInitialRequested());
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
      _bloc.add(const LocationsEvent.loadMoreRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<LocationsBloc, LocationsState>(
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
                      _bloc.add(const LocationsEvent.retryRequested()),
                ),
              ),
            );
          }

          if (!state.isBusy && !state.hasError && state.items.isEmpty) {
            return Center(child: Text(context.strings.emptyLocations));
          }

          return RefreshIndicator(
            onRefresh: () async {
              _bloc.add(const LocationsEvent.refreshRequested());
              await _bloc.stream.skip(1).firstWhere((s) => !s.isBusy);
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(12),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _LocationTile(
                        key: ValueKey(state.items[index].id),
                        location: state.items[index],
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
                            _bloc.add(const LocationsEvent.retryRequested()),
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

class _LocationTile extends StatelessWidget {
  final Location location;

  const _LocationTile({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    return RepaintBoundary(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: designs.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          leading: CircleAvatar(
            backgroundColor: designs.secondary.withValues(alpha: 0.18),
            child: Icon(location.type.locationIcon, color: designs.secondary),
          ),
          title: Text(
            location.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.titleSmall?.copyWith(
              color: designs.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            '${location.type.isEmpty ? 'Unknown' : location.type} • '
            '${location.dimension.isEmpty ? 'Unknown' : location.dimension}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodySmall?.copyWith(
              color: designs.textSecondary,
            ),
          ),
          trailing: Icon(Icons.chevron_right, color: designs.textSecondary),
          onTap: () {
            unawaited(
              context.router.push(LocationDetailRoute(location: location)),
            );
          },
        ),
      ),
    );
  }
}
