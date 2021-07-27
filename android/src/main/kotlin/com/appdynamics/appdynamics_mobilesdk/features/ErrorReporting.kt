/*
 * Copyright (c) 2021. AppDynamics LLC and its affiliates.
 * All rights reserved.
 *
 */

package com.appdynamics.appdynamics_mobilesdk.features

import androidx.annotation.NonNull
import com.appdynamics.appdynamics_mobilesdk.AppDynamicsMobileSdkPlugin
import com.appdynamics.eumagent.runtime.Instrumentation
import io.flutter.plugin.common.MethodChannel

fun AppDynamicsMobileSdkPlugin.reportError(
    @NonNull result: MethodChannel.Result,
    arguments: Any?
) {
    val properties = arguments as HashMap<*, *>

    val message = properties["message"] as? String ?: run {
        result.error(
            "500",
            "reportError() failed.",
            "Please provide a valid message string."
        )
        return
    }

    val severityLevel = properties["severity"] as? Int ?: run {
        result.error(
            "500",
            "reportError() failed.",
            "Please provide a valid error severity level."
        )
        return
    }

    Instrumentation.reportError(Throwable(message), severityLevel)
    result.success(null)
}
