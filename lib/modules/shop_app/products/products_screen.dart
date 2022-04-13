import 'package:carousel_slider/carousel_slider.dart';
import 'package:firstapp/models/shop_app/home_model.dart';
import 'package:firstapp/modules/shop_app/cubit/shop_cubit.dart';
import 'package:firstapp/modules/shop_app/cubit/shop_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);

        if (cubit.homeModel == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return _ProductsBuilder(homeModel: cubit.homeModel,);
      },
    );
  }
}

class _ProductsBuilder extends StatelessWidget {
  const _ProductsBuilder({
    Key? key,
    required this.homeModel,
  }) : super(key: key);

  final HomeModel? homeModel;

  @override
  Widget build(BuildContext context) {
    if(homeModel != null) {
      return Column(
      children: [
        CarouselSlider(
          items: homeModel!.data.banners
              .map((e) => Image(
                    image: NetworkImage(e.image),
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ))
              .toList(),
          options: CarouselOptions(
            height: 250,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            viewportFraction: 1.0,
          ),
        ),
      ],
    );
    }

    return const SizedBox();
  }
}
