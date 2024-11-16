import 'package:flutter/material.dart';

class KisiKayit extends StatefulWidget {
  const KisiKayit({super.key});

  @override
  State<KisiKayit> createState() => _KisiKayitState();
}

class _KisiKayitState extends State<KisiKayit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kişi Kayıt"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        
      },
      tooltip: 'Kişi Ekle',
      child: Icon(Icons.add),
      ),
    );
  }
}