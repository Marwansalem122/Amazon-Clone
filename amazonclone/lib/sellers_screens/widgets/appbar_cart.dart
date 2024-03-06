import 'package:amazonclone/assistant_method/cart_item_counter.dart';
import 'package:amazonclone/cartScreen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:amazonclone/common/widgets/flutter_toast.dart';

// ignore: must_be_immutable
class AppBarWithCartBadge extends StatefulWidget
    implements PreferredSizeWidget {
  PreferredSizeWidget? preferredSizeWidget;
  String? sellerUid;

  AppBarWithCartBadge({
    super.key,
    this.preferredSizeWidget,
    this.sellerUid,
  });

  @override
  State<AppBarWithCartBadge> createState() => _AppBarWithCartBadgeState();
  @override
  // ignore: unnecessary_null_comparison, recursive_getters
  Size get preferredSize =>
      preferredSizeWidget?.preferredSize ?? const Size(56, kToolbarHeight);
}

class _AppBarWithCartBadgeState extends State<AppBarWithCartBadge> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.pinkAccent,
            Colors.purpleAccent,
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        )),
      ),
      automaticallyImplyLeading: true,
      title: Text("iShop", style: TextStyle(fontSize: 20.sp, letterSpacing: 3)),
      actions: [
        Stack(
          children: [
            IconButton(
                onPressed: () {
                  int itemInCart =
                      Provider.of<CartItemCounter>(context, listen: false)
                          .count;

                  if (itemInCart > 0) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            CartScreen(sellerUId: widget.sellerUid)));
                  } else {
                    toastInfo(
                        msg:
                            "There are not items in the Cart.\nPlease add some items to cart");
                  }
                },
                icon: const Icon(Icons.shopping_cart, color: Colors.white)),
            Positioned(
                child: Stack(
              children: [
                const Icon(
                  Icons.brightness_1,
                  size: 20,
                  color: Colors.deepPurpleAccent,
                ),
                Positioned(
                  top: 2,
                  right: 6,
                  child: Center(child: Consumer<CartItemCounter>(
                    builder: (context, counter, c) {
                      return Text(counter.count.toString(),
                          style: const TextStyle(color: Colors.white));
                    },
                  )),
                ),
              ],
            ))
          ],
        )
      ],
    );
  }
}
