// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'models/music.dart';

void main() {
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicApp(),
    );
  }
}

class MusicApp extends StatefulWidget  {
  const MusicApp({Key? key}) : super(key: key);

  @override
  State<MusicApp> createState() => _MusicAppState();
}

List<Music> MusicList = [
    Music("Bande Organisée", "Sch / Kofs / Jul / Naps / Soso maness / Elams / Solda / Houari", "images/organise.jpg", "https://www.cjoint.com/doc/20_08/JHrxEUARoEx_Bande-Organis%C3%A9e---Sch-Kofs-Jul-Naps-Soso-maness-Elams-Solda-Houari-Clip-Officiel-youzik.net-.mp3"),
    Music("Le Classico Organisé", "Koba LaD / JuL / PLK/ SCH/ Gazo / Soso Maness / Kofs / Guy2bezbar / Naps", "images/classico.jpg", "https://www.cjoint.com/doc/22_05/LEEr1G5kWai_Le-Classico-organis%C3%A9---Koba-LaD-JuL-PLK-SCH-Gazo-Soso-Maness-Kofs-Guy2bezbar-Naps.mp3"),
    Music("Filtré", "Timal ft Gazo", "images/filtre.jpg", "https://www.cjoint.com/doc/22_05/LEEwn7k5oei_Timal-Gazo---Filtr%C3%A9-Clip-Officiel-.mp3")
  ];

class _MusicAppState extends State<MusicApp> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  bool isPlaying = false;
  int nbMusic = 0;
  int actualMusic = 0;
  final player = AudioPlayer();

  Duration position = new Duration();
  Duration musicLength = new Duration();
  
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
  }

  Widget slider() {
    return Container(
      width: 300.0,
      child: Slider.adaptive(
          activeColor: Colors.blue[800],
          inactiveColor: Colors.grey[350],
          value: position.inSeconds.toDouble(),
          max: musicLength.inSeconds.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    player.seek(newPos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.pink.shade800,
                Colors.pink.shade400,
              ]),

        ),
        child: Padding(
          padding: EdgeInsets.only(top: 48.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ajout de txt
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text("Mu'seek", 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text("Une expérience révolutionnaire", 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                SizedBox(
                  height: 24.0,
                ),

                //img
                Center(
                  child: Container(
                    width: 300.0,
                    height: 300.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      image: DecorationImage(
                        image: AssetImage(MusicList[nbMusic].imgPath),
                      )
                    ),
                  ),
                ),
              
              SizedBox(
                height: 18.0,
              ),
              Center(
                child: Text(MusicList[nbMusic].title, 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.w400,
                ),
                ),
              ),
              Center(
                child: Text(MusicList[nbMusic].singer, 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w200,
                ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("0:00"),
                          slider(),
                          Text("0:00"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            iconSize: 45.0,
                            color: Colors.black,
                            onPressed: () {
                              setState(() {
                                player.pause();
                                _animationController.reverse();
                                isPlaying = false;
                                
                              });
                              if(nbMusic>0){
                                nbMusic -= 1;
                              } else if (nbMusic == 0){
                                nbMusic = (MusicList.length)-1;
                              }

                            },
                            icon: Icon(
                              Icons.skip_previous_rounded,
                            ),
                          ),
                          IconButton(
                            iconSize: 65.0,
                            splashColor: Colors.pink,
                            icon: AnimatedIcon(
                              icon: AnimatedIcons.play_pause,
                              progress: _animationController,
                            ),
                            onPressed: () => _handleOnPressed(),
                          ),
                          IconButton(
                            iconSize: 45.0,
                            color: Colors.black,
                            onPressed: () {
                              setState(() {
                                player.pause();
                                _animationController.reverse();
                                isPlaying = false;
                              });
                              if(nbMusic<MusicList.length-1){
                                nbMusic += 1;
                              } else if (nbMusic == (MusicList.length)-1){
                                nbMusic = 0;
                              }
                            },
                            icon: Icon(
                              Icons.skip_next_rounded,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              ],
            ),
          ),
          ),
      ),
    );
  }

  Future<void> _handleOnPressed() async {
    await player.setAudioSource(AudioSource.uri(Uri.parse(MusicList[nbMusic].urlSong)));

    if (!isPlaying){
      player.play();
    } else {
      player.pause();
    }
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }
}