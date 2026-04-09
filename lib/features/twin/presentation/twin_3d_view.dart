import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kittushealthgenie/core/platform_service.dart';
import 'package:kittushealthgenie/features/unity_view/presentation/unity_view.dart';

import '../application/twin_controller.dart';
import '../domain/twin_model.dart';

class Twin3DView extends ConsumerWidget {
  final void Function(String organ)? onOrganTap;

  const Twin3DView({super.key, this.onOrganTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final twin = ref.watch(twinProvider);

    return Stack(
      children: [
        // ========================
        // UNITY / 3D LAYER
        // ========================
        const Positioned.fill(
          child: UnityView(),
        ),

        // ========================
        // FALLBACK (WEB / DESKTOP)
        // ========================
        if (!PlatformService.isMobile)
          _FallbackOverlay(
            organs: twin.organs,
            selected: twin.selectedOrgan,
            onTap: (organ) {
              onOrganTap?.call(organ);
              ref.read(twinProvider.notifier).selectOrgan(organ);
            },
          ),
      ],
    );
  }
}

// ========================
// FALLBACK OVERLAY
// ========================
class _FallbackOverlay extends StatelessWidget {
  final List<OrganData> organs;
  final String? selected;
  final void Function(String organ) onTap;

  const _FallbackOverlay({
    required this.organs,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: organs.map((organ) {
        return _OrganMarker(
          label: organ.name,
          risk: organ.risk,
          isSelected: selected == organ.name,
          position: _getPosition(organ.name),
          onTap: () => onTap(organ.name),
        );
      }).toList(),
    );
  }

  Offset _getPosition(String organ) {
    switch (organ) {
      case "Heart":
        return const Offset(150, 220);
      case "Lungs":
        return const Offset(150, 150);
      case "Brain":
        return const Offset(150, 80);
      case "Liver":
        return const Offset(150, 300);
      default:
        return const Offset(100, 200);
    }
  }
}

// ========================
// ORGAN MARKER
// ========================
class _OrganMarker extends StatelessWidget {
  final String label;
  final double risk;
  final bool isSelected;
  final Offset position;
  final VoidCallback onTap;

  const _OrganMarker({
    required this.label,
    required this.risk,
    required this.isSelected,
    required this.position,
    required this.onTap,
  });

  Color _getColor(double risk) {
    if (risk > 0.7) return Colors.redAccent;
    if (risk > 0.4) return Colors.orangeAccent;
    return Colors.greenAccent;
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor(risk);

    return Positioned(
      top: position.dy,
      left: position.dx,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 200),
          scale: isSelected ? 1.2 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.85),
              borderRadius: BorderRadius.circular(12),
              border:
                  isSelected ? Border.all(color: Colors.white, width: 2) : null,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.5),
                  blurRadius: isSelected ? 12 : 6,
                ),
              ],
            ),
            child: Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
