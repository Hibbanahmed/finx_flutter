package com.example.finx_v1

import android.content.IntentFilter
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // ✅ Register engine with an ID for broadcast receiver
        FlutterEngineCache
            .getInstance()
            .put("my_engine_id", flutterEngine)

        // ✅ Register plugins
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val filter = IntentFilter("android.provider.Telephony.SMS_RECEIVED")
        registerReceiver(SmsReceiver(), filter)
    }
}
