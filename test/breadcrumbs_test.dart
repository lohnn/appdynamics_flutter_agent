/*
 * Copyright (c) 2021. AppDynamics LLC and its affiliates.
 * All rights reserved.
 *
 */

import 'package:appdynamics_mobilesdk/appdynamics_mobilesdk.dart';
import 'package:appdynamics_mobilesdk/src/agent_configuration.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'globals.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final List<MethodCall> log = <MethodCall>[];

  setUp(() {
    mockPackageInfo();
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('breadcrumbs are called natively', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'leaveBreadcrumb':
          log.add(methodCall);
          return null;
      }
    });

    const appKey = "AA-BBB-CCC";
    AgentConfiguration config = AgentConfiguration(appKey: appKey);
    await Instrumentation.start(config);

    final breadcrumb = "My breadcrumb";
    final crashSeverityLevel = BreadcrumbVisibility.CRASHES_ONLY;
    final crashSessionSeverityLevel = BreadcrumbVisibility.CRASHES_AND_SESSIONS;

    Instrumentation.leaveBreadcrumb(breadcrumb, crashSeverityLevel);
    Instrumentation.leaveBreadcrumb(breadcrumb, crashSessionSeverityLevel);

    expect(log, hasLength(2));
    expect(log, <Matcher>[
      isMethodCall('leaveBreadcrumb', arguments: {
        "breadcrumb": breadcrumb,
        "mode": crashSeverityLevel.index
      }),
      isMethodCall('leaveBreadcrumb', arguments: {
        "breadcrumb": breadcrumb,
        "mode": crashSessionSeverityLevel.index
      })
    ]);
  });
}