import 'package:flutter/material.dart';

import 'fluid_focusable.dart';

class Focusable extends StatefulWidget {
  const Focusable({
    super.key,
    required this.child,
    this.onTap,
    this.width,
    this.height,
    this.autofocus,
    this.onFocusChange,
    this.selected,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.focusNode,
  });

  final Widget child;
  final double? width;
  final double? height;
  final bool? autofocus;
  final bool? selected;
  final Color? backgroundColor;
  final Color? selectedBackgroundColor;
  final GestureTapCallback? onTap;
  final ValueChanged<bool>? onFocusChange;
  final FocusNode? focusNode;

  @override
  State<Focusable> createState() => _FocusableState();
}

class _FocusableState extends State<Focusable> {
  late final FocusNode _focusNode;
  late final bool _ownsFocusNode;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
      _ownsFocusNode = false;
    } else {
      _focusNode = FocusNode();
      _ownsFocusNode = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: FluidFocusable(
        focusNode: _focusNode,
        selected: widget.selected,
        backgroundColor: widget.backgroundColor,
        selectedBackgroundColor: widget.selectedBackgroundColor,
        child: InkWell(
          focusNode: _focusNode,
          autofocus: widget.autofocus ?? false,
          onFocusChange: widget.onFocusChange,
          customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          onTap: widget.onTap,
          child: widget.child,
        ),
      ),
    );
  }
}
