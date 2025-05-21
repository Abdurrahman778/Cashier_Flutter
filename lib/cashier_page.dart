import 'package:cashier_project/checkout_page.dart';
import 'package:cashier_project/theme/app_theme.dart';
import 'package:cashier_project/widgets/cart_button.dart';
import 'package:cashier_project/widgets/product_card.dart';
import 'package:flutter/material.dart';

class CashierPage extends StatefulWidget {
  const CashierPage({super.key});

  @override
  State<CashierPage> createState() => _CashierPageState();
}

class _CashierPageState extends State<CashierPage> with SingleTickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _animation;

  List<Map<String, dynamic>> products = [
    {
      'name': 'Cokelat Susu',
      'category': 'Minuman',
      'stock': 20,
      'price': 10000,
      'image': 'assets/images/cokelatsusu.jpg',
    },
    {
      'name': 'Roti Bakar',
      'category': 'Makanan',
      'stock': 20,
      'price': 10000,
      'image': 'assets/images/rotibakar.jpg',
    },
    {
      'name': 'Kopi Hitam',
      'category': 'Minuman',
      'stock': 20,
      'price': 10000,
      'image': 'assets/images/kopihitam.jpg',
    },
  ];

  List<Map<String, dynamic>> filteredProducts = [];

  Map<int, int> cart = {}; // key: product index in original list, value: quantity

  @override
  void initState() {
    super.initState();
    filteredProducts = List.from(products);
    searchController.addListener(_onSearchChanged);
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    
    _animationController.forward();
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredProducts = products
          .where(
            (product) =>
                product['name'].toLowerCase().contains(query) ||
                product['category'].toLowerCase().contains(query),
          )
          .toList();
    });
  }

  void addToCart(int index) {
    final productIndex = products.indexOf(filteredProducts[index]);
    setState(() {
      if (products[productIndex]['stock'] > 0) {
        cart[productIndex] = (cart[productIndex] ?? 0) + 1;
        products[productIndex]['stock']--;
      }
    });
  }

  void removeFromCart(int index) {
    final productIndex = products.indexOf(filteredProducts[index]);
    setState(() {
      if (cart[productIndex] != null && cart[productIndex]! > 0) {
        cart[productIndex] = cart[productIndex]! - 1;
        products[productIndex]['stock']++;
        if (cart[productIndex] == 0) cart.remove(productIndex);
      }
    });
  }

  int get totalItem => cart.values.fold(0, (sum, qty) => sum + qty);
  int get totalPrice => cart.entries.fold(
        0,
        (sum, entry) => sum + ((products[entry.key]['price'] * entry.value) as int),
      );

  @override
  void dispose() {
    searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cashier App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Show transaction history
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          FadeTransition(
            opacity: _animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.1),
                end: Offset.zero,
              ).animate(_animation),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Search
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Cari Produk ...',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: const Icon(Icons.search, color: AppTheme.darkBlue),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Category Chips
                    SizedBox(
                      height: 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildCategoryChip('Semua', isSelected: true),
                          _buildCategoryChip('Minuman'),
                          _buildCategoryChip('Makanan'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Product List
                    Expanded(
                      child: filteredProducts.isEmpty
                          ? const Center(
                              child: Text(
                                'Tidak ada produk yang ditemukan',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: filteredProducts.length,
                              itemBuilder: (context, index) {
                                final product = filteredProducts[index];
                                final productIndex = products.indexOf(product);
                                return ProductCard(
                                  product: product,
                                  quantity: cart[productIndex] ?? 0,
                                  onIncrement: () => addToCart(index),
                                  onDecrement: () => removeFromCart(index),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Cart Button
          Align(
            alignment: Alignment.bottomCenter,
            child: CartButton(
              totalItems: totalItem,
              onPressed: () {
                if (totalItem > 0) {
                  // Prepare checkout items
                  final checkoutItems = cart.entries.map((entry) {
                    final product = products[entry.key];
                    return {
                      'name': product['name'],
                      'quantity': entry.value,
                      'price': product['price'],
                      'image': product['image'],
                    };
                  }).toList();

                  // Navigate to checkout page
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => 
                        CheckoutPage(checkoutItems: checkoutItems),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(position: offsetAnimation, child: child);
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppTheme.white : AppTheme.darkBlue,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        backgroundColor: isSelected ? AppTheme.vibrantOrange : AppTheme.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? AppTheme.vibrantOrange : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}
