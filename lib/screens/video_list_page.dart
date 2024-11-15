import 'package:flutter/material.dart';
import 'package:vitae_fitness/models/models.dart';
import 'video_player_page.dart';

class VideoListPage extends StatelessWidget {
  final String title;

  VideoListPage({required this.title, super.key});

  // Lista de videos para Quemar Grasa
  final List<VideoItem> burnFatVideos = [
    VideoItem(
      title: 'Cardio para Quemar Grasa Rápidamente',
      url: 'https://www.youtube.com/watch?v=erpAjBqBBnU',
    ),
  ];

  // Lista de videos para Aumento Muscular
  final List<VideoItem> muscleGainVideos = [
    VideoItem(
      title: 'Cómo GANAR MÚSCULO SIN PESAS',
      url: 'https://www.youtube.com/watch?v=3S3jw1tdNII',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(title),
          ),
      body: ListView(
        children: _getVideoSections(context),
      ),
    );
  }

  // Obtiene las secciones a mostrar basadas en el título
  List<Widget> _getVideoSections(BuildContext context) {
    if (title == 'Quemar Grasa') {
      return [_buildVideoSection('Quemar Grasa', burnFatVideos, context)];
    } else if (title == 'Aumento Muscular') {
      return [
        _buildVideoSection('Aumento Muscular', muscleGainVideos, context)
      ];
    } else {
      return [];
    }
  }

  Widget _buildVideoSection(
      String sectionTitle, List<VideoItem> videos, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            return ListTile(
              title: Text(video.title),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerPage(video: video),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
