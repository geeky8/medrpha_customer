import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/controller/customer_controller.dart';
import 'package:flutter_medical_ui/controller/local_session_controller.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'apicalls/api_service.dart';
import 'controller/image_controller.dart';
import 'controller/product_controller.dart';
import 'model/navigation_service.dart';
import 'myWidget/file_selection_btn.dart';
import 'myWidget/my_snack_bar.dart';

class MyUploadPage extends StatelessWidget {
  MyUploadPage({upload = 'New Page', picType = 'dl', picNo = 1}) {
    this.title = upload;
    this.picType = picType;
    this.picNo = picNo;
  }
  static const blankStringUri = "https://medrpha.com/user_reg/no_image.png";
  //TODO: https://medrpha.com/user_reg/
  //static const pictureStringUri = "https://test.medrpha.com/user_reg/";
  static const pictureStringUri = "https://medrpha.com/user_reg/";
  String title, picType, _sessionID;
  int picNo;

  var _imageUploading = false.obs;

  ImageController imageController;
  ScrollController _scrollController;

  Future<void> showImagePicker(ImageSource imageSource) async {
    print('This is from Image picker');

    await imageController.getImage(imageSource);
    //double height = MediaQuery.of(context).size.height;
    _scrollController.animateTo(
        300, // 100 is the height of container and index of 6th element is 5
        duration: const Duration(seconds: 4),
        curve: Curves.easeOut);
  }

  String getCustomerPic() {
    CustomerController cs = Get.find<CustomerController>();
    if (picType == 'fssai') {
      return cs.customer.value.pic3;
    } else {
      if (picNo == 1) {
        return cs.customer.value.dl1;
      } else {
        return cs.customer.value.dl2;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var _picName = ''.obs;
    imageController = ImageController();
    LocalSessionController ls = Get.find<LocalSessionController>();
    _sessionID = ls.getSessionValue();
    ScrollController _controller = new ScrollController();
    CustomerController cs = Get.find<CustomerController>();

    double profileHeight = 100;
    double defaultMargin = 15;
    int imageType;
    _picName.value = getCustomerPic();
    if (picType == 'fssai') {
      imageType = 3;
    } else {
      imageType = picNo;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Upload ' + title),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                  color: ConstantData.cellColor,
                  height: profileHeight + (profileHeight / 5),
                  child: Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: profileHeight,
                            width: profileHeight,
                            decoration: BoxDecoration(
                                color: ConstantData.primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ConstantData.primaryColor,
                                )),
                            child: ClipOval(
                              child: Material(
                                color: Colors.cyan.shade50,
                                child:
                                    getProfileImage(i: picType == 'dl' ? 3 : 4),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: defaultMargin),
                  color: ConstantData.cellColor,
                  // color: ConstantData.cellColor,
                  padding: EdgeInsets.all(defaultMargin),
                  child: ListView(
                    controller: _controller,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            ConstantWidget.getCustomTextWithoutAlign(
                                'Your ${title} Proof',
                                ConstantData.mainTextColor,
                                FontWeight.bold,
                                16),
                            SizedBox(width: 10),
                            Obx(
                              () => Visibility(
                                visible: !cs.fssaiSaved.value,
                                child: Text('Data Not Saved!!',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.red)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: (defaultMargin / 2),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          //Show uploaded Image

                          Obx(
                            () => _picName.value.length > 0
                                ? SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text('Your uploaded ${title} document'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        _picName.value == 'no_image.png'
                                            ? Image.network(blankStringUri)
                                            : Image.network(pictureStringUri +
                                                cs.customer.value.phoneno +
                                                '/' +
                                                _picName.value)
                                      ],
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.all(20),
                                    child: Text('${title} not uploaded')),
                          ),

                          Obx(
                            () => Visibility(
                              visible:
                                  imageController.selectedImagePath.value != ''
                                      ? true
                                      : false,
                              child: Column(
                                children: [
                                  SizedBox(height: 25),
                                  Divider(),
                                  SizedBox(height: 10),
                                  Text('Upload this Proof document to server?',
                                      style: TextStyle(fontSize: 16)),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      uploadBtn(
                                          bgColor: Colors.green.shade50,
                                          iconName: Icons.check,
                                          iconColor: Colors.green,
                                          fn: () async {
                                            print('yes');
                                            _imageUploading.value = true;
                                            String res =
                                                await ApiService.uploadImage(
                                                    imageController
                                                        .selectedImagePath
                                                        .value,
                                                    _sessionID,
                                                    imageType: imageType);
                                            print(res);
                                            if (res == "OK") {
                                              //image successfully uploaded
                                              showSnackbarDialog(
                                                  NavigationService.navigatorKey
                                                      .currentContext,
                                                  '${title} document successfully uploaded',
                                                  bgColor:
                                                      Colors.green.shade400);
                                              imageController
                                                  .selectedImagePath.value = '';
                                              await cs.loadCustomerData();
                                              print(
                                                  'pic name before upload  ${_picName.value}');
                                              _picName.value = getCustomerPic();
                                              print(
                                                  'pic name after upload  ${_picName.value}');
                                              Get.find<ProductController>()
                                                  .hideProductPrice(true);
                                            } else {
                                              showSnackbarDialog(
                                                  NavigationService.navigatorKey
                                                      .currentContext,
                                                  'Error uploading Image. Try again later');
                                              //image not uploaded
                                            }
                                            _imageUploading.value = false;
                                          },
                                          height: 20,
                                          btnText: '  Upload  '),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      uploadBtn(
                                          bgColor: Colors.red.shade50,
                                          iconName: Icons.clear,
                                          iconColor: Colors.red,
                                          fn: () {
                                            print('no');
                                            imageController
                                                .selectedImagePath.value = '';
                                          },
                                          height: 20,
                                          btnText: '  Discard  '),
                                    ],
                                  ),
                                  Obx(
                                    () => Visibility(
                                      visible: _imageUploading.value,
                                      child: Container(
                                          padding: EdgeInsets.only(top: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CircularProgressIndicator(),
                                              Text('Uploading document.... '),
                                              Text(
                                                  'Please don\'t press the Upload or the Discard button till the picture is being uploaded',
                                                  style:
                                                      TextStyle(fontSize: 10)),
                                            ],
                                          )),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  imageController.selectedImagePath.value != ''
                                      ? Image.file(File(imageController
                                          .selectedImagePath.value))
                                      : Text(' '),
                                ],
                              ),
                            ),
                          ),

                          Column(
                            children: [
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cloud_upload_outlined,
                                    size: 20,
                                    color: Colors.blue.shade600,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Update Your ${title} document',
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                              Text('(Only Picture Allowed)'),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  uploadBtn(
                                      iconName: Icons.camera,
                                      iconColor: Colors.orange,
                                      fn: () async {
                                        await showImagePicker(
                                            ImageSource.camera);
                                      },
                                      btnText: 'From Camera'),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  uploadBtn(
                                      iconName: Icons.insert_photo,
                                      iconColor: Colors.blue,
                                      fn: () async {
                                        await showImagePicker(
                                          ImageSource.gallery,
                                        );
                                        print('returned from function ');
                                      },
                                      btnText: 'From Gallery'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getProfileImage({int i}) {
    String imgName = "logo_transparent.png";
    print('The image sel ${i}');
    if (i == 2) {
      imgName = "gst.png";
    } else if (i == 4) {
      imgName = "fssai.png";
    } else if (i == 3) {
      imgName = "dl.jpg";
    }
    return Image.asset(
      ConstantData.assetsPath + imgName,
      fit: BoxFit.cover,
    );
  }
}
