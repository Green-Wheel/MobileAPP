import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/serializers/maps.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../utils/map_utils.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;
  final Direction? routeInfo;

  const PanelWidget(
      {Key? key,
      required this.controller,
      required this.panelController,
      this.routeInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.zero,
        controller: controller,
        children: [
          SizedBox(height: 12),
          buildDragHandle(),
          SizedBox(height: 12),
          buildAboutText(context),
          SizedBox(height: 24),
        ],
      );

  Widget buildAboutText(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  routeInfo != null
                      ? "${routeInfo!.duration} (${routeInfo!.distance})"
                      : '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                TextButton.icon(
                  onPressed: () {
                    panelController.close();
                    GoRouter.of(context).go('/');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  icon: Icon(Icons.close),
                  label: Text('Cancelar'),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'La ruta más rapida segun el trafico',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Row(children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.navigation_outlined),
                label: Text("Iniciar"),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              SizedBox(width: 10),
              TextButton.icon(
                onPressed: () {
                  routeInfo != null
                      ? MapUtils.openMap(routeInfo!.endLocation.lat,
                          routeInfo!.endLocation.lng)
                      : null;
                },
                icon: Icon(Icons.map_sharp),
                label: Text("Obrir a Maps"),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.green,
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.green),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 12),
            Text(
              'Indicaciones',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              routeInfo != null ? formatSteps(routeInfo) : '',
            ),
          ],
        ),
      );

  Widget buildDragHandle() => GestureDetector(
        onTap: togglePanel,
        child: Center(
          child: Container(
            width: 30,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();

  formatSteps(Direction? routeInfo) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    String steps = '';
    if (routeInfo != null) {
      for (var step in routeInfo.steps) {
        steps += step.htmlInstructions.replaceAll(exp, '') + '\n\n';
      }
    }
    return steps;
  }
}
