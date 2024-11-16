import 'package:flutter/material.dart';

class KisiDetay extends StatefulWidget {
  const KisiDetay({super.key});

  @override
  State<KisiDetay> createState() => _KisiDetayState();
}

class _KisiDetayState extends State<KisiDetay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kişi Ekle"),
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