import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/glass/glass_card.dart';
import '../domain/twin_model.dart';
import '../application/twin_controller.dart';
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
            const SizedBox(height: 10),

            // ========================
            // HEADER
            // ========================
            const Text(
              "Digital Twin",
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // ========================
            // 3D VIEW
            // ========================
            Expanded(
              child: GlassCard(
                child: Twin3DView(
                  onOrganTap: (organ) {
                    ref.read(twinProvider.notifier).selectOrgan(organ);
                  },
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ========================
            // STATUS PANEL
            // ========================
            GlassCard(
              child: _StatusPanel(twin: twin),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ========================
// STATUS PANEL (CLEAN COMPONENT)
// ========================
class _StatusPanel extends StatelessWidget {
  final TwinModel twin;

  const _StatusPanel({required this.twin});

  Color _color(double risk) {
    if (risk > 0.7) return Colors.redAccent;
    if (risk > 0.4) return Colors.orangeAccent;
    return Colors.greenAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: twin.organs.map((organ) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            "${organ.name}: ${(organ.risk * 100).toStringAsFixed(1)}%",
            style: TextStyle(color: _color(organ.risk)),
          ),
        );
      }).toList(),
    );
  }
}
