import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, bottom: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: ClipRRect(
                  child: Image.asset(
                    'assets/images/Logo-Dark.png',
                    height: 20,
                  ),
                ),
              ),
              const NewRow(
                text: ' My Profile',
                assetName: 'assets/vectors/user2.svg',
              ),
              const SizedBox(
                height: 20,
              ),
              const NewRow(
                text: ' My Address',
                assetName: 'assets/vectors/location.svg',
              ),
              const SizedBox(
                height: 20,
              ),
              const NewRow(
                text: ' My Order',
                assetName: 'assets/vectors/box.svg',
              ),
              const SizedBox(
                height: 20,
              ),
              const NewRow(
                text: ' My Favourite',
                assetName: 'assets/vectors/heart2.svg',
              ),
              const SizedBox(
                height: 20,
              ),
              const NewRow(
                text: ' Settings',
                assetName: 'assets/vectors/settings.svg',
              ),
              const SizedBox(
                height: 20,
              ),
              const NewRow(
                text: ' Help and Support',
                assetName: 'assets/vectors/24.svg',
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.cancel,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Log out',
                    style: TextStyle(color: Colors.black.withOpacity(0.5)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NewRow extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final String? assetName;

  const NewRow({super.key, this.text, this.icon, this.assetName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null)
          Icon(
            icon,
            color: Colors.black,
          ),
        if (assetName != null)
          SvgPicture.asset(
            assetName!,
            height: 24,
          ),
        if (text != null)
          Text(
            text!,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
      ],
    );
  }
}
