import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:plant_ecommerce/configs/extension/build_context_extension.dart';
import 'package:plant_ecommerce/configs/di/service_locator.dart';
import 'package:plant_ecommerce/modules/auth/email%20login/bloc/login_bloc.dart';
import 'package:plant_ecommerce/modules/auth/email%20login/repository/email_login_repository.dart';
import 'package:plant_ecommerce/themes/bloc/theme_bloc.dart';
import 'package:plant_ecommerce/themes/configs/app_theme.dart';

import 'package:plant_ecommerce/ui/components/custom_bottom_navigation_bar.dart';
import 'package:plant_ecommerce/ui/components/plant_list_view.dart';
import 'package:plant_ecommerce/ui/components/plant_list_view2.dart';
import 'package:plant_ecommerce/ui/screens/drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColor;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          context.go('/login');
        }
      },
      child: Stack(
        children: [
          const DrawerScreen(),
          AnimatedContainer(
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(isDrawerOpen ? 0.85 : 1.00)
              ..rotateZ(isDrawerOpen ? pi * -0.07 : 0),
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: isDrawerOpen
                  ? BorderRadius.circular(40)
                  : BorderRadius.circular(0),
            ),
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: AppBar(
                  title: Text(
                    getIt
                            .get<EmailLoginRepository>()
                            .pref
                            ?.getString('email') ??
                        'ababbdwad',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: appColor.primary,
                  surfaceTintColor: Colors.transparent,
                  leading: isDrawerOpen
                      ? GestureDetector(
                          child: const Icon(Icons.arrow_back_ios),
                          onTap: () {
                            setState(() {
                              xOffset = 0;
                              yOffset = 0;
                              isDrawerOpen = false;
                            });
                          },
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              xOffset = 160;
                              yOffset = 90;
                              isDrawerOpen = true;
                            });
                          },
                          icon: const Icon(
                            Icons.grid_view_rounded,
                            size: 20,
                          ),
                        ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<LoginBloc>(context)
                              .add(LogoutRequested());
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.sliders,
                          size: 20,
                        )),
                    IconButton(
                      onPressed: () {
                        context.go('/api');
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.bell,
                        size: 20,
                      ),
                    ),
                    Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        setState(() {
                          isDarkMode = value;

                          if (isDarkMode) {
                            context.read<ThemeBloc>().add(ThemeChangeRequested(
                                themeData: AppTheme.darkTheme()));
                          } else {
                            context.read<ThemeBloc>().add(ThemeChangeRequested(
                                themeData: AppTheme.lightTheme()));
                          }
                        });
                      },
                    ),
                    IconButton(
                        onPressed: () {
                          context.go('/cartPage');
                        },
                        icon: const Icon(
                          Symbols.shopping_cart,
                          size: 24,
                        )),
                  ],
                ),
              ),
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      color: appColor.primary,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              'Good Morning',
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              'Find Your Favourite Plants Here',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 20),
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
                                  labelStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 16.0),
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
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'View All',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Color.fromARGB(255, 75, 142, 75)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: SizedBox(
                              height: 340,
                              child: PlantListViewer(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                            child: Row(
                              children: [
                                const Text(
                                  'My Favourite',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'View All',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Color.fromARGB(255, 75, 142, 75)),
                                  ),
                                ),
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
                  )
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: SizedBox(
                height: 80,
                width: 80,
                child: FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 75, 142, 75),
                  onPressed: () {
                    context.go('/plantAddPage');
                  },
                  shape: const CircleBorder(),
                  child: SvgPicture.asset(
                    'assets/vectors/qr-scan.svg',
                    height: 30,
                    width: 30,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
              ),
              bottomNavigationBar: const CustomBottomNavigationBar(),
            ),
          ),
        ],
      ),
    );
  }
}
