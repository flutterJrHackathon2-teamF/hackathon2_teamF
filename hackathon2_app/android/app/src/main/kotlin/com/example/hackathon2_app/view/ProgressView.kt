package com.example.hackathon2_app.view

import android.content.Context
import android.view.View
import android.widget.FrameLayout
import androidx.activity.ComponentActivity
import androidx.compose.animation.core.CubicBezierEasing
import androidx.compose.animation.core.LinearEasing
import androidx.compose.animation.core.animateFloat
import androidx.compose.animation.core.infiniteRepeatable
import androidx.compose.animation.core.rememberInfiniteTransition
import androidx.compose.animation.core.tween
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.size
import androidx.compose.material3.ExperimentalMaterial3ExpressiveApi
import androidx.compose.material3.CircularWavyProgressIndicator
import androidx.compose.material3.LinearWavyProgressIndicator
import androidx.compose.material3.MaterialExpressiveTheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.WavyProgressIndicatorDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.ComposeView
import androidx.compose.ui.platform.ViewCompositionStrategy
import androidx.compose.ui.unit.dp
import androidx.lifecycle.findViewTreeLifecycleOwner
import androidx.lifecycle.setViewTreeLifecycleOwner
import androidx.lifecycle.findViewTreeViewModelStoreOwner
import androidx.lifecycle.setViewTreeViewModelStoreOwner
import androidx.savedstate.findViewTreeSavedStateRegistryOwner
import androidx.savedstate.setViewTreeSavedStateRegistryOwner
import io.flutter.plugin.platform.PlatformView

/**
 * Legacy View wrapper that hosts the expressive indicator via Compose.
 * Useful if other code refers to ProgressView directly.
 */
class ProgressView(context: Context) : FrameLayout(context) {
  init {
    val composeView = ComposeView(context).apply {
      setViewCompositionStrategy(ViewCompositionStrategy.DisposeOnDetachedFromWindowOrReleasedFromPool)
      setContent { MaterialTheme { Material3ExpressiveLoadingIndicator() } }
    }
    addView(
      composeView,
      LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT)
    )
  }
  fun startProgress() {}
  fun stopProgress() {}
}

/**
 * Flutter PlatformView implementation that renders the expressive indicator.
 * Sets ViewTree owners so Compose can create a Recomposer safely.
 */
class CustomNativePlatformView(
  private val activity: ComponentActivity,
) : PlatformView {
  private val composeView: ComposeView = ComposeView(activity).apply {
    setViewTreeLifecycleOwner(activity)
    setViewTreeSavedStateRegistryOwner(activity)
    setViewTreeViewModelStoreOwner(activity)
    setViewCompositionStrategy(ViewCompositionStrategy.DisposeOnViewTreeLifecycleDestroyed)
    setContent { MaterialTheme { Material3ExpressiveLoadingIndicator() } }
  }
  override fun getView(): View = composeView
  override fun dispose() { /* no-op */ }
}

@OptIn(ExperimentalMaterial3ExpressiveApi::class)
@Composable
fun Material3ExpressiveLoadingIndicator(
  modifier: Modifier = Modifier,
  size: androidx.compose.ui.unit.Dp = 48.dp
) {
  MaterialExpressiveTheme {
    Box(modifier = modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
      CircularWavyProgressIndicator(
        modifier = Modifier.size(size),
        // Use defaults aligned with the spec
        color = WavyProgressIndicatorDefaults.indicatorColor,
        trackColor = WavyProgressIndicatorDefaults.trackColor,
        stroke = WavyProgressIndicatorDefaults.circularIndicatorStroke,
        trackStroke = WavyProgressIndicatorDefaults.circularTrackStroke,
        gapSize = WavyProgressIndicatorDefaults.CircularIndicatorTrackGapSize,
        amplitude = 1f, // indeterminate expressive ring
        wavelength = WavyProgressIndicatorDefaults.CircularWavelength,
        waveSpeed = WavyProgressIndicatorDefaults.CircularWavelength,
      )
    }
  }
}

@OptIn(ExperimentalMaterial3ExpressiveApi::class)
@Composable
fun Material3ExpressiveLinearLoadingIndicator(
  modifier: Modifier = Modifier
) {
  MaterialExpressiveTheme {
    LinearWavyProgressIndicator(
      modifier = modifier,
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