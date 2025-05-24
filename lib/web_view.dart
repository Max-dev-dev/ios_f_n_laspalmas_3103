import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:momento_las_palmas/ver_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:permission_handler/permission_handler.dart';

Uri? extractFallbackUrl(String intentUrl) {
  final match = RegExp(r'S\.browser_fallback_url=([^;]+)').firstMatch(intentUrl);
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
  builder: (dCtx) => AlertDialog(
    title: const Text('Application not found'),
    content: const Text(
      'The required application is not installed on your device.',
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(dCtx).pop(),
        child: const Text('OK'),
      ),
    ],
  ),
);

Future<NavigationActionPolicy> handleDeepLink({
  required Uri uri,
  required InAppWebViewController controller,
  required BuildContext ctx,
}) async {
  final urlStr = uri.toString();
  final scheme = uri.scheme.toLowerCase();

  if (urlStr.startsWith('about:') || scheme == 'javascript') {
    return NavigationActionPolicy.CANCEL;
  }

  const cryptoSchemes = [
    'ethereum','bitcoin','litecoin','tron',
    'bsc','dogecoin','bitcoincash','tether',
  ];
  if (cryptoSchemes.contains(scheme)) {
    await Clipboard.setData(ClipboardData(text: urlStr));
    ScaffoldMessenger.of(ctx)
        .showSnackBar(const SnackBar(content: Text('Address copied')));
    return NavigationActionPolicy.CANCEL;
  }

  const socialFallback = <String, String>{
    'fb':        'https://www.facebook.com/',
    'instagram':'https://www.instagram.com/',
    'twitter':   'https://twitter.com/',
    'x':         'https://twitter.com/',
    'whatsapp':  'https://wa.me/',
  };
  if (socialFallback.containsKey(scheme)) {
    if (await canLaunchUrlString(urlStr)) {
      await launchUrlString(urlStr, mode: LaunchMode.externalApplication);
    } else {
      final webUrl = urlStr.replaceFirst(
        '$scheme://', socialFallback[scheme]!,
      );
      await launchUrlString(webUrl, mode: LaunchMode.externalApplication);
    }
    return NavigationActionPolicy.CANCEL;
  }

  if (scheme == 'http' || scheme == 'https' || scheme == 'file') {
    return NavigationActionPolicy.ALLOW;
  }

  if (urlStr.startsWith('intent://')) {
    final fallbackUri = extractFallbackUrl(urlStr);
    if (await canLaunchUrlString(urlStr)) {
      await launchUrlString(urlStr, mode: LaunchMode.externalApplication);
    } else if (fallbackUri != null) {
      await controller.loadUrl(
        urlRequest: URLRequest(url: WebUri(fallbackUri.toString())),
      );
    } else {
      await _showAppNotFoundDialog(ctx);
    }
    return NavigationActionPolicy.CANCEL;
  }

  if (await canLaunchUrlString(urlStr)) {
    await launchUrlString(urlStr, mode: LaunchMode.externalApplication);
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
  Widget build(BuildContext context) {
    return WillPopScope(
      // ловимо swipe-back і системний back
      onWillPop: () async {
        if (await _webViewController.canGoBack()) {
          _webViewController.goBack();
          return false; // не робити ще одного pop
        }
        return true; // вийти з цієї сторінки
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          top: true,
          bottom: true,
          child: InAppWebView(
            // initialUrlRequest: URLRequest(url: WebUri(widget.url)),
            initialUrlRequest: URLRequest(url: WebUri('https://winspirit.com/')),
            initialSettings: InAppWebViewSettings(
              transparentBackground: true,
              mediaPlaybackRequiresUserGesture: false,
              allowsInlineMediaPlayback: true,
              allowsBackForwardNavigationGestures: true,
              javaScriptCanOpenWindowsAutomatically: true,
              supportMultipleWindows: false,
              useShouldOverrideUrlLoading: true,
              userAgent:
              "Mozilla/5.0 (iPhone; CPU iPhone OS 17_2_1 like Mac OS X) "
                  "AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.2 "
                  "Mobile/15E148 Safari/604.1",
            ),
            onWebViewCreated: (ctrl) => _webViewController = ctrl,
            onPermissionRequest: (controller, request) async {
              final granted = <PermissionResourceType>[];
              if (request.resources.contains(PermissionResourceType.CAMERA)) {
                granted.add(PermissionResourceType.CAMERA);
              }
              if (request.resources.contains(PermissionResourceType.MICROPHONE)) {
                granted.add(PermissionResourceType.MICROPHONE);
              }
              return PermissionResponse(
                resources: granted,
                action: granted.isEmpty
                    ? PermissionResponseAction.DENY
                    : PermissionResponseAction.GRANT,
              );
            },
            shouldOverrideUrlLoading: (controller, nav) async {
              final uri = nav.request.url!;
              final host = uri.host.toLowerCase();
              // приклад popup для банків:
              if ((host.contains('express-connect.com') ||
                  host.contains('mobile.rbcroyalbank.com')) &&
                  (uri.scheme == 'http' || uri.scheme == 'https')) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => WebPopupScreen(initialUrl: uri.toString()),
                ));
                return NavigationActionPolicy.CANCEL;
              }
              // інші deep-link-и
              return handleDeepLink(
                uri: uri,
                controller: controller,
                ctx: context,
              );
            },
            onCreateWindow: (controller, createReq) async {
              final uri = createReq.request.url;
              if (uri == null) return false;
              await handleDeepLink(
                uri: uri,
                controller: controller,
                ctx: context,
              );
              return true;
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
                onPressed: () => _webViewController.reload(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// === Popup-екран ===
class WebPopupScreen extends StatefulWidget {
  final String initialUrl;
  const WebPopupScreen({Key? key, required this.initialUrl}) : super(key: key);

  @override
  State<WebPopupScreen> createState() => _WebPopupScreenState();
}

class _WebPopupScreenState extends State<WebPopupScreen> {
  late InAppWebViewController _popupController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // свайп-back або фізична кнопка => один pop
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          top: true,
          bottom: true,
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.initialUrl)),
            initialSettings: InAppWebViewSettings(
              javaScriptCanOpenWindowsAutomatically: true,
              supportMultipleWindows: true,
              allowsBackForwardNavigationGestures: true,
              useShouldOverrideUrlLoading: true,
            ),
            onWebViewCreated: (ctrl) => _popupController = ctrl,
            shouldOverrideUrlLoading: (controller, nav) =>
                handleDeepLink(
                  uri: nav.request.url!,
                  controller: controller,
                  ctx: context,
                ),
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
                onPressed: () => Navigator.of(context).pop(),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed: () => _popupController.reload(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}