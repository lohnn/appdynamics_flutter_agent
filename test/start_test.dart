/*
 * Copyright (c) 2021. AppDynamics LLC and its affiliates.
 * All rights reserved.
 *
 */

import 'package:appdynamics_mobilesdk/appdynamics_mobilesdk.dart';
import 'package:appdynamics_mobilesdk/src/agent-configuration.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

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

  test('start() is called natively', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      log.add(methodCall);
      switch (methodCall.method) {
        case 'start':
          return true;
      }
    });

    const appKey = "AA-BBB-CCC";
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    AgentConfiguration config = AgentConfiguration(appKey: appKey);
    await Instrumentation.start(config);

    expect(log, hasLength(1));
    expect(log, <Matcher>[
      isMethodCall(
        'start',
        arguments: <String, dynamic>{
          "appKey": appKey,
          "version": packageInfo.version,
          "loggingLevel": 0,
          "collectorURL": "https://mobile.eum-appdynamics.com",
          "anrDetectionEnabled": true,
          "anrStackTraceEnabled": true,
          "type": "Flutter",
        },
      ),
    ]);
  });

  test('start() native error is intercepted', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      throw PlatformException(
          code: "500", message: "start() threw native error.");
    });

    AgentConfiguration config = AgentConfiguration(appKey: "foo");
    expect(Instrumentation.start(config), throwsException);
  });
}
