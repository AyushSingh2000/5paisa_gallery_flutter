import "package:flutter/material.dart";

import "custom_iconBtn.dart";

class CustomBar extends StatelessWidget {
  const CustomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Pictures",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
          ),
          const SizedBox(
            width: 154,
          ),
          CustomIconButton(
              icon: Icons.search_rounded,
              size: 25,
              onPressed: () {},
              color: Colors.white),
          CustomIconButton(
              icon: Icons.more_vert,
              size: 25,
              onPressed: () {},
              color: Colors.white)
        ],
      ),
    );
  }
}
