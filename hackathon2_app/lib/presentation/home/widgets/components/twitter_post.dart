import 'dart:developer';

import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, Factory;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../utils/color.dart';
import '../../../../widgets/linear_wavy_progress.dart';

class SocialMediaEmbed extends StatefulWidget {
  final String url; // 表示するURL
  final bool dark; // ダークテーマにしたい場合 true
  final String title; // 表示タイトル

  const SocialMediaEmbed({
    super.key, 
    required this.url, 
    this.dark = false,
    this.title = 'Social Media'
  });

  @override
  State<SocialMediaEmbed> createState() => _SocialMediaEmbedState();
}

class _SocialMediaEmbedState extends State<SocialMediaEmbed> {
  WebViewController? _controller;
  bool isLoading = true;
  bool hasError = false;
  bool _useMobileFallback = false;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    final isSupportedPlatform =
        !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS);

    if (!isSupportedPlatform) {
      return;
    }
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setUserAgent(
            'Mozilla/5.0 (Linux; Android 10; SM-G973F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.120 Mobile Safari/537.36',
          )
          ..enableZoom(true)
          ..setBackgroundColor(Colors.transparent)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) {
                setState(() {
                  isLoading = true;
                  hasError = false;
                });
              },
              onPageFinished: (url) {
                setState(() {
                  isLoading = false;
                });
                // Improve scroll behavior and touch handling
                _controller?.runJavaScript(r"""
                  document.documentElement.style.overscrollBehavior = 'contain';
                  document.body.style.overscrollBehavior = 'contain';
                  document.documentElement.style.touchAction = 'pan-y';
                  document.body.style.touchAction = 'pan-y';
                  document.documentElement.style.webkitOverflowScrolling = 'touch';
                  document.body.style.webkitOverflowScrolling = 'touch';
                """);
              },
              onWebResourceError: (error) {
                if (!_useMobileFallback) {
                  _useMobileFallback = true;
                  // Try mobile fallback if it's Twitter/X
                  if (widget.url.contains('x.com') || widget.url.contains('twitter.com')) {
                    final username = widget.url.split('/').last;
                    _controller?.loadRequest(
                      Uri.parse('https://mobile.twitter.com/$username'),
                    );
                  }
                } else {
                  setState(() {
                    isLoading = false;
                    hasError = true;
                  });
                }
              },
              onNavigationRequest: (NavigationRequest request) {
                final url = request.url;
                // Allow navigation within Twitter/X domains and external links
                if (url.startsWith('http://') || url.startsWith('https://')) {
                  return NavigationDecision.navigate;
                }
                // Handle non-http(s) schemes like intent://, twitter://, mailto:, tel:, etc.
                _handleExternalUrl(url);
                return NavigationDecision.prevent;
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.url));
  }

  Future<void> _handleExternalUrl(String raw) async {
    try {
      // Handle intent:// specially: try to extract browser_fallback_url
      if (raw.startsWith('intent://')) {
        // Simple extraction of fallback if present
        final parts = raw.split('S.browser_fallback_url=');
        if (parts.length > 1) {
          final encoded = parts[1].split(';').first;
          final decoded = Uri.decodeComponent(encoded);
          final fallback = Uri.tryParse(decoded);
          if (fallback != null) {
            await launchUrl(fallback, mode: LaunchMode.externalApplication);
            return;
          }
        }
        // If no fallback, just ignore (prevents crash)
        return;
      }
      final uri = Uri.tryParse(raw);
      if (uri != null) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      log('TwitterTimeline: launch external url failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSupportedPlatform =
        !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS);

    if (!isSupportedPlatform) {
      return Container(
        height: 400,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColor.card,
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            final profileUrl = Uri.parse(widget.url);
            launchUrl(profileUrl, mode: LaunchMode.externalApplication);
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.open_in_browser, size: 48, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.url,
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  '現在のプラットフォームではWebView未対応\nタップしてブラウザで開く',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (hasError) {
      return Container(
        height: 400,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColor.card,
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Retry loading
            setState(() {
              hasError = false;
              isLoading = true;
              _useMobileFallback = false;
            });
            _initializeWebView();
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.refresh, color: Colors.orange, size: 48),
                const SizedBox(height: 16),
                Text(
                  '${widget.title} Loading Failed',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.url,
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'タップして再試行またはブラウザで開く',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      height: 500,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            // Consume scroll notifications to prevent parent ListView interference
            return true;
          },
          child: Stack(
            children: [
              if (_controller != null)
                Positioned.fill(
                  child: WebViewWidget(
                    controller: _controller!,
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<VerticalDragGestureRecognizer>(
                        () =>
                            VerticalDragGestureRecognizer()..onUpdate = (_) {},
                      ),
                      Factory<HorizontalDragGestureRecognizer>(
                        () =>
                            HorizontalDragGestureRecognizer()
                              ..onUpdate = (_) {},
                      ),
                      Factory<TapGestureRecognizer>(
                        () => TapGestureRecognizer(),
                      ),
                    },
                  ),
                ),
              if (isLoading)
                Container(
                  color: AppColor.white.withValues(alpha: 0.9),
                  child: Center(
                    child: SizedBox(
                      width: 200,
                      child: LinearWavyProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
