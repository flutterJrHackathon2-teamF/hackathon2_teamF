package com.example.hackathon2_app.view

import android.content.Context
import androidx.activity.ComponentActivity
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class LinearWavyViewFactory(
    private val activity: ComponentActivity
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    
    override fun create(
        context: Context,
        viewId: Int,
        args: Any?
    ): PlatformView {
        val creationParams = args as? Map<String, Any?>
        return LinearWavyPlatformView(activity, creationParams)
    }
}