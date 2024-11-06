# Not Steam

A new Flutter project.

## Quick-Navigation
- [Tugas 7](#tugas-7)

## Tugas 7
### 1. Jelaskan apa yang dimaksud dengan stateless widget dan stateful widget, dan jelaskan perbedaan dari keduanya.
Stateless Widget adalah jenis widget yang tampilannya tidak akan berubah setelah dirender. Sebaliknya, Stateful Widget memiliki state yang memungkinkan tampilannya untuk berubah setelah dirender pertama kali. Untuk mengubah tampilan atau state dari Stateful Widget, kita menggunakan metode `setState()`.
### 2. Sebutkan widget apa saja yang kamu gunakan pada proyek ini dan jelaskan fungsinya.
1. MaterialApp: Widget utama yang membungkus seluruh aplikasi.
2. ThemeData: Widget untuk mengatur tema aplikasi.
3. Scaffold: Widget untuk membangun struktur dasar halaman aplikasi.
4. AppBar: Widget untuk menampilkan bagian atas halaman yang memiliki judul.
5. Padding: Widget untuk menambahkan ruang di sekitar widget lain.
6. Row: Widget untuk menyusun secara horizontal.
7. Column: Widget untuk menyusun secara vertikal.
8. InfoCard: Widget Custom untuk menampilkan informasi seperti NPM, Nama, dan kelas.
9. InkWell: Widget untuk respons sentuhan dripple.
10. SnackBar: Widget untuk menampilkan pesan sementara di bawah layar aplikasi.
### 3. Apa fungsi dari setState()? Jelaskan variabel apa saja yang dapat terdampak dengan fungsi tersebut.
Fungsi dari `setState()` adalah untuk mengubah state widget yang akan ditampilkan, ini membuat tampilan widget yang dilihat oleh pengguna akan berubah, Variabel yang dapat terdampak adalah variabel yang diggunakan untuk tampilan, seperti variabel default flutter yang bisa bertambah, berkurang berdasarkan interaksi pengguna dan toggle.
### 4. Jelaskan perbedaan antara const dengan final.
Perbedaan antara `const` dan `final` adalah sebagai berikut, `const` digunakan ketika kita sudah mengetahui dengan pasti bahwa nilai variabel tidak akan berubah, sehingga nilainya ditentukan saat kompilasi. Sebaliknya, `final` digunakan ketika kita belum mengetahui nilai variabel saat kompilasi, sehingga nilainya akan ditentukan saat runtime.
### 5. Jelaskan bagaimana cara kamu mengimplementasikan checklist-checklist di atas.
- Membuat aplikasi flutter yang baru

```
flutter create not_steam_mobile
```

- Merapikan struktkur proyek pada berkas ``main.dart``
```dart
import 'package:flutter/material.dart';
import 'package:not_steam/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.deepPurple,
        ).copyWith(secondary: Colors.deepPurple[400]),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
```
- Mengubah sifat widget Halaman Menu menjadi stateless dan menambahkan 3 tombol dasar dengan 3 warna berbeda pada berkas ``menu.dart``
```dart
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  final String npm = '2306152166'; // NPM
  final String name = 'Brian Altan'; // Nama
  final String className = 'PBP E'; // Kelas
  MyHomePage({super.key});

  final List<ItemHomepage> items = [
    ItemHomepage("Lihat Daftar Produk", Icons.mood, Colors.blue),
    ItemHomepage("Tambah Produk", Icons.add, Colors.green),
    ItemHomepage("Logout", Icons.logout, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Not Steam',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: name),
                InfoCard(title: 'Class', content: className),
              ],
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Welcome to Not Steam',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    children: items.map((ItemHomepage item) {
                      return ItemCard(item);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"))
            );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```