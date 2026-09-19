import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_core/firebase_core.dart';
 => runApp(const ApnaSheharApp());

class ApnaSheharApp extends StatelessWidget {
  const ApnaSheharApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apna Shehar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final pages = const [
    HomeTab(),
    OrdersTab(),
    ChatTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('APNA SHEHAR',
            style: TextStyle(fontWeight: FontWeight.bold)),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF1565C0),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          )
        ],
      ),
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), label: 'Orders'),
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Safdarabad ka apna marketplace',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        TextField(
          decoration: InputDecoration(
            hintText: 'Aapko kya chahiye?',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _ActionCard(
                icon: Icons.shopping_cart_outlined,
                title: 'Buy / Request',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const RequestPage())),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ActionCard(
                icon: Icons.storefront_outlined,
                title: 'Sell',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SellPage())),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text('Popular Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ['Grocery', 'Clothes', 'Electronics', 'Household', 'Shoes']
              .map((x) => Chip(label: Text(x)))
              .toList(),
        ),
        const SizedBox(height: 24),
        Card(
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xFFE3F2FD),
              child: Icon(Icons.local_shipping_outlined,
                  color: Color(0xFF1565C0)),
            ),
            title: const Text('Local Delivery'),
            subtitle: const Text('Safdarabad mein aapke address tak delivery.'),
          ),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _ActionCard({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) => Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(icon, size: 38, color: const Color(0xFF1565C0)),
                const SizedBox(height: 8),
                Text(title, textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      );
}

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});
  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final product = TextEditingController();
  final budget = TextEditingController();
  final address = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Buy / Request')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Jo cheez chahiye uski details dein.',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: product,
                decoration: const InputDecoration(
                    labelText: 'Product name',
                    border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: budget, keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Budget (Rs.)',
                    border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: address, maxLines: 2,
                decoration: const InputDecoration(
                    labelText: 'Delivery address - Safdarabad',
                    border: OutlineInputBorder())),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Request saved (MVP demo).')),
                );
              },
              icon: const Icon(Icons.send),
              label: const Text('Request Send Karein'),
            ),
          ],
        ),
      );
}

class SellPage extends StatelessWidget {
  const SellPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Sell a Product')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Icon(Icons.add_a_photo_outlined, size: 70,
                color: Color(0xFF1565C0)),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(
                labelText: 'Product name', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            const TextField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Price (Rs.)', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            const TextField(maxLines: 3, decoration: InputDecoration(
                labelText: 'Description', border: OutlineInputBorder())),
            const SizedBox(height: 20),
            FilledButton(onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Product submitted (MVP demo).')),
              );
            }, child: const Text('Product List Karein')),
          ],
        ),
      );
}

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});
  @override
  Widget build(BuildContext context) => const Center(
        child: Text('My Orders\n\nAbhi koi order nahi hai.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18)),
      );
}

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});
  @override
  Widget build(BuildContext context) => const Center(
        child: Text('Chat\n\nCustomer aur seller/admin chat yahan hogi.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18)),
      );
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});
  @override
  Widget build(BuildContext context) => const Center(
        child: Text('Profile\n\nName, phone aur address yahan manage honge.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18)),
      );
}
