import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_links/uni_links.dart';
import 'package:travel_hub/core/utils/app_router.dart';

class DeepLinkListener extends StatefulWidget {
  final Widget child;

  const DeepLinkListener({
    super.key,
    required this.child,
  });

  @override
  State<DeepLinkListener> createState() => _DeepLinkListenerState();
}

class _DeepLinkListenerState extends State<DeepLinkListener> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _initUniLinks();
  }

  Future<void> _initUniLinks() async {
    try {
      final initialUri = await getInitialUri();
      if (initialUri != null) {
        _handleUri(initialUri);
      }
    } catch (_) {}

    _sub = uriLinkStream.listen((uri) {
      if (uri != null) {
        _handleUri(uri);
      }
    }, onError: (err) {});
  }

  void _handleUri(Uri uri) {
    final mode = uri.queryParameters['mode'];
    final oobCode = uri.queryParameters['oobCode'];

    if (mode == 'resetPassword' && oobCode != null && mounted) {
      GoRouter.of(context).go(
        AppRouter.kreset,
        extra: oobCode,
      );
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
