import 'package:flutter/material.dart';

class ToggleSwitch extends StatelessWidget {
  final bool isToggled;
  final VoidCallback onToggle;

  ToggleSwitch({required this.isToggled, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Padding(
        padding: const EdgeInsets.only(left: 288.0),
        child: Container(
          width: 52,
          height: 28,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                duration: Duration(milliseconds: 300),
                alignment:
                    isToggled ? Alignment.centerRight : Alignment.centerLeft,
                curve: Curves.easeInOut,
                child: Container(
                  width: 30,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isToggled
                        ? Icons.grid_view_rounded
                        : Icons.view_headline_sharp,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
