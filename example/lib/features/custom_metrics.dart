/*
 * Copyright (c) 2021. AppDynamics LLC and its affiliates.
 * All rights reserved.
 *
 */

import 'package:appdynamics_mobilesdk/appdynamics_mobilesdk.dart';
import 'package:appdynamics_mobilesdk_example/utils/flush_beacons_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomMetrics extends StatelessWidget {
  final customMetricName = "myCustomMetric";
  final customMetricValue = 123;

  const CustomMetrics({Key? key}) : super(key: key);

  Future<void> _reportMetric() async {
    await Instrumentation.reportMetric(
        name: customMetricName, value: customMetricValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FlushBeaconsAppBar(title: "Custom metrics"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 50, left: 50),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              key: const Key("reportMetricButton"),
              child: Text(
                  'Report metric \n(name: $customMetricName, value: $customMetricValue)',
                  textAlign: TextAlign.center),
              onPressed: _reportMetric,
            ),
          ]),
        ),
      ),
    );
  }
}