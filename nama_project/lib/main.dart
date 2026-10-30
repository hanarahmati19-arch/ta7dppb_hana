import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Pekan6TesAkhirPage(),
    );
  }
}

class Pekan6TesAkhirPage extends StatelessWidget {
  const Pekan6TesAkhirPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tes Akhir - Palang Pintu Otomatis'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeaderWisataWidget(),
            SizedBox(height: 16),
            Expanded(child: TiketKuotaWidget()),
          ],
        ),
      ),
    );
  }
}

class HeaderWisataWidget extends StatelessWidget {
  const HeaderWisataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Taman Wisata Hutan Raya',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, size: 18, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  'Buka: 07.00 - 17.00 WIB',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TiketKuotaWidget extends StatefulWidget {
  const TiketKuotaWidget({super.key});

  @override
  State<TiketKuotaWidget> createState() => _TiketKuotaWidgetState();
}

class _TiketKuotaWidgetState extends State<TiketKuotaWidget> {
  int kuotaTersedia = 10;
  int pengunjungMasuk = 0;
  bool isGerbangTerkunci = false;

  void _tapMasuk() {
    if (kuotaTersedia > 0 && !isGerbangTerkunci) {
      setState(() {
        kuotaTersedia--;
        pengunjungMasuk++;

        if (kuotaTersedia == 0) {
          isGerbangTerkunci = true;
        }
      });
    }
  }

  void _toggleGerbang() {
    setState(() {
      isGerbangTerkunci = !isGerbangTerkunci;
    });
  }

  void _resetHarian() {
    setState(() {
      kuotaTersedia = 10;
      pengunjungMasuk = 0;
      isGerbangTerkunci = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: isGerbangTerkunci
                    ? Colors.red.shade100
                    : Colors.green.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isGerbangTerkunci ? Colors.red : Colors.green,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isGerbangTerkunci ? Icons.lock : Icons.lock_open,
                    color: isGerbangTerkunci ? Colors.red : Colors.green,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isGerbangTerkunci
                        ? 'GERBANG TERKUNCI'
                        : 'GERBANG DIBUKA',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isGerbangTerkunci
                          ? Colors.red.shade800
                          : Colors.green.shade800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoCard(
                  title: 'Kuota Tersedia',
                  value: kuotaTersedia.toString(),
                  color: Colors.blue,
                ),
                _buildInfoCard(
                  title: 'Pengunjung Masuk',
                  value: pengunjungMasuk.toString(),
                  color: Colors.orange,
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed:
                  (kuotaTersedia > 0 && !isGerbangTerkunci) ? _tapMasuk : null,
              icon: const Icon(Icons.confirmation_number),
              label: const Text('Tap Masuk / Beli Tiket'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _toggleGerbang,
              icon: Icon(isGerbangTerkunci ? Icons.lock_open : Icons.lock),
              label: Text(
                isGerbangTerkunci
                    ? 'Buka Gerbang Darurat'
                    : 'Kunci Gerbang Darurat',
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: isGerbangTerkunci ? Colors.green : Colors.red,
                side: BorderSide(
                  color: isGerbangTerkunci ? Colors.green : Colors.red,
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: _resetHarian,
              icon: const Icon(Icons.refresh),
              label: const Text('Reset Kuota Harian'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey.shade700,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
