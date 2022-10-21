import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/cubit/app_cubit_states.dart';
import 'package:travel_app/cubit/app_cubits.dart';
import 'package:travel_app/misc/colors.dart';
import 'package:travel_app/widgets/app_buttons.dart';
import 'package:travel_app/widgets/app_large_text.dart';
import 'package:travel_app/widgets/app_text.dart';
import 'package:travel_app/widgets/responsive_button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int gottenStars = 4;
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits,CubitStates>(builder: (context,state){
      DetailState detail = state as DetailState;
      return Scaffold(
        body:Container(
          width:double.maxFinite,
          height:double.maxFinite,
          child: Stack(
            children: [
              Positioned(
                  left: 0,
                  right:0,
                  child: Container(
                    width:double.maxFinite ,
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("http://mark.bslmeiyu.com/uploads/"+detail.place.img),
                          fit:BoxFit.cover
                      ),
                    ),
                  )),
              Positioned(
                  left:20,
                  top:40,
                  child: Row(
                    children: [
                      IconButton(onPressed: (){
                        BlocProvider.of<AppCubits>(context).goHome();
                      }, icon: Icon(Icons.menu),
                        color:Colors.white,
                      )
                    ],
                  )),
              Positioned(
                  top:270,
                  child: Container(
                    padding: const EdgeInsets.only(left:20,right:20,top:20),
                    width: MediaQuery.of(context).size.width ,
                    height:500,
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)
                      ),
                    ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppLargeText(text: detail.place.name,color:Colors.black54.withOpacity(0.8)),
                            AppLargeText(text: "\$"+ detail.place.price.toString(),color:AppColors.mainColor)
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: AppColors.mainColor,),
                            SizedBox(width: 5,),
                            AppText(text: detail.place.location, color: AppColors.textColor1,)
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Wrap(
                              children: List.generate(5, (index) {
                                return  Icon(Icons.star, color: index< detail.place.stars ?AppColors.starColor:AppColors.textColor2,);
                              }),
                            ),
                            SizedBox(width: 10,),
                            AppText(text: "(5.0)",color: AppColors.textColor2,)
                          ],
                        ),
                        SizedBox(height: 23,),
                        AppLargeText(text: "People",color: Colors.black.withOpacity(0.8),size:20 ,),
                        SizedBox(height:5),
                        AppText(text: "Number of people in your group",color: AppColors.mainTextColor,),
                        SizedBox(height:10),
                        Wrap(
                          children: List.generate(5, (index) {
                            return InkWell(
                              onTap: (){
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 7),
                                child: AppButtons(size: 50,
                                  color: selectedIndex == index ? Colors.white : Colors.black,
                                  backgroundColor: selectedIndex == index ? Colors.black : AppColors.buttonBackground,
                                  borderColor: selectedIndex == index ? Colors.black : AppColors.buttonBackground,
                                  text: (index+1).toString(),
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(height:10),
                        AppLargeText(text: "Description",color: Colors.black.withOpacity(0.8),size:20),
                        SizedBox(height: 5,),
                        AppText(text: "You must go for a travel. Travelling helps get rid of pressure. Go to the mountains to see the nature.",color: AppColors.mainTextColor,),

                      ],
                    ),
                  )),
              Positioned(
                bottom: 10,
                left:20,
                right: 20,
                child: Row(
                  children: [
                    AppButtons(
                        size: 50,
                        color: AppColors.textColor1,
                        backgroundColor: Colors.white,
                        borderColor: AppColors.textColor1,
                        isIcon:true,
                        icon:Icons.favorite_border
                    ),
                    SizedBox(width: 20,),
                    ResponsiveButton(
                      isResponsive: true,
                    )
                  ],
                ),)
            ],
          ),
        ),
      );
    });
  }
}
