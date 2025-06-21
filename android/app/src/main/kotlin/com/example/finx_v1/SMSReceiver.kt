package com.example.finx_v1

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.telephony.SmsMessage
import android.util.Log
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache

class SmsReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action == "android.provider.Telephony.SMS_RECEIVED") {
            val bundle: Bundle? = intent.extras
            if (bundle != null) {
                val pdus = bundle["pdus"] as Array<*>
                for (pdu in pdus) {
                    val format = bundle.getString("format")
                    val message = SmsMessage.createFromPdu(pdu as ByteArray, format)
                    val body = message.messageBody

                    // 🔁 Retrieve FlutterEngine
                    val flutterEngine = FlutterEngineCache.getInstance().get("my_engine_id")
                    if (flutterEngine != null) {
                        val channel = MethodChannel(
                            flutterEngine.dartExecutor.binaryMessenger,
                            "com.finx.sms/channel"
                        )
                        channel.invokeMethod("onSmsReceived", body)
                    } else {
                        Log.e("SmsReceiver", "FlutterEngine not found")
                    }
                }
            }
        }
    }
}
