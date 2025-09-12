package com.example.hackathon2_app.view
import android.content.Context
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugin.common.StandardMessageCodec
import androidx.activity.ComponentActivity

class CustomNativeViewFactory(
    private val activity: ComponentActivity
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return CustomNativePlatformView(activity)  // ★ 同パッケージのクラスを参照
    }
}