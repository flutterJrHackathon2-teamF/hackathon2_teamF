package com.example.hackathon2_app.view

import android.content.Context
import android.view.View
import android.widget.FrameLayout
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.platform.ComposeView
import androidx.compose.ui.unit.dp
import androidx.compose.ui.Alignment
import androidx.compose.foundation.layout.*

class ProgressView(context: Context) : FrameLayout(context) {

    init {
        val composeView = ComposeView(context).apply {
            setContent {
                MaterialTheme {
                    StandardLoading()
                }
            }
        }
        addView(composeView,
            LayoutParams(
                LayoutParams.MATCH_PARENT,
                LayoutParams.MATCH_PARENT
            )
        )
    }
    
    fun startProgress() {
        // Implementation for starting progress
    }
    
    fun stopProgress() {
        // Implementation for stopping progress
    }
}

@Composable
fun StandardLoading(
    modifier: androidx.compose.ui.Modifier = androidx.compose.ui.Modifier
) {
    Column(
        modifier = modifier
            .fillMaxWidth()
            .wrapContentHeight()
            .padding(32.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        CircularProgressIndicator(
            modifier = androidx.compose.ui.Modifier.size(48.dp),
            color = MaterialTheme.colorScheme.primary
        )
    }
}