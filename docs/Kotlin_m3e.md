## ローディング画面実装
- Jetpack Composeで実装
- ネイティブの呼び出しとFlutterコンポーネントを使用して実装
```dart
AndroidView(
        viewType: 'expressive_loading',
        layoutDirection: TextDirection.ltr,
        creationParams: <String, dynamic>{
          'color': (color ?? Theme.of(context).colorScheme.primary.value),
          'size': size,
          'progress': progress,
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
```

- Material3 Expressive実装
- Droid Kaigiのセッションがきっかけ
