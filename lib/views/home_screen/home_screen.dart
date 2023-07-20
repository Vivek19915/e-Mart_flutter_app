import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/category_screen/item_details.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/consts/list.dart';
import 'package:e_mart/services/firestore_services.dart';
import 'package:e_mart/views/home_screen/components/featured_button.dart';
import 'package:e_mart/views/home_screen/components/featured_product_button.dart';
import 'package:e_mart/widgets_common/home_buttons.dart';
import 'package:e_mart/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightGrey,
      padding: EdgeInsets.all(12),
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(            //avoids notch and curvers of screen
        child: Column(
          children: [
            Container(
              height: 60,
              alignment: Alignment.center,
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Search Anything....",
                  hintStyle: TextStyle(color: textfieldGrey),

                ),
              ),
            ),
            20.heightBox,

            Column(
              children: [
                //Swipers brands   -->using velocity x
                VxSwiper.builder(
                    aspectRatio: 16/9,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    height: 150,
                    itemCount: sliderList.length,
                    itemBuilder: (context,index){
                      return Image.asset(sliderList[index],fit: BoxFit.fill).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8)).make();
                    }),
                20.heightBox,

                //adding 2 home buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    homeButtons(title: "Today's Deal",icon: icTodaysDeal,width: context.screenWidth/2.5,height: context.screenHeight*0.15),
                    homeButtons(title: "Flash Deal",icon: icFlashDeal,width: context.screenWidth/2.5,height: context.screenHeight*0.15),

                  ],
                ),

                //2nd swiper
                20.heightBox,
                VxSwiper.builder(
                    aspectRatio: 16/9,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    height: 150,
                    itemCount: secondSliderList.length,
                    itemBuilder: (context,index){
                      return Image.asset(secondSliderList[index],fit: BoxFit.fill).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8)).make();
                    }),


                //adding  3  more  home buttons
                20.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    homeButtons(title: "Top Categories",icon: icTopCategories,width: context.screenWidth/3.5,height: context.screenHeight*0.15),
                    homeButtons(title: "Brands",icon: icBrands,width: context.screenWidth/3.5,height: context.screenHeight*0.15),
                    homeButtons(title: "Top Sellers",icon: icTopSeller,width: context.screenWidth/3.5,height: context.screenHeight*0.15),
                  ],
                ),

                //featured categories
                20.heightBox,
                Align(alignment:Alignment.centerLeft,child: "Featured Categories".text.color(darkFontGrey).size(22).fontFamily(bold).make()),
                20.heightBox,


                // featured items
                Row(
                  children: List.generate(3, (index) =>Column(
                    children: [
                      featuredButton(title: featuredTitles1[index] , image: featuredImages1[index]),
                      10.heightBox,
                      featuredButton(title: featuredTitles2[index] , image: featuredImages2[index]),
                    ],
                  )).toList(),      //generating 3 list item of coloumns---> children take list as input
                ).scrollHorizontal(),


                //featured product
                20.heightBox,
                Container(
                  padding: EdgeInsets.all(12),
                  width: double.infinity,
                  color: redColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Featured Products".text.fontFamily(bold).white.size(22).make(),
                      10.heightBox,
                      Row(
                        children:List.generate(featuredProducttitles.length, (index) => Container(
                          child: featuredProductButton(title: featuredProducttitles[index] , price: featuredProductPrice[index],image: featuredProductImages[index]),
                        )).toList(),
                      ).scrollHorizontal(),
                    ],
                  ),
                ),



                //third swiper
                20.heightBox,
                VxSwiper.builder(
                    aspectRatio: 16/9,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    height: 150,
                    itemCount: secondSliderList.length,
                    itemBuilder: (context,index){
                      return Image.asset(secondSliderList[index],fit: BoxFit.fill).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8)).make();
                    }),
                
                
                //all products section
                // --->>> for this we will use grid view
                20.heightBox,

                StreamBuilder(
                    stream: FirestoreServices.getAllProducts(),
                    builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
                      if(snapshot.hasData == false){
                        return Container(child: loadingIndicator(),);
                      }
                      else {
                        var data = snapshot.data!.docs;

                        return  GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,   //since we are using it in side coloumn
                            itemCount: data.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 240),
                            itemBuilder: (context,index){
                              return Column(
                                children: [
                                  Image.network(data[index]['p_imgs'][0],width: 180,height: 120,fit: BoxFit.fitHeight,).box.padding(EdgeInsets.all(12)).make(),
                                  data[index]['p_name'].toString().text.color(fontGrey).make(),
                                  10.heightBox,
                                  data[index]['p_price'].toString().numCurrency.text.color(redColor).size(22).make(),
                                ],
                              ).onTap(() {
                                Get.to(()=>ItemDetails(
                                  title: data[index]['p_name'],
                                  data: data[index],
                                ));
                              }).box.white.roundedSM.shadowSm.margin(EdgeInsets.all(6)).make();
                            }
                        );
                      }
                    })








              ],
            ).scrollVertical().expand(),                            //  -->>making scrollable and expanded widget
          ],
        ),
      ),
    );
  }
}
