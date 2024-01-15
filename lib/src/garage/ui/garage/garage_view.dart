import 'package:my_garage/src/garage/infra/models/auto.dart';
import 'package:my_garage/src/garage/ui/garage/garage_header_delegate.dart';
import 'package:my_garage/src/garage/ui/garage/garage_list_tile.dart';
import 'package:my_garage/src/garage/ui/garage_auto/garage_auto_list_tile.dart';
import 'package:my_garage/src/internal/infra/extensions/build_context_x.dart';
import 'package:flutter/material.dart';

class GarageView extends StatelessWidget {
  const GarageView({
    super.key,
    required this.autos,
    required this.onAuto,
    required this.onAddAuto,
  });

  final List<Auto> autos;
  final ValueChanged<int>? onAuto;
  final VoidCallback? onAddAuto;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            final appBarHeight = context.data.padding.top + kToolbarHeight;
            return [
              SliverAppBar(
                expandedHeight: appBarHeight + 166.0,
                title: Text(context.t.garageAppBarTitle),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: appBarHeight),
                      GarageListTile(
                        title: Text(context.t.garageMyGarageTitle),
                        subtitle: Text(context.t.garageMyGarageSubtitle),
                        onAddAuto: onAddAuto,
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverMainAxisGroup(
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: GarageHeaderDelegate(
                      context.t.garageMyAutoTitle,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  ),
                  SliverList.builder(
                    itemCount: autos.length,
                    itemBuilder: (_, index) {
                      final auto = autos[index];
                      return GarageAutoListTile.short(
                        auto: auto,
                        onTap:
                            onAuto != null ? () => onAuto?.call(auto.id) : null,
                      );
                    },
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: context.data.padding.bottom),
              ),
            ],
          ),
        ),
      ),
    );
  }
}