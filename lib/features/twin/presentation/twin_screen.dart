import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/widgets/glass/glass_card.dart';
import '../application/twin_controller.dart';
import '../domain/twin_model.dart';
import 'twin_3d_view.dart';

class TwinScreen extends ConsumerWidget {
  const TwinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final twin = ref.watch(twinProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF050A18),
      body: SafeArea(
        child: Column(
          children: [
            const _Header(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    // ========================
                    // 3D VIEW
                    // ========================
                    Expanded(
                      flex: 3,
                      child: _Twin3DContainer(
                        onOrganTap: (organ) {
                          ref.read(twinProvider.notifier).selectOrgan(organ);
                        },
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ========================
                    // STATUS PANEL
                    // ========================
                    Expanded(
                      flex: 2,
                      child: _StatusContainer(twin: twin),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ========================
// HEADER
// ========================
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Text(
        "Digital Twin",
        style: TextStyle(
          color: Colors.cyanAccent,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ========================
// 3D CONTAINER
// ========================
class _Twin3DContainer extends StatelessWidget {
  final void Function(String organ) onOrganTap;

  const _Twin3DContainer({required this.onOrganTap});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Twin3DView(onOrganTap: onOrganTap),
      ),
    );
  }
}

// ========================
// STATUS CONTAINER
// ========================
class _StatusContainer extends StatelessWidget {
  final TwinModel twin;

  const _StatusContainer({required this.twin});

  @override
  Widget build(BuildContext context) {
    if (twin.organs.isEmpty) {
      return const GlassCard(
        child: Center(
          child: Text("No Data", style: TextStyle(color: Colors.white)),
        ),
      );
    }

    return GlassCard(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: twin.organs.length,
        itemBuilder: (_, i) {
          final organ = twin.organs[i];
          return _OrganStatusTile(organ: organ);
        },
      ),
    );
  }
}

// ========================
// ORGAN TILE
// ========================
class _OrganStatusTile extends StatelessWidget {
  final OrganData organ;

  const _OrganStatusTile({required this.organ});

  Color _color(double risk) {
    if (risk > 0.7) return Colors.redAccent;
    if (risk > 0.4) return Colors.orangeAccent;
    return Colors.greenAccent;
  }

  @override
  Widget build(BuildContext context) {
    final color = _color(organ.risk);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            organ.name,
            style: const TextStyle(color: Colors.white),
          ),
          Row(
            children: [
              Icon(Icons.circle, color: color, size: 10),
              const SizedBox(width: 6),
              Text(
                "${(organ.risk * 100).toStringAsFixed(1)}%",
                style: TextStyle(color: color),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
