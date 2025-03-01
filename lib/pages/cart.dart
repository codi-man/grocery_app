import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/models/beverages_model.dart';
import 'package:grocery_app/pages/all_beverages.dart';
import 'package:grocery_app/pages/custom_appbar.dart';
import 'package:grocery_app/pages/home_page.dart';
import 'package:grocery_app/pages/quantity_counter.dart';

class Cart extends StatefulWidget {
  final List<BeveragesModel> beverages;
  const Cart({super.key, required this.beverages});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  final Map<int, int> _quantities = {}; // Store quantities per item

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.beverages.length; i++) {
      _quantities[i] = 1; // Initialize all quantities to 1
    }
  }

  double _calculateTotalSum() {
    return widget.beverages.asMap().entries.fold(0, (sum, entry) {
      int index = entry.key;
      BeveragesModel beverage = entry.value;
      double price = double.parse(beverage.price.replaceAll("\$", ""));
      int quantity = _quantities[index]!;
      return sum + (price * quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Cart"),
      body: cart_items(),
      bottomNavigationBar: bottom_navigation(),
    );
  }

  Column cart_items() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: widget.beverages.length,
            itemBuilder: (context, index) {
              final beverage = widget.beverages[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        beverage.imagePath,
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  beverage.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // Remove the item from the beverages list
                                      widget.beverages.removeAt(index);

                                      // Remove the corresponding quantity from the map
                                      _quantities.remove(index);

                                      // Adjust the indices of the remaining quantities in the map
                                      Map<int, int> updatedQuantities = {};
                                      for (int i = 0; i < widget.beverages.length; i++) {
                                        updatedQuantities[i] = _quantities[i + 1] ?? 1;
                                      }
                                      _quantities.clear();
                                      _quantities.addAll(updatedQuantities);
                                    });
                                  },
                                  child: const Icon(Icons.close, color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              beverage.size,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                QuantityCounter(
                                  initialQuantity: _quantities[index]!,
                                  onQuantityChanged: (quantity) {
                                    setState(() {
                                      _quantities[index] = quantity;
                                    });
                                  },
                                ),
                                Text(
                                  "\$${(double.parse(beverage.price.replaceAll("\$", "")) * _quantities[index]!).toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Go To Checkout",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "\$${_calculateTotalSum().toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
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
              Get.offAll(() => Cart(beverages: selectedBeverages));
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