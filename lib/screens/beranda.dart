import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/appbar_actions.dart'; // pastikan path sesuai

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BerandaScreenState createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  final promoList = [
    "Diskon 50% untuk semua produk!",
    "Gratis ongkir minggu ini!",
    "Promo spesial mahasiswa!",
  ];

  final barangList = [
    {"nama": "Laptop Acer", "harga": "Rp 7.000.000"},
    {"nama": "Keyboard Mechanical", "harga": "Rp 450.000"},
    {"nama": "Mouse Wireless", "harga": "Rp 150.000"},
  ];

  final infoList = [
    "Aplikasi ini dibuat untuk UAS Mobile Programming.",
    "Dibuat dengan Flutter oleh Dicky and Zul.",
    "Versi 1.0.0 - 2025",
  ];

  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _currentTabIndex = _tabController.index;
          searchQuery = ''; // Reset saat pindah tab
          _searchController.clear();
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Widget buildAnimatedList(List<Widget> children) {
    return ListView.builder(
      itemCount: children.length,
      itemBuilder: (context, index) {
        return AnimatedOpacity(
          opacity: 1,
          duration: Duration(milliseconds: 300 + (index * 100)),
          curve: Curves.easeIn,
          child: children[index],
        );
      },
    );
  }

  Widget buildPromoTab() {
    final items = promoList.map((promo) {
      return Card(
        elevation: 2,
        margin: const EdgeInsets.all(10),
        child: ListTile(
          leading: const Icon(Icons.local_offer, color: Colors.red),
          title: Text(promo, style: GoogleFonts.poppins(fontSize: 16)),
        ),
      );
    }).toList();

    return buildAnimatedList(items);
  }

  Widget buildBarangTab() {
    final filtered = barangList
        .where((item) => item['nama']!
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();

    final items = filtered.map((item) {
      return Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListTile(
          leading: const Icon(Icons.shopping_cart, color: Colors.blue),
          title: Text(item['nama']!, style: GoogleFonts.poppins()),
          subtitle: Text(item['harga']!, style: const TextStyle(color: Colors.green)),
        ),
      );
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() => searchQuery = value);
            },
            decoration: InputDecoration(
              hintText: 'Cari barang...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        Expanded(child: buildAnimatedList(items)),
      ],
    );
  }

  Widget buildInfoTab() {
    final items = infoList.map((info) {
      return ListTile(
        leading: const Icon(Icons.info_outline, color: Colors.grey),
        title: Text(info, style: GoogleFonts.poppins()),
      );
    }).toList();

    return buildAnimatedList(items);
  }

  Widget getAnimatedTabView() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: IndexedStack(
        key: ValueKey<int>(_currentTabIndex),
        index: _currentTabIndex,
        children: [
          buildPromoTab(),
          buildBarangTab(),
          buildInfoTab(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UAS MOBILE PROGRAMMING",
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
        actions: const [AppBarActions()],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.white,
              tabs: const [
                Tab(text: 'Promo'),
                Tab(text: 'Daftar Barang'),
                Tab(text: 'Info'),
              ],
            ),
          ),
          Expanded(child: getAnimatedTabView()),
        ],
      ),
    );
  }
}
