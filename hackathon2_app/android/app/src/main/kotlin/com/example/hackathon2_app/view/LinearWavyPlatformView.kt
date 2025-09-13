package com.example.hackathon2_app.view

import android.content.Context
import android.view.View
import androidx.activity.ComponentActivity
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.material3.ExperimentalMaterial3ExpressiveApi
import androidx.compose.material3.LinearWavyProgressIndicator
import androidx.compose.material3.MaterialExpressiveTheme
import androidx.compose.material3.WavyProgressIndicatorDefaults
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.ComposeView
import androidx.compose.ui.platform.ViewCompositionStrategy
import androidx.lifecycle.setViewTreeLifecycleOwner
import androidx.lifecycle.setViewTreeViewModelStoreOwner
import androidx.savedstate.setViewTreeSavedStateRegistryOwner
import io.flutter.plugin.platform.PlatformView

@OptIn(ExperimentalMaterial3ExpressiveApi::class)
class LinearWavyPlatformView(
    private val activity: ComponentActivity,
    private val creationParams: Map<String, Any?>?
) : PlatformView {
    private val composeView: ComposeView = ComposeView(activity).apply {
        setViewTreeLifecycleOwner(activity)
        setViewTreeSavedStateRegistryOwner(activity)
        setViewTreeViewModelStoreOwner(activity)
        setViewCompositionStrategy(ViewCompositionStrategy.DisposeOnViewTreeLifecycleDestroyed)
        setContent {
            MaterialExpressiveTheme {
                LinearWavyProgressIndicator(
                    modifier = Modifier.fillMaxWidth(),  
                    color = WavyProgressIndicatorDefaults.indicatorColor,
                    trackColor = WavyProgressIndicatorDefaults.trackColor,
                    stroke = WavyProgressIndicatorDefaults.linearIndicatorStroke,
                    trackStroke = WavyProgressIndicatorDefaults.linearTrackStroke,
                    gapSize = WavyProgressIndicatorDefaults.LinearIndicatorTrackGapSize,
                    amplitude = 1f,
                    wavelength = WavyProgressIndicatorDefaults.LinearIndeterminateWavelength,
                    waveSpeed = WavyProgressIndicatorDefaults.LinearIndeterminateWavelength,
                )
            }
        }
    }
    
    override fun getView(): View = composeView
    override fun dispose() { /* no-op */ }
}