import 'package:app/navigation/route_paths.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:domain/domain.dart' hide State;

import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutePaths.dashboard);
            },
            child: SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width - 100,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.house,
                      color: Theme.of(context).primaryColor,
                    ),
                    CommonText(
                      text: "Gate Management",
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              //  Navigator.pushNamed(context, RoutePaths.myDutyPage);
              Navigator.pushNamed(context, RoutePaths.busRouteDetailsPage,
                  arguments: StopModel());
            },
            child: SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width - 100,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.fire_truck,
                      color: Theme.of(context).primaryColor,
                    ),
                    CommonText(
                      text: "Transport",
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
