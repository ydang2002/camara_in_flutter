import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyImagePicker(),
    );
  }
}

class MyImagePicker extends StatefulWidget {
  @override
  _MyImagePickerState createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  XFile? _image;// _image để lưu trữ hình ảnh được chọn từ thư viện.

  // Hàm để chọn hình ảnh từ thư viện
  //Hàm _pickImage() sử dụng ImagePicker để mở thư viện ảnh và chọn một hình ảnh.
  // Sau đó, nó cập nhật trạng thái bằng cách gọi setState và đặt giá trị _image
  // thành đường dẫn của hình ảnh đã chọn.
  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = XFile(pickedImage!.path);
    });
  }


  //body chứa một Center với một điều kiện: nếu _image là null, hiển thị một văn bản "Chưa chọn hình ảnh",
  // nếu không, hiển thị hình ảnh từ đường dẫn _image!.path.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chọn Hình Ảnh'),
      ),
      body: Center(
        child: _image == null
            ? Text('Chưa chọn hình ảnh')
            : Image.file(File(_image!.path)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: 'Chọn Hình Ảnh',
        child: Icon(Icons.photo_library),
      ),
    );
  }
}
//floatingActionButton là một nút hoạt động để gọi hàm _pickImage
// khi được nhấn, và có một biểu tượng là một hình ảnh từ thư viện
