package com.example.hackathon2_app

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import com.example.hackathon2_app.view.CustomNativeViewFactory

class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val registry = flutterEngine.platformViewsController.registry
        registry.registerViewFactory(
            "expressive_loading",
            com.example.hackathon2_app.view.CustomNativeViewFactory(this)
        )
    }
}
