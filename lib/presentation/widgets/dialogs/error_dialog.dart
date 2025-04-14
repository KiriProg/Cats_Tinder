import 'package:flutter/material.dart';

typedef RetryCallback = Future<void> Function();

Future<void> showNetworkErrorDialog({
  required BuildContext context,
  required RetryCallback onRetry,
}) async {
  bool isLoading = false;

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text(
              'Network Error',
              style: TextStyle(color: Colors.white),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  )
                else ...[
                  const Icon(
                    Icons.wifi_off,
                    size: 50,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Failed to connect to the server. Please check your internet connection and try again.',
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
            actions: [
              if (!isLoading) ...[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    setState(() => isLoading = true);
                    try {
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                      await onRetry();
                    } finally {
                      if (context.mounted) {
                        setState(() => isLoading = false);
                      }
                    }
                  },
                  child: const Text('Retry'),
                ),
              ],
            ],
          );
        },
      );
    },
  );
}
