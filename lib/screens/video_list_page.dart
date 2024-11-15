import 'package:flutter/material.dart';
import 'package:vitae_fitness/models/models.dart';
import 'package:vitae_fitness/themes.dart';
import 'video_player_page.dart';

class VideoListPage extends StatelessWidget {
  final String title;

  VideoListPage({required this.title, super.key});

  // Lista de videos para Quemar Grasa
  final List<VideoItem> burnFatVideos = [
    VideoItem(
      title: 'Cardio para quemar grasa',
      url: 'https://www.youtube.com/watch?v=erpAjBqBBnU',
      urlImage:
          'https://cdn.businessinsider.es/sites/navi.axelspringer.es/public/media/image/2022/06/como-perder-grasa-abdominal-2727479.jpg?tf=1200x',
    ),
    VideoItem(
      title: 'Cardio para quemar grasa',
      url: 'https://www.youtube.com/watch?v=erpAjBqBBnU',
      urlImage:
          'https://cdn.businessinsider.es/sites/navi.axelspringer.es/public/media/image/2022/06/como-perder-grasa-abdominal-2727479.jpg?tf=1200x',
    ),
    VideoItem(
      title: 'Cardio para quemar grasa',
      url: 'https://www.youtube.com/watch?v=erpAjBqBBnU',
      urlImage:
          'https://cdn.businessinsider.es/sites/navi.axelspringer.es/public/media/image/2022/06/como-perder-grasa-abdominal-2727479.jpg?tf=1200x',
    ),
  ];

  // Lista de videos para Aumento Muscular
  final List<VideoItem> muscleGainVideos = [
    VideoItem(
      title: 'Como ganar musculo',
      url: 'https://www.youtube.com/watch?v=3S3jw1tdNII',
      urlImage:
          'https://cdn0.uncomo.com/es/posts/9/9/2/como_ganar_musculo_en_los_brazos_44299_600.webp',
    ),
    VideoItem(
      title: 'Como ganar musculo',
      url: 'https://www.youtube.com/watch?v=3S3jw1tdNII',
      urlImage:
          'https://cdn0.uncomo.com/es/posts/9/9/2/como_ganar_musculo_en_los_brazos_44299_600.webp',
    ),
    VideoItem(
      title: 'Como ganar musculo',
      url: 'https://www.youtube.com/watch?v=3S3jw1tdNII',
      urlImage:
          'https://cdn0.uncomo.com/es/posts/9/9/2/como_ganar_musculo_en_los_brazos_44299_600.webp',
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
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerPage(video: video),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // Imagen del video
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          video.urlImage,
                          width: 100,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Título del video
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              video.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Ver video',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.inputFillColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
