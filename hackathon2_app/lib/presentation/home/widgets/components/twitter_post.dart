import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../utils/color.dart';

class TwitterTimeline extends StatefulWidget {
  final String username; // 例: 'TwitterDev'（@は付けない）
  final bool dark; // ダークテーマにしたい場合 true

  const TwitterTimeline({super.key, required this.username, this.dark = false});

  @override
  State<TwitterTimeline> createState() => _TwitterTimelineState();
}

class _TwitterTimelineState extends State<TwitterTimeline> {
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

    print('TwitterTimeline: Platform supported: $isSupportedPlatform');
    print('TwitterTimeline: Current platform: $defaultTargetPlatform');
    print('TwitterTimeline: Is Web: $kIsWeb');

    if (!isSupportedPlatform) {
      print('TwitterTimeline: Platform not supported, showing fallback');
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
                print('TwitterTimeline: Page started loading: $url');
                setState(() {
                  isLoading = true;
                  hasError = false;
                });
              },
              onPageFinished: (url) {
                print('TwitterTimeline: Page finished loading: $url');
                setState(() {
                  isLoading = false;
                });
                // Improve scroll behavior
                _controller?.runJavaScript(r"""
                  document.documentElement.style.overscrollBehavior = 'contain';
                  document.body.style.overscrollBehavior = 'contain';
                """);
              },
              onWebResourceError: (error) {
                print('TwitterTimeline: WebView error: ${error.description}');
                print('TwitterTimeline: Error code: ${error.errorCode}');
                if (!_useMobileFallback) {
                  print('TwitterTimeline: Trying mobile fallback');
                  _useMobileFallback = true;
                  _controller?.loadRequest(
                    Uri.parse('https://mobile.twitter.com/${widget.username}'),
                  );
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
                print('TwitterTimeline: Intercept non-http(s) url => $url');
                _handleExternalUrl(url);
                return NavigationDecision.prevent;
              },
            ),
          )
          ..loadRequest(Uri.parse('https://x.com/${widget.username}'));
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
      print('TwitterTimeline: launch external url failed: $e');
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
            final profileUrl = Uri.parse('https://x.com/${widget.username}');
            launchUrl(profileUrl, mode: LaunchMode.externalApplication);
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.open_in_browser, size: 48, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  'X (Twitter) Timeline',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  '@${widget.username}',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
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
                  'X Timeline Loading Failed',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  '@${widget.username}',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
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
                Positioned.fill(child: WebViewWidget(controller: _controller!)),
              if (isLoading)
                Container(
                  color: AppColor.white,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
