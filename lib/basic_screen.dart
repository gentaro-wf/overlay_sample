import 'package:flutter/material.dart';

class BasicPage extends StatefulWidget {
  const BasicPage({super.key});

  @override
  State<BasicPage> createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> {
  OverlayEntry? overlay;

  @override
  void dispose() {
    if (overlay != null) {
      overlay!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Basic'),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                // オーバーレイ作成
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
                // オーバーレイを挿入
                Overlay.of(context).insert(overlay!);

                // ログイン処理をしていると仮定
                await Future.delayed(const Duration(seconds: 3));

                // オーバーレイを削除
                overlay!.remove();
                overlay = null;
              },
              child: const Text('Show Overlay'),
            ),
          ],
        ),
      ),
    );
  }
}
