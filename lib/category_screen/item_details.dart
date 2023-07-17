import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controller/product_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../consts/list.dart';
import '../views/home_screen/components/featured_product_button.dart';
import '../widgets_common/our_button.dart';

class ItemDetails extends StatefulWidget {
  //same way me title get kar lege
  final String ? title;
  final dynamic data;
  final image;
  final String ? price;
  const ItemDetails({super.key, this.title, this.image, this.price, this.data});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  var productController = Get.find<ProductController>();
  var isExpanded = 3;     //delecaring outside build so that we satesate called is isExpanded not gain declear to 3

  @override
  void initState() {
    // TODO: implement initState
    productController.resetValues();     //so that all previous values become zero
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    int count = 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: widget.data['p_name'].toString()!.text.fontFamily(bold).color(darkFontGrey).make(),
        //actions is used to apllya ction on app bar
        actions: [
          IconButton(onPressed: (){}, icon:Icon(Icons.share)),
          IconButton(onPressed: (){}, icon:Icon(Icons.favorite_outline)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //swiper section
                    VxSwiper.builder(
                        aspectRatio: 16/9,
                        autoPlay: true,
                        height: 350,
                        viewportFraction: 1.0,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        itemCount: widget.data['p_imgs'].length,
                        itemBuilder: (context,index){
                          return Image.network(widget.data['p_imgs'][index],width: double.infinity,fit: BoxFit.cover).box.padding(EdgeInsets.symmetric(horizontal: 10)).make();
                        }
                    ),


                    //title ans details section
                    10.heightBox,
                    widget.data["p_name"].toString().text.size(16).color(darkFontGrey).fontFamily(semibold).make(),

                    //rating sysytem --->Velocityx
                    10.heightBox,
                    VxRating(
                      isSelectable: false,   //so that rating wont change
                      value: double.parse(widget.data['p_rating']),
                      onRatingUpdate: (value){},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5 ,
                      maxRating: 5,
                      size: 25,
                    ),

                    //price
                    10.heightBox,
                    widget.data['p_price'].toString().text.color(redColor).fontFamily(bold).size(18).make(),

                    //seller contect section
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Seller".text.color(darkFontGrey).fontFamily(semibold).make(),
                            5.heightBox,
                            widget.data['p_seller'].toString().text.fontFamily(semibold).color(darkFontGrey).size(16).make(),
                          ],
                        )),

                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.message_rounded,color: darkFontGrey,),
                        ),
                      ],
                    ).box.height(60).padding(EdgeInsets.symmetric(horizontal: 16)).color(lightGrey).make(),

                    //color
                    20.heightBox,
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 150,
                              child: "Color: ".text.color(textfieldGrey).size(22).make(),
                            ),


                            //color row  --> making tick opertaion on color choosen by user
                            Obx(()=> Row(
                                children: List.generate(widget.data['p_colors'].length,
                                        (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox().size(40, 40).roundedFull.color(Color(widget.data['p_colors'][index])).margin(EdgeInsets.symmetric(horizontal: 4)).make()
                                            .onTap(() {
                                              productController.colorChosenIndex.value  = index;
                                            }),
                                            //whatever color we choose this will show tick on it
                                            Visibility(
                                                visible: index == productController.colorChosenIndex.value,
                                                child: Icon(Icons.done,color: Colors.white,)
                                            )
                                          ],
                                        ),
                                ),
                              ).scrollHorizontal().expand(),
                            )

                          ],
                        ).box.padding(EdgeInsets.all(8)).make(),


                        //quantity row
                        Obx(()=> Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 150,
                                child: "Quantity: ".text.color(textfieldGrey).size(22).make(),
                              ),
                              Row(
                                children: [
                                  IconButton(onPressed: (){productController.decreaseQunatity();}, icon: Icon(Icons.remove)),
                                  productController.quantity.toString().text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                                  IconButton(onPressed: (){productController.increaseQunatity(widget.data['p_quantity']);}, icon: Icon(Icons.add)),
                                  "(${widget.data['p_quantity']} available)".text.color(textfieldGrey).make(),
                                ],
                              ).scrollHorizontal().expand(),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),
                        ),



                        //total price
                        Obx(()=> Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 150,
                                child: "Total Price: ".text.color(textfieldGrey).size(22).make(),
                              ),
                              //op----> making this OBX and showing price accordingly
                              // widget.data['p_price'] --> in string so first convert it to double
                              //the final product convert it to to string
                              (productController.quantity*double.parse(widget.data['p_price'])).toString().text.color(redColor).size(16).fontFamily(bold).make(),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),
                        ),


                        //descriptions section
                        20.heightBox,
                        Align(alignment:Alignment.centerLeft, child: "Description".text.color(darkFontGrey).fontFamily(semibold).make()),
                        10.heightBox,
                        Text(
                          widget.data['p_desc'].toString(),
                          maxLines: isExpanded, // Maximum number of lines to show initially
                          overflow: TextOverflow.ellipsis,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isExpanded = 100; // Set the expanded state to true
                            });
                          },
                          child: Text('View More'),
                        ),


                        //buttons section
                        20.heightBox,
                        ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                              itemDetailButtonList.length,
                              (index) => ListTile(
                                title: itemDetailButtonList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                                trailing: Icon(Icons.arrow_forward),
                              )),
                        ),
                        20.heightBox,

                        //products like section
                        "Products you may also like".text.fontFamily(bold).size(16).color(darkFontGrey).make(),
                        10.heightBox,
                        Row(
                          children:List.generate(featuredProducttitles.length, (index) => Container(
                            child: featuredProductButton(title: featuredProducttitles[index] , price: featuredProductPrice[index],image: featuredProductImages[index]),
                          )).toList(),
                        ).scrollHorizontal().box.make(),


                      ],
                    ).box.white.margin(EdgeInsets.symmetric(vertical: 10)).make()
                  ],
                ).scrollVertical().expand(),


              )
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ourButton(
              title: "Add To Cart",
              onpress: (){
                productController.addToCart(
                  title: widget.data['p_name'],
                  color: widget.data['p_colors'][productController.colorChosenIndex.value],
                  img: widget.data['p_imgs'][0],
                  context: context,
                  quantity: productController.quantity.value,
                  sellername: widget.data['p_seller'],
                  total_price: (productController.quantity*int.parse(widget.data['p_price'])).toString(),
                );
                VxToast.show(context, msg: "Added to Cart");
              },
              textcolor: whiteColor,
              buttoncolor: redColor,
            ),
          )
        ],
      ),
    );
  }
}
