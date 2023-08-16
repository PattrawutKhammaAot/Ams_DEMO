import 'package:flutter/material.dart';

import '../config/app_constants.dart';

class BlinkingIconStatus extends StatefulWidget {
  final Color color;
  final double? size;
  final IconData icon;

  const BlinkingIconStatus({super.key, this.color = colorSuccess, this.size = 12,   this.icon = Icons.check_circle});

  @override
  _BlinkingIconStatusState createState() => _BlinkingIconStatusState();
}

class _BlinkingIconStatusState extends State<BlinkingIconStatus> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _animationController,
        child: Icon(
          widget.icon,
          size: widget.size,
          color: widget.color,
        ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
