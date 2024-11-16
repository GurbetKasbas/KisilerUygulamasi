import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kisiler_uygulamasi/Kisilerdao.dart';
import 'package:kisiler_uygulamasi/screens/kisi_detay.dart';
import 'package:kisiler_uygulamasi/screens/kisi_kayit.dart';

import '../Kisiler.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;

  String aramaKelimesi = " ";

//Veri kümesini olusturmak için gerekli method
  Future<List<Kisiler>> tumKisileriGoster() async {
    //Olusturacağımız kisiler nesnelerini tutucak bir değişken tanımladık
    var kisilerListesi = await Kisilerdao().tumKisiler();
    return kisilerListesi;
  }

//Arama yapmak için kullanılacak method 
Future<List<Kisiler>> aramaYap(String aramaKelimesi) async{
  var kisilerListesi = await Kisilerdao().kisiArama(aramaKelimesi);
  return kisilerListesi;
}




  //Numarayı silmek için method
  Future<void> sil(int kisi_id) async {
    await Kisilerdao().kisiSilme(kisi_id , );

    setState(() {});
  }

  //Uygulamayı kapatma methodu
  Future<bool> uuygulamayiKapat() async {
    await exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //anasayfadaki geri tuşuna bastığında uygulamayı kapatır
        leading: IconButton(
            onPressed: () {
              uuygulamayiKapat();
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.deepPurpleAccent,
        title: aramaYapiliyorMu
            ? TextField(
                decoration: InputDecoration(
                  hintText: "Arama için bir şey yazın",
                ),
                onChanged: (aramaSonucu) {
                  print("Arama Sonucu: $aramaSonucu");
                  setState(() {
                    //Aramadan aldığım aramaSonucunu aramaKelimesine aktarıyorum
                    aramaKelimesi = aramaSonucu;
                  });
                },
              )
            : Text(
                "Kişiler Uygulaması",
                style: TextStyle(color: Colors.white),
              ),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = false;
                      //Arama yapılmadığı için aramaKelimesinin içeriğini temizledik
                      aramaKelimesi = "";
                    });
                  },
                  icon: const Icon(Icons.cancel),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = true;
                    });
                  },
                  icon: const Icon(Icons.search),
                )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<List<Kisiler>>(
            future: aramaYapiliyorMu 
            ? aramaYap(aramaKelimesi)
            :  tumKisileriGoster(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //Aldığım veriyim tanımladığım değişkende tuutyorum
                var kisilerListesi = snapshot.data;
                return ListView.builder(
                    itemCount: kisilerListesi!.length,
                    itemBuilder: (context, index) {
                      var kisi = kisilerListesi[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => KisiDetay(
                                        kisi: kisi,
                                      )));
                        },
                        child: Card(
                          color: Colors.greenAccent,
                          child: SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "${kisi.kisi_ad} ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("${kisi.kisi_tel}"),
                                IconButton(
                                  onPressed: () {
                                    sil(kisi.kisi_id);
                                  },
                                  icon: Icon(Icons.delete),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(
                    child: Text(
                  "Veri Alınamdı",
                  style: TextStyle(fontSize: 25),
                ));
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => KisiKayit()));
        },
        tooltip: 'Kişi Ekle',
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.deepPurpleAccent,
      ),
    );
  }
}
