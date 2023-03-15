import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WithRiverpodScreen extends ConsumerStatefulWidget {
  const WithRiverpodScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WithRiverpodScreenState();
}

class _WithRiverpodScreenState extends ConsumerState<WithRiverpodScreen> {
  OverlayEntry? overlay;

  @override
  void dispose() {
    removeOverlay();
    super.dispose();
  }

  void removeOverlay() {
    if (overlay != null) {
      overlay!.remove();
    }
  }

  void createOverlay(BuildContext context) {
    overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withOpacity(0.5),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
    Overlay.of(context).insert(overlay!);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(loginControllerProvider, (_, current) {
      if (current.isLoading) {
        createOverlay(context);
      } else {
        removeOverlay();
      }
    });

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('With Riverpod'),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () async {
              await ref.read(loginControllerProvider.notifier).login();
            },
            child: const Text('Show Overlay'),
          ),
        ],
      ),
    );
  }
}

class LoginController extends StateNotifier<AsyncValue<void>> {
  LoginController() : super(const AsyncData(null));

  Future<void> login() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(
        const Duration(seconds: 3),
      );
    });
  }
}

final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, AsyncValue<void>>(
  (ref) => LoginController(),
);
