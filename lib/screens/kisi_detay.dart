import 'package:flutter/material.dart';

import '../Kisiler.dart';
import '../Kisilerdao.dart';

class KisiDetay extends StatefulWidget {
  Kisiler kisi;

  KisiDetay({required this.kisi});

  @override
  State<KisiDetay> createState() => _KisiDetayState();
}

class _KisiDetayState extends State<KisiDetay> {
  var tfkisiad = TextEditingController();
  var tfkisitel = TextEditingController();

//Bilgi guncelleme methodu
  Future<void> guncelle(int kisi_id, String kisi_ad, String kisi_tel) async {
    await Kisilerdao().kisiGuncelle(kisi_id, kisi_ad, kisi_tel);
  }

  @override
  void initState() {
    super.initState();

    //Öncelikle kişi nesnesine erişmem gerek
    var kisi = widget.kisi;

    //Kisibilgilerini textfielcontroller sayseinde içeri aktardık
    tfkisiad.text = kisi.kisi_ad;
    tfkisitel.text = kisi.kisi_tel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          "Kişi Ekle",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfkisiad,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: const Color.fromARGB(214, 68, 255, 190),
                  hintText: "Kişi Adı",
                ),
              ),
              TextField(
                controller: tfkisitel,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: const Color.fromARGB(214, 68, 255, 190),
                    hintText: "Kişi Tel"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.deepPurpleAccent,
          onPressed: () {
            guncelle(
                widget.kisi.kisi_id, widget.kisi.kisi_ad, widget.kisi.kisi_tel);
          },
          tooltip: 'Kişi Güncelle',
          icon: Icon(
            Icons.update,
            color: Colors.white,
          ),
          label: Text(
            "Güncelle",
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
