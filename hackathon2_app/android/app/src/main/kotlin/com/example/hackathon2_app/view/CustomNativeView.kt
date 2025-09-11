package com.example.hackathon2_app.view
import android.content.Context
import android.view.View
import io.flutter.plugin.platform.PlatformView
import java.util.*

class CustomNativeView(
    context: Context,
    id: Int, creationParams: Map<String?, Any?>?
) : PlatformView {
    private val progressView: ProgressView

    override fun getView(): View {
        return progressView
    }

    override fun dispose() {
        progressView.stopProgress();
    }

    init {
        progressView = ProgressView(context)
        progressView.startProgress();
    }
}