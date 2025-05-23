import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:momento_las_palmas/ver_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

Uri? extractFallbackUrl(String intentUrl) {
  final match = RegExp(
    r'S\.browser_fallback_url=([^;]+)',
  ).firstMatch(intentUrl);
  if (match == null) return null;
  final encoded = match.group(1)!;
  try {
    return Uri.parse(Uri.decodeComponent(encoded));
  } catch (_) {
    return null;
  }
}

Future<void> _showAppNotFoundDialog(BuildContext ctx) => showDialog(
    context: ctx,
    builder: (dialogCtx) => AlertDialog(
      title: const Text('Application not found'),
      content: const Text(
        'The required application is not installed on your device.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogCtx).pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );

Future<NavigationActionPolicy> handleDeepLinkIOS({
  required Uri uri,
  required InAppWebViewController controller,
  required BuildContext ctx,
}) async {
  final urlStr = uri.toString();
  final scheme = uri.scheme.toLowerCase();

  // 1) Crypto-схеми: копіюємо в Clipboard + SnackBar
  const cryptoSchemes = [
    'ethereum',
    'bitcoin',
    'litecoin',
    'tron',
    'bsc',
    'dogecoin',
    'bitcoincash',
    'tether',
  ];
  if (cryptoSchemes.contains(scheme)) {
    await Clipboard.setData(ClipboardData(text: urlStr));
    ScaffoldMessenger.of(ctx)
        .showSnackBar(const SnackBar(content: Text('Address copied')));
    return NavigationActionPolicy.CANCEL;
  }

  if (urlStr == 'about:blank') {
    return NavigationActionPolicy.CANCEL;
  }

  if (scheme == 'http' || scheme == 'https' || scheme == 'file') {
    return NavigationActionPolicy.ALLOW;
  }

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    await _showAppNotFoundDialog(ctx);
  }

  return NavigationActionPolicy.CANCEL;
}

class UrlWebViewApp extends StatefulWidget {
  final String url;
  final String? pushUrl;
  final bool openedByPush;

  const UrlWebViewApp({
    Key? key,
    required this.url,
    this.pushUrl,
    required this.openedByPush,
  }) : super(key: key);

  @override
  State<UrlWebViewApp> createState() => _UrlWebViewAppState();
}

class _UrlWebViewAppState extends State<UrlWebViewApp> {
  static const _chan = MethodChannel('app.camera/permission');
  late InAppWebViewController _webViewController;

  Future<bool> _askCamera() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  late String _webUrl;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        systemNavigationBarColor: Colors.black,
      ),
    );

    if (widget.openedByPush) {
      if (widget.pushUrl == null || widget.pushUrl!.isEmpty) {
        sendEvent('push_open_webview');
      } else {
        sendEvent('push_open_browser');
      }
      isPush = false;
    }

    _initialize();

    sendEvent('webview_open');

    _webUrl = widget.url;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.pushUrl?.isNotEmpty == true) {
        launchUrlString(widget.pushUrl!, mode: LaunchMode.externalApplication);
      }
    });
  }

  Future<void> _initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirst = prefs.getBool('is_first_launch') ?? true;

    if (isFirst) {
      final granted = prefs.getBool('permission_granted') ?? true;

      if (granted) {
        await sendEvent('push_subscribe');
      }

      prefs.setBool('is_first_launch', false);
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (innerCtx) {
          return PopScope<Object?>(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              _webViewController.canGoBack().then((canGoBack) {
                if (canGoBack) {
                  _webViewController.goBack();
                }
              });
            },
            child: Scaffold(
              backgroundColor: Colors.black,
              extendBody: false,
              body: SafeArea(
                top: true,
                bottom: true,
                child: InAppWebView(
                  // initialUrlRequest: URLRequest(url: WebUri(widget.url)),
                  initialUrlRequest:
                      URLRequest(url: WebUri('https://winspirit.com/')),
                  initialSettings: InAppWebViewSettings(
                    transparentBackground: true,
                    mediaPlaybackRequiresUserGesture: false,
                    allowsInlineMediaPlayback: true,
                    allowsBackForwardNavigationGestures: true,
                    javaScriptCanOpenWindowsAutomatically: true,
                    supportMultipleWindows: true,
                  ),
                  onWebViewCreated: (ctrl) => _webViewController = ctrl,
                  onPermissionRequest: (ctrl, req) async {
                    if (req.resources.contains(PermissionResourceType.CAMERA)) {
                      if (!await _askCamera()) {
                        return PermissionResponse(
                          resources: [],
                          action: PermissionResponseAction.DENY,
                        );
                      }
                    }
                    return PermissionResponse(
                      resources: req.resources,
                      action: PermissionResponseAction.GRANT,
                    );
                  },
                  shouldOverrideUrlLoading: (ctrl, navAction) async {
                    final uri = navAction.request.url;
                    if (uri == null) return NavigationActionPolicy.CANCEL;
                    return handleDeepLinkIOS(
                      uri: uri,
                      controller: ctrl,
                      ctx: context,
                    );
                  },
                  onCreateWindow: (controller, createReq) async {
                    final uri = createReq.request.url;
                    if (uri == null) return false;

                    final scheme = uri.scheme.toLowerCase();
                    final url = uri.toString();

                    if (scheme == 'http' || scheme == 'https') {
                      Navigator.of(innerCtx).push(
                        MaterialPageRoute(
                          builder: (_) => WebPopupScreen(initialUrl: url),
                        ),
                      );
                      debugPrint('>>>>> OPEN WebPopupScreen');
                      return false;
                    }

                    await handleDeepLinkIOS(
                      uri: uri,
                      controller: controller,
                      ctx: innerCtx,
                    );
                    return false;
                  },
                ),
              ),
              bottomNavigationBar: Container(
                height: 56,
                color: Colors.black87,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () async {
                        if (await _webViewController.canGoBack()) {
                          _webViewController.goBack();
                        }
                      },
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      onPressed: () {
                        _webViewController.reload();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
}

class WebPopupScreen extends StatefulWidget {
  final String initialUrl;

  const WebPopupScreen({Key? key, required this.initialUrl}) : super(key: key);

  @override
  State<WebPopupScreen> createState() => _WebPopupScreenState();
}

class _WebPopupScreenState extends State<WebPopupScreen> {
  late InAppWebViewController _popupController;

  @override
  Widget build(BuildContext context) => PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: false,
        body: SafeArea(
          top: true,
          bottom: false,
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.initialUrl)),
            initialSettings: InAppWebViewSettings(
              javaScriptCanOpenWindowsAutomatically: true,
              supportMultipleWindows: true,
              allowsBackForwardNavigationGestures: true,
            ),
            onWebViewCreated: (ctrl) => _popupController = ctrl,
            shouldOverrideUrlLoading: (ctrl, navAction) async {
              final uri = navAction.request.url;
              if (uri == null) return NavigationActionPolicy.CANCEL;
              return handleDeepLinkIOS(
                uri: uri,
                controller: ctrl,
                ctx: context,
              );
            },
            onCloseWindow: (ctrl) => Navigator.of(context).pop(),
          ),
        ),
        bottomNavigationBar: Container(
          height: 56,
          color: Colors.black87,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed: () {
                  _popupController.reload();
                },
              ),
            ],
          ),
        ),
      ),
    );
}
