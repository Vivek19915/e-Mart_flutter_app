import 'package:e_mart/consts/consts.dart';

import '../consts/list.dart';
import '../views/home_screen/components/featured_product_button.dart';
import '../widgets_common/our_button.dart';

class ItemDetails extends StatefulWidget {
  //same way me title get kar lege
  final String ? title;
  final image;
  final String ? price;
  const ItemDetails({super.key, this.title, this.image, this.price});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {

    int count = 0;
    bool isExpanded = false;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: widget.title!.text.fontFamily(bold).color(darkFontGrey).make(),
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
                        autoPlayCurve: Curves.fastOutSlowIn,
                        itemCount: 4,
                        itemBuilder: (context,index){
                          return Image.asset(widget.image,width: double.infinity,fit: BoxFit.cover).box.padding(EdgeInsets.symmetric(horizontal: 10)).make();
                        }
                    ),


                    //title ans details section
                    10.heightBox,
                    widget.title!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),

                    //rating sysytem --->Velocityx
                    10.heightBox,
                    VxRating(
                      onRatingUpdate: (value){},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      size: 25,
                      stepInt: true,
                    ),

                    //price
                    10.heightBox,
                    widget.price!.text.color(redColor).fontFamily(bold).size(18).make(),

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
                            "In House Brands".text.fontFamily(semibold).color(darkFontGrey).size(16).make(),
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
                            //color row
                            Row(
                              children: List.generate(10,
                                      (index) => VxBox().size(40, 40).roundedFull.color(Vx.randomPrimaryColor).margin(EdgeInsets.symmetric(horizontal: 4)).make(),
                              ),
                            ).scrollHorizontal().expand()

                          ],
                        ).box.padding(EdgeInsets.all(8)).make(),


                        //quantity row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 150,
                              child: "Quantity: ".text.color(textfieldGrey).size(22).make(),
                            ),
                            Row(
                              children: [
                                IconButton(onPressed: (){count--;}, icon: Icon(Icons.remove)),
                                "0".text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                                IconButton(onPressed: (){count++;}, icon: Icon(Icons.add)),
                                "(0 available)".text.color(textfieldGrey).make(),
                              ],
                            ).scrollHorizontal().expand(),
                          ],
                        ).box.padding(EdgeInsets.all(8)).make(),



                        //total price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 150,
                              child: "Total Price: ".text.color(textfieldGrey).size(22).make(),
                            ),
                            "\$0.00".text.color(redColor).size(16).fontFamily(bold).make(),
                          ],
                        ).box.padding(EdgeInsets.all(8)).make(),


                        //descriptions section
                        20.heightBox,
                        Align(alignment:Alignment.centerLeft, child: "Description".text.color(darkFontGrey).fontFamily(semibold).make()),
                        10.heightBox,
                        Text(
                          'Long text content goes here............Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam aliquam, nisl a tempor eleifend, ligula felis consequat nulla, eu pellentesque eros nisi eget mauris. Sed interdum, lorem sed condimentum fringilla, justo risus fringilla odio, nec ultrices odio lectus et est. Nam fermentum turpis eget ex placerat, eu eleifend sapien convallis. Duis pulvinar quam id sem luctus, id lacinia nibh scelerisque. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Mauris id dui finibus, efficitur ex id, fermentum nunc. Donec sit amet erat a ex sagittis eleifend id sit amet nisl. Fusce sem ex, tincidunt sit amet iaculis ac, consequat et lectus. Curabitur dignissim neque vel tortor finibus, sed feugiat orci condimentum. In sollicitudin bibendum enim id vestibulum. Mauris id diam a neque efficitur sollicitudin. Integer sit amet risus sapien. Etiam vulputate posuere vulputate.',
                          maxLines: isExpanded ? null : 3, // Maximum number of lines to show initially
                          overflow: TextOverflow.ellipsis,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            isExpanded =true; // Set the expanded state to true
                            setState(() {

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

                        //produts like section
                        "Products you may also like".text.fontFamily(bold).size(16).color(darkFontGrey).make(),
                        10.heightBox,
                        Row(
                          children:List.generate(featuredProducttitles.length, (index) => Container(
                            child: featuredProductButton(title: featuredProducttitles[index] , price: featuredProductPrice[index],image: featuredProductImages[index]),
                          )).toList(),
                        ).scrollHorizontal(),


                      ],
                    ).box.white.shadowSm.make()
                  ],
                ).scrollVertical().expand(),


              )
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ourButton(
              title: "Add To Cart",
              onpress: (){},
              textcolor: whiteColor,
              buttoncolor: redColor,
            ),
          )
        ],
      ),
    );
  }
}
