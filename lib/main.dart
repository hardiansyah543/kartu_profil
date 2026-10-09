import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/// Widget akar aplikasi (StatelessWidget) -> mengatur MaterialApp.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kartu Profil',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const ProfileCardPage(),
    );
  }
}

/// Halaman Kartu Profil (StatelessWidget, tanpa state).
class ProfileCardPage extends StatelessWidget {
  const ProfileCardPage({super.key});

  // ====== Data profil (ubah sesuai identitas kamu) ======
  static const String fotoPath = 'assets/foto.jpg';
  static const String nama = 'Hardiansyah';
  static const String jabatan = 'Mahasiswa Sistem Informasi · Unipdu Jombang';
  static const String deskripsi =
      'Mahasiswa yang sedang belajar pemrograman mobile dengan Flutter. '
      'Suka membangun aplikasi sederhana yang rapi, responsif, dan bermanfaat.';
  static const List<String> skills = [
    'Flutter',
    'Dart',
    'UI Design',
    'Basis Data',
    'Git & GitHub',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kartu Profil'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  // LayoutBuilder: merespons lebar widget induk (lokal).
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final bool isWide = constraints.maxWidth > 600;

                      if (isWide) {
                        // Layar lebar: foto & info berdampingan (Row)
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            ProfilePhoto(),
                            SizedBox(width: 32),
                            Expanded(child: ProfileInfo(isWide: true)),
                          ],
                        );
                      }

                      // Layar sempit: foto & info bertumpuk (Column)
                      return Column(
                        children: const [
                          ProfilePhoto(),
                          SizedBox(height: 24),
                          ProfileInfo(isWide: false),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Foto profil + badge "Available" di pojok (Stack + Positioned).
class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Foto profil dari folder assets
          const CircleAvatar(
            radius: 70,
            backgroundColor: Colors.indigo,
            backgroundImage: AssetImage(ProfileCardPage.fotoPath),
          ),
          // Badge kecil di sudut foto
          Positioned(
            bottom: 4,
            right: -12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Text(
                'Available',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Nama, jabatan, deskripsi, skill (Wrap + Chip), dan ikon kontak (Row).
class ProfileInfo extends StatelessWidget {
  final bool isWide;
  const ProfileInfo({super.key, required this.isWide});

  @override
  Widget build(BuildContext context) {
    final align = isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center;
    final textAlign = isWide ? TextAlign.start : TextAlign.center;

    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          ProfileCardPage.nama,
          textAlign: textAlign,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          ProfileCardPage.jabatan,
          textAlign: textAlign,
          style: TextStyle(fontSize: 15, color: Colors.grey[700]),
        ),
        const SizedBox(height: 16),
        Text(
          ProfileCardPage.deskripsi,
          textAlign: textAlign,
          style: const TextStyle(fontSize: 15, height: 1.4),
        ),
        const SizedBox(height: 20),

        // Skill memakai Wrap (otomatis pindah baris jika ruang habis)
        Wrap(
          spacing: 8,
          runSpacing: 4,
          alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
          children: ProfileCardPage.skills
              .map((s) => Chip(
            label: Text(s),
            avatar: const Icon(Icons.check_circle, size: 18),
          ))
              .toList(),
        ),
        const SizedBox(height: 20),

        // 3 ikon kontak disusun horizontal dengan Row
        Row(
          mainAxisAlignment:
          isWide ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: const [
            Icon(Icons.email, size: 32, color: Colors.red),
            SizedBox(width: 24),
            Icon(Icons.phone, size: 32, color: Colors.green),
            SizedBox(width: 24),
            Icon(Icons.code, size: 32, color: Colors.black87), // GitHub
          ],
        ),
      ],
    );
  }
}