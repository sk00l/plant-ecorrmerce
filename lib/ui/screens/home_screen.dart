import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:plant_ecommerce/ui/components/custom_bottom_navigation_bar.dart';
import 'package:plant_ecommerce/ui/components/plant_list_view.dart';
import 'package:plant_ecommerce/ui/components/plant_list_view2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 245, 245, 245),
          surfaceTintColor: Colors.transparent,
          leading: const Icon(
            Icons.grid_view_rounded,
            size: 20,
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.sliders,
                  size: 20,
                )),
            IconButton(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.bell,
                size: 20,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Good Morning',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Find Your Favourite Plants Here',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 20),
              child: SizedBox(
                height: 60,
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 32,
                    ),
                    labelText: "Search",
                    labelStyle:
                        const TextStyle(color: Colors.grey, fontSize: 16.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: Row(
                children: [
                  const Text(
                    'Most Popular',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'View All',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 75, 142, 75)),
                      )),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: SizedBox(
                height: 380,
                child: PlantListViewer(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: Row(
                children: [
                  const Text(
                    'My Favourite',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'View All',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 75, 142, 75)),
                      )),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: SizedBox(
                child: PlantListViewer2(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 80,
        width: 80,
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 75, 142, 75),
          onPressed: () {},
          shape: const CircleBorder(),
          child: SvgPicture.asset(
            'assets/vectors/qr-scan.svg',
            height: 30,
            width: 30,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
