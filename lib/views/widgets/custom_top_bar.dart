import "package:flutter/material.dart";

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
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_rounded,
                color: Colors.white,
                size: 25,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 25,
              )),
        ],
      ),
    );
  }
}
