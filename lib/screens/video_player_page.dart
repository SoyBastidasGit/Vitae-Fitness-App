import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vitae_fitness/models/models.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  final VideoItem video;

  const VideoPlayerPage({required this.video, super.key});

  @override
  VideoPlayerPageState createState() => VideoPlayerPageState();
}

class VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Extraer el ID del video de la URL
    String? videoId = YoutubePlayer.convertUrlToId(widget.video.url);

    if (videoId != null) {
      // Inicializar el controlador con el ID del video
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    } else {
      // Si no se pudo obtener el ID, se maneja el error
      _controller = YoutubePlayerController(
        initialVideoId: '', // Sin video para evitar error
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.video.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Reproductor de YouTube con borderRadius
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(10), // Agrega el borderRadius aquí
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                onReady: () {
                  if (kDebugMode) {
                    print('Reproductor listo');
                  }
                },
                onEnded: (error) {
                  if (kDebugMode) {
                    print('Error en el reproductor: $error');
                  }
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.video.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
