import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AngsuranCalculator(),
    );
  }
}

class AngsuranCalculator extends StatefulWidget {
  @override
  _AngsuranCalculatorState createState() => _AngsuranCalculatorState();
}

class _AngsuranCalculatorState extends State<AngsuranCalculator> {
  final _otrController = TextEditingController();
  final _dpController = TextEditingController();
  final _jangkaWaktuController = TextEditingController();
  String _angsuranPerBulan = '';

  void _calculateAngsuran() {
    double otr = double.tryParse(_otrController.text) ?? 0;
    double dp = double.tryParse(_dpController.text) ?? 0;
    int jangkaWaktu = int.tryParse(_jangkaWaktuController.text) ?? 0;

    double pokokUtang = otr - dp;
    double bunga = 0;

    if (jangkaWaktu <= 12) {
      bunga = 0.12;
    } else if (jangkaWaktu > 12 && jangkaWaktu <= 24) {
      bunga = 0.14;
    } else if (jangkaWaktu > 24) {
      bunga = 0.165;
    }

    double totalBunga = pokokUtang * bunga;
    double angsuranPerBulan = (pokokUtang + totalBunga) / jangkaWaktu;

    setState(() {
      _angsuranPerBulan = angsuranPerBulan.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator Angsuran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _otrController,
              decoration: InputDecoration(labelText: 'OTR (Harga Mobil)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _dpController,
              decoration: InputDecoration(labelText: 'Down Payment (DP)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _jangkaWaktuController,
              decoration: InputDecoration(labelText: 'Jangka Waktu (bulan)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateAngsuran,
              child: Text('Hitung Angsuran'),
            ),
            SizedBox(height: 20),
            Text(
              _angsuranPerBulan.isEmpty
                  ? 'Masukkan data untuk menghitung angsuran'
                  : 'Angsuran per bulan: Rp $_angsuranPerBulan',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
