import 'package:ams_count/blocs/count/count_bloc.dart';
import 'package:ams_count/config/app_constants.dart';
import 'package:ams_count/models/count/listImageAssetModel.dart';
import 'package:ams_count/widgets/custom_textfield.dart';
import 'package:ams_count/widgets/label.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_preview/flutter_image_preview.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:photo_view/photo_view.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<ListImageAssetModel> _imageList = [];
  List<ListImageAssetModel> _tempimageList = [];

  @override
  void initState() {
    BlocProvider.of<CountBloc>(context).add(GetListImageAssetsEvent(""));
    super.initState();
  }

  void _serachItemModel(String value) {
    List<ListImageAssetModel> searchResults = _tempimageList
        .where((element) => element.ASSETS_CODE == value)
        .toList();
    if (searchResults.isNotEmpty) {
      _imageList = searchResults;
    } else {
      _imageList = _tempimageList;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CountBloc, CountState>(listener: (context, state) async {
          if (state is GetListImageAssetLoadedState) {
            _imageList = state.item;
            _tempimageList = state.item;
          }
          setState(() {});
        })
      ],
      child: Scaffold(
        appBar: EasySearchBar(
          title: Label("Gallery"),
          onSearch: (value) {
            _serachItemModel(value);
          },
          searchHintText: "Please Input Barcode",
        ),
        body: _imageList.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: _imageList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Get.toNamed('/ScanPage', arguments: {
                      //   'assetsCode': _imageList[index].ASSETS_CODE
                      // });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          elevation: 10,
                          child: Column(
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 0,
                                  color: Colors.white,
                                  shape: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          printInfo(
                                              info:
                                                  "${_imageList[index].URL_IMAGE}");
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child: PhotoView(
                                                          imageProvider:
                                                              NetworkImage(
                                                            "${_imageList[index].URL_IMAGE ?? "https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg"}",
                                                          ),
                                                        ),
                                                      ),
                                                      Label(
                                                        "${_imageList[index].ASSETS_CODE}",
                                                        color: colorPrimary,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          ElevatedButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              child:
                                                                  Label("OK"))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child:
                                            _imageList[index].URL_IMAGE != null
                                                ? Image.network(
                                                    "${_imageList[index].URL_IMAGE ?? "https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg"}",
                                                  )
                                                : CircularProgressIndicator(),
                                      )),
                                ),
                              )),
                              Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Label(
                                          "${_imageList[index].ASSETS_CODE}",
                                          fontSize: 14,
                                          color: colorPrimary,
                                        ),
                                      ],
                                    ),
                                  ))
                            ],
                          )),
                    ),
                  );
                })
            : Container(),
      ),
    );
  }
}
