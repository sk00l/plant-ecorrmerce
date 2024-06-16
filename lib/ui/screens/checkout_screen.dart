import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plant_ecommerce/ui/components/address_widget.dart';
import 'package:plant_ecommerce/ui/components/dotted_line.dart';
import 'package:plant_ecommerce/ui/components/payment_widger.dart';
import 'package:plant_ecommerce/ui/components/summary_idget.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  void _previousPage() {
    if (currentIndex > 0) {
      currentIndex--;
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _nextPage() {
    setState(() {
      if (currentIndex < 2) {
        currentIndex++;
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        context.go("/home/mycart/checkout/orderDetails");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: _previousPage,
        // ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(34, 0, 34, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: currentIndex >= 0 ? Colors.green : Colors.grey,
                    size: 42.0,
                  ),
                  Expanded(
                    child: DottedLine(
                      color: currentIndex >= 1 ? Colors.green : Colors.grey,
                      dashWidth: 6.0,
                      dashSpace: 3.0,
                    ),
                  ),
                  Icon(
                    Icons.payment_rounded,
                    color: currentIndex >= 1 ? Colors.green : Colors.grey,
                    size: 32.0,
                  ),
                  Expanded(
                    child: DottedLine(
                      color: currentIndex >= 2 ? Colors.green : Colors.grey,
                      dashWidth: 6.0,
                      dashSpace: 3.0,
                    ),
                  ),
                  Icon(
                    Icons.summarize_outlined,
                    color: currentIndex >= 2 ? Colors.green : Colors.grey,
                    size: 32.0,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  currentIndex = page;
                });
              },
              children: const [
                AddressWidget(),
                PaymentWidget(),
                SummaryWidget(),
              ],
            ),
          ),
          Container(
            color: Colors.green,
            height: 60,
            child: InkWell(
              onTap: _nextPage,
              child: const Center(
                child: Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
