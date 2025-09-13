package com.example.hackathon2_app.view

import android.content.Context
import android.view.View
import io.flutter.plugin.platform.PlatformView
import io.flutter.embedding.android.FlutterActivity

class CustomNativeView(
    context: Context,
    viewId: Int,
    creationParams: Map<String, Any>?,
    private val activity: FlutterActivity
) : PlatformView {

    private val root = ProgressView(context)

    override fun getView(): View = root
    override fun dispose() {}
}