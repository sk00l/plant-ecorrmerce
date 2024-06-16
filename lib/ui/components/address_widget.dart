import 'package:flutter/material.dart';
import 'package:plant_ecommerce/configs/extension/build_context_extension.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColor;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(color: appColor.primary),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Home",
                          ),
                          Spacer(),
                          (Icon(Icons.more_horiz_rounded))
                        ],
                      ),
                      Text("413 Washington broinks"),
                      Text("Manchester, 34556"),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
