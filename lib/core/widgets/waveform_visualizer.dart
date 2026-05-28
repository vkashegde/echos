import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class WaveformVisualizer extends StatefulWidget {
  const WaveformVisualizer({
    super.key,
    required this.isPlaying,
    this.barCount = 32,
    this.color,
    this.height = 48,
  });

  final bool isPlaying;
  final int barCount;
  final Color? color;
  final double height;

  @override
  State<WaveformVisualizer> createState() => _WaveformVisualizerState();
}

class _WaveformVisualizerState extends State<WaveformVisualizer>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  double _phase = 0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      if (widget.isPlaying) {
        setState(() => _phase = elapsed.inMilliseconds / 1000.0);
      }
    });
    if (widget.isPlaying) _ticker.start();
  }

  @override
  void didUpdateWidget(WaveformVisualizer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying && !_ticker.isActive) {
      _ticker.start();
    } else if (!widget.isPlaying && _ticker.isActive) {
      _ticker.stop();
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Colors.white.withValues(alpha: 0.35);
    return SizedBox(
      height: widget.height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(widget.barCount, (i) {
          final t = i / widget.barCount;
          final wave = widget.isPlaying
              ? (sin((_phase * 3) + t * pi * 4) * 0.5 + 0.5)
              : 0.15 + (i % 5) * 0.02;
          final h = (widget.height * (0.2 + wave * 0.8)).clamp(4.0, widget.height);
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                height: h,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.25 + wave * 0.55),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
