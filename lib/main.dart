import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce Simple',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

// --- MODEL DATA ---
class Product {
  final String name;
  final String description;
  final String price;
  final String category;
  final String imageUrl;

  Product(
    this.name,
    this.description,
    this.price,
    this.category,
    this.imageUrl,
  );
}

// --- 1. HALAMAN HOME ---
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Data Dummy Hardcoded
  final List<Product> products = const [
    /* Menggunakan placeholder image karena data bersifat hardcoded */
  ];

  @override
  Widget build(BuildContext context) {
    // List produk untuk ditampilkan
    final List<Product> dummyProducts = [
      Product(
        "Sepatu Running A1",
        "Sepatu lari ringan dan nyaman.",
        "Rp 750.000",
        "Fashion",
        "https://picsum.photos/200",
      ),
      Product(
        "Laptop Pro 14",
        "Laptop kencang untuk produktivitas.",
        "Rp 15.000.000",
        "Elektronik",
        "https://picsum.photos/201",
      ),
      Product(
        "Jam Tangan Digital",
        "Tahan air hingga 50 meter.",
        "Rp 300.000",
        "Aksesoris",
        "https://picsum.photos/202",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Toko Sederhana"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigasi ke halaman Profile
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: dummyProducts.length,
        itemBuilder: (context, index) {
          final item = dummyProducts[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Image.network(
                item.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(item.name),
              subtitle: Text(item.category),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Event Handling: Tap untuk Navigasi & Kirim Data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(product: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// --- 2. HALAMAN DETAIL ---
class DetailPage extends StatefulWidget {
  final Product product;
  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Produk")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.product.imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          // Event Handling: Tombol Like menggunakan setState
                          setState(() {
                            isLiked = !isLiked;
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    widget.product.category,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.product.price,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Deskripsi:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(widget.product.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 3. HALAMAN PROFILE ---
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profil Saya")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.email),
              title: Text("Email"),
              subtitle: Text("dzaki.althalsyah@example.com"),
            ),
            const ListTile(
              leading: Icon(Icons.location_on),
              title: Text("Alamat"),
              subtitle: Text("Jl. Universitas Brawijaya, Malang"),
            ),
            const ListTile(
              leading: Icon(Icons.phone),
              title: Text("No HP"),
              subtitle: Text("08123456789"),
            ),
            const ListTile(
              leading: Icon(Icons.cake),
              title: Text("Tanggal Lahir"),
              subtitle: Text("1 Januari 2000"),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Event Handling: Tombol Edit (Feedback Sederhana)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Fitur edit diklik")),
                  );
                },
                child: const Text("Edit Profil"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
