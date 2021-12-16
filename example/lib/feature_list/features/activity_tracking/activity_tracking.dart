/*
 * Copyright (c) 2021. AppDynamics LLC and its affiliates.
 * All rights reserved.
 *
 */

import 'package:appdynamics_mobilesdk/appdynamics_mobilesdk.dart';
import 'package:appdynamics_mobilesdk_example/feature_list/utils/flush_beacons_app_bar.dart';
import 'package:appdynamics_mobilesdk_example/routing/route_paths.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityTracking extends StatefulWidget {
  const ActivityTracking({Key? key}) : super(key: key);

  @override
  _ActivityTrackingState createState() => _ActivityTrackingState();
}

class _ActivityTrackingState extends State<ActivityTracking> {
  _pushScreen() async {
    await Navigator.pushNamed(context, RoutePaths.activityTrackingPush);
  }

  _replaceScreen() async {
    WidgetTracker.instance.trackWidgetStart("MyScreen");
    await Navigator.pushReplacementNamed(
        context, RoutePaths.activityTrackingReplace);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FlushBeaconsAppBar(title: "Activity Tracking"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            ElevatedButton(
              key: const Key("pushScreenButton"),
              child: const Text('Screen push'),
              onPressed: _pushScreen,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              key: const Key("replaceScreenButton"),
              child: const Text('Screen replace'),
              onPressed: _replaceScreen,
            ),
          ]),
        ),
      ),
    );
  }
}