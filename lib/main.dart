import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ImageLoadTest(title: 'Flutter Image Load DEMO'),
    );
  }
}

class ImageLoadTest extends StatefulWidget {
  const ImageLoadTest({super.key, required this.title});

  final String title;

  @override
  State<ImageLoadTest> createState() => _ImageLoadTestState();
}

class _ImageLoadTestState extends State<ImageLoadTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _buildGrid(),
        //_buildImageColumn(),
      ),
    );
  }

  Widget _buildImageColumn() => Container(
        decoration: const BoxDecoration(
          color: Colors.black26,
        ),
        child: Column(
          children: [
            _buildImageRow(1),
            _buildImageRow(3),
          ],
        ),
      );

  Widget _buildImageRow(int imageIndex) => Row(
        children: [
          _buildDecoratedImage(
              'https://ik.imagekit.io/6xgh00mrhaz/SocialMedia/posters/image_$imageIndex.jpg'),
          _buildDecoratedImage(
              'https://ik.imagekit.io/6xgh00mrhaz/SocialMedia/posters/image_${imageIndex + 1}.jpg'),
        ],
      );

  Widget _buildDecoratedImage(String imageUrl) => Expanded(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 10, color: Colors.black26),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          margin: const EdgeInsets.all(4),
          child: Image.network(imageUrl, loadingBuilder: (BuildContext context,
              Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          }),
        ),
      );

  Widget _buildGrid() => GridView.extent(
      maxCrossAxisExtent: 150,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: _buildGridTileList(8));

  List<Container> _buildGridTileList(int count) => List.generate(
      count,
      (i) => Container(
              child: OctoImage(
            image: NetworkImage(
                'https://ik.imagekit.io/6xgh00mrhaz/SocialMedia/posters/image_$i.jpg'),
            placeholderBuilder: OctoPlaceholder.blurHash(
              'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
            ),
            errorBuilder: OctoError.icon(color: Colors.red),
            fit: BoxFit.cover,
          )));
}
