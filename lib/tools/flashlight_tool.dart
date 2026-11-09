import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

import '../core/l10n.dart';

class FlashlightTool extends StatefulWidget {
  const FlashlightTool({super.key});

  @override
  State<FlashlightTool> createState() => _FlashlightToolState();
}

class _FlashlightToolState extends State<FlashlightTool> {
  bool _on = false;
  String? _error;

  Future<void> _toggle() async {
    try {
      if (_on) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }
      if (!mounted) return;
      setState(() {
        _on = !_on;
        _error = null;
      });
    } catch (_) {
      if (mounted) setState(() => _error = context.l10n.flashError);
    }
  }

  @override
  void dispose() {
    if (_on) TorchLight.disableTorch().catchError((_) {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l.toolFlashlight)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _toggle,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _on ? Colors.amber : scheme.surfaceContainerHighest,
                  boxShadow: _on
                      ? [BoxShadow(color: Colors.amber.withValues(alpha: .6), blurRadius: 60, spreadRadius: 10)]
                      : null,
                ),
                child: Icon(
                  _on ? Icons.flashlight_on_rounded : Icons.flashlight_off_rounded,
                  size: 84,
                  color: _on ? Colors.black87 : scheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(_on ? l.flashOn : l.flashOff, style: Theme.of(context).textTheme.headlineSmall),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(_error!, style: TextStyle(color: scheme.error)),
              ),
          ],
        ),
      ),
    );
  }
}
