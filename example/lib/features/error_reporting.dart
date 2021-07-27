/*
 * Copyright (c) 2021. AppDynamics LLC and its affiliates.
 * All rights reserved.
 *
 */

import 'dart:convert';

import 'package:appdynamics_mobilesdk/appdynamics_mobilesdk.dart';
import 'package:appdynamics_mobilesdk_example/utils/flush_beacons_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorReporting extends StatefulWidget {
  @override
  _ErrorReportingState createState() => _ErrorReportingState();
}

class _ErrorReportingState extends State<ErrorReporting> {
  Future<void> _sendError() async {
    try {
      final myMethod = null;
      myMethod();
    } on NoSuchMethodError catch (e) {
      await Instrumentation.reportError(e,
          severityLevel: ErrorSeverityLevel.CRITICAL);
    }
  }

  Future<void> _sendException() async {
    try {
      jsonDecode("invalid/exception/json");
    } on FormatException catch (e) {
      await Instrumentation.reportException(e,
          severityLevel: ErrorSeverityLevel.WARNING);
    }
  }

  Future<void> _sendMessage() async {
    try {
      jsonDecode("invalid/message/json");
    } on FormatException catch (e) {
      await Instrumentation.reportMessage(e.toString(),
          severityLevel: ErrorSeverityLevel.INFO);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FlushBeaconsAppBar(
        title: 'Report error',
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  key: Key("reportErrorButton"),
                  child: Text('Report error (critical)'),
                  onPressed: _sendError),
              ElevatedButton(
                  key: Key("reportExceptionButton"),
                  child: Text('Report exception (warning)'),
                  onPressed: _sendException),
              ElevatedButton(
                  key: Key("reportMessageButton"),
                  child: Text('Report message (info)'),
                  onPressed: _sendMessage),
            ],
          ),
        ),
      ),
    );
  }
}
