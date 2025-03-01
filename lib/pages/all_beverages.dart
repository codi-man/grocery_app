import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/modals/beverages_modal.dart';
import 'package:grocery_app/models/beverages_model.dart';
import 'package:grocery_app/pages/cart.dart';
import 'package:grocery_app/pages/custom_appbar.dart';
import 'package:grocery_app/pages/home_page.dart';

List<BeveragesModel> selectedBeverages = [];

class AllBeverages extends StatefulWidget {
  final List<BeveragesModel> beverages;
  const AllBeverages({super.key, required this.beverages});

  @override
  State<AllBeverages> createState() => _BeveragesState();
}

class _BeveragesState extends State<AllBeverages> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool _isSelected(BeveragesModel beverage) {
    return selectedBeverages.contains(beverage);
  }

  void _toggleSelection(BeveragesModel beverage) {
    setState(() {
      if (_isSelected(beverage)) {
        selectedBeverages.remove(beverage);
      } else {
        selectedBeverages.add(beverage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppbar(title: "Beverages"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Wrap(
            spacing: 10.0, // horizontal spacing between items
            runSpacing: 10.0, // vertical spacing between rows
            children: List.generate(
              widget.beverages.length,
              (index) {
                final beverage = widget.beverages[index];
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) => BeverageDetailModal(beverage: beverage),
                    );
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width / 2) - 20,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          beverage.imagePath,
                          height: 100,
                          width: 100,
                        ),
                        Text(
                          beverage.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          beverage.size,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(beverage.price),
                            GestureDetector(
                              onTap: () => _toggleSelection(beverage),
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _isSelected(beverage)
                                      ? Icons.check
                                      : Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottom_navigation(),
    );
  }

  BottomNavigationBar bottom_navigation() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: GestureDetector(
            onTap: () {
              Get.offAll(const HomePage());
            },
            child: const Icon(Icons.storefront)),
            label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: GestureDetector(
            onTap: () {
              Get.to(() => Cart(beverages: selectedBeverages));
            },
            child: const Icon(Icons.shopping_cart),
          ),
          label: 'Cart',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favourite',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Account',
        ),
      ],
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
    );
  }
}