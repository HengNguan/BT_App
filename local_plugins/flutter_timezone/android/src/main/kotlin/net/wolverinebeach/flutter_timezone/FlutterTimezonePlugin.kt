package net.wolverinebeach.flutter_timezone

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.TimeZone

class FlutterTimezonePlugin: FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "flutter_timezone")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getLocalTimezone" -> {
                try {
                    val timezone = TimeZone.getDefault().id
                    result.success(timezone)
                } catch (e: Exception) {
                    result.error("ERR", e.message, null)
                }
            }
            "getAvailableTimezones" -> {
                try {
                    val timezones = TimeZone.getAvailableIDs().toList()
                    result.success(timezones)
                } catch (e: Exception) {
                    result.error("ERR", e.message, null)
                }
            }
            else -> result.notImplemented()
        }
    }
}