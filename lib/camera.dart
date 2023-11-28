import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

//availableCameras(): Lấy danh sách các camera khả dụng.
// MyApp(camera: firstCamera): Khởi chạy ứng dụng với widget MyApp và truyền thông tin của camera đầu tiên vào.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Khởi tạo camera
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  MyApp({required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraScreen(camera: camera),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  CameraScreen({required this.camera});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
//initState(): Hàm này được gọi khi widget được tạo.
// Trong đó, CameraController được khởi tạo với thông tin về camera và mức độ độ phân giải.
// Sau đó, camera được khởi tạo và khi nó đã sẵn sàng (_controller.initialize().then((_) {...}), trạng thái được cập nhật để build lại giao diện.
  @override
  void initState() {
    super.initState();
    // Khởi tạo camera controller
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Demo'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,//AspectRatio chứa CameraPreview, giúp hiển thị hình ảnh từ camera với tỷ lệ khung hình.
          child: CameraPreview(_controller),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            XFile image = await _controller.takePicture();
            // Xử lý hình ảnh ở đây (lưu, hiển thị, v.v.)
          } catch (e) {
            print(e);
          }
        },
        child: Icon(Icons.camera),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
