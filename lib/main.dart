import 'package:before_after_image_slider_nullsafty/before_after_image_slider_nullsafty.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:panorama/panorama.dart';

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
      body: Container(
        child: Column(
          children: [
            Expanded(flex: 4, child: _buildPanoramic()),
            Expanded(flex: 2,child: _buildBeforeAfter()),
            Expanded(flex: 1,child: _buildGrid()),
          ],
        ),
      ),
      //_buildImageColumn(),
    );
  }

  void _showToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
            label: 'CLICKED', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  Widget _buildPanoramic() => Container(
      child: Panorama(
        interactive: true,
        sensorControl: SensorControl.AbsoluteOrientation,
          animSpeed: 0.1,
          latitude: 21.797201,
          longitude: -79.981584,
          hotspots: [
            Hotspot(
                width: 200,
                height: 100,
                name: "Trinidad",
                //latitude: 21.797201,
                //longitude: -79.981584,
                latitude: 21.801352,
                longitude: -79.972879,
                widget: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showToast(context, "Casa Algo en Trinidad");
                      });
                    },
                    child: Column(
                      children: const [
                        Expanded(child: Icon(Icons.info_rounded)),
                        Expanded(child: Text("Casa Algo en Trinidad"))
                      ],
                    ))),
            Hotspot(
              width: 200,
              height: 100,

              name: "Trinidad2",
              latitude: 15.797201,
              longitude: -20.981584,
              //latitude: 21.797387,
              //longitude: -79.981384
              widget: GestureDetector(
                onTap: () {
                  setState(() {
                    _showToast(context, "Centro de Trinidad");
                  });
                },
                child: Column(
                  children: const [
                    Expanded(child: Icon(Icons.info_rounded)),
                    Expanded(child: Text("Centro de Trinidad "))
                  ],
                ),
              ),
            ),
          ],
          child: Image.network(
            "https://ik.imagekit.io/6xgh00mrhaz/fixed_a1diPygsA.jpg",
          )));

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

  Widget _buildBeforeAfter() => BeforeAfter(
      beforeImage: OctoImage(
        image: const NetworkImage(
            'https://ik.imagekit.io/6xgh00mrhaz/before_M6xdpfY7N.jpg?updatedAt=1668091406373'),
        placeholderBuilder: OctoPlaceholder.blurHash(
          'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
        ),
        errorBuilder: OctoError.icon(color: Colors.red),
        fit: BoxFit.cover,
      ),
      afterImage: OctoImage(
        image: const NetworkImage(
            'https://ik.imagekit.io/6xgh00mrhaz/after_3uqabisEN.jpg?updatedAt=1668091406394'),
        placeholderBuilder: OctoPlaceholder.blurHash(
          'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
        ),
        errorBuilder: OctoError.icon(color: Colors.red),
        fit: BoxFit.cover,
      ));

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
