import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

class ProductDetails extends StatefulWidget {
  final List _productContentList;
  ProductDetails(this._productContentList, {Key key}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with AutomaticKeepAliveClientMixin {
  double progress = 0;
  var _id;
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    print(widget._productContentList[0].sId);
    this._id = widget._productContentList[0].sId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: InAppWebView(
              initialUrl: "http://jd.itying.com/pcontent?id=${this._id}",
              // onProgressChanged:
              //     (InAppWebViewController controller, int progress) {
              //       setState(() {
              //           this.progress = progress/100;
              //         });
              //     },
            ),
          ),
        ],
      ),
    );
  }
}
