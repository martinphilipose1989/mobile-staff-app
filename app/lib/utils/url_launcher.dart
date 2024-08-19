import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  // Private constructor to prevent instantiation.
  UrlLauncher._();

  static Future<void> _launch(
      Uri uri, BuildContext? context, String fallbackMessage) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context != null) {
        if (!context.mounted) return;
        _showFeedback(context, fallbackMessage);
      }
    }
  }

  static void _showFeedback(BuildContext? context, String message) {
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } else {
      if (kDebugMode) {
        log(message);
      }
    }
  }

  // Launches a URL in the default browser.
  static Future<void> launchURL(String url, {BuildContext? context}) async {
    final Uri uri = Uri.parse(url);
    await _launch(uri, context, 'Could not launch $url');
  }

  // Launches a URL in a webview.
  static Future<void> launchURLInWebView(String url,
      {BuildContext? context}) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.inAppWebView,
      );
    } else {
      if (context != null) {
        if (!context.mounted) return;
        _showFeedback(context, 'Could not launch $url');
      }
    }
  }

  // Launches an email.
  static Future<void> launchEmail(String email, {BuildContext? context}) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await _launch(emailLaunchUri, context, 'Could not launch $email');
  }

  // Launches a phone number.
  static Future<void> launchPhone(String phoneNumber,
      {BuildContext? context}) async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await _launch(phoneLaunchUri, context, 'Could not launch $phoneNumber');
  }
}
