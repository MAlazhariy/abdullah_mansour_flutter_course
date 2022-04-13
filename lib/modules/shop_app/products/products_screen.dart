import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:firstapp/models/shop_app/home_model.dart';
import 'package:firstapp/modules/shop_app/cubit/shop_cubit.dart';
import 'package:firstapp/modules/shop_app/cubit/shop_states.dart';
import 'package:firstapp/shared/network/end_points.dart';
import 'package:firstapp/shared/network/remote/dio_helper.dart';
import 'package:firstapp/shared/styles/colors.dart';
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
        return _ProductsBuilder(
          homeModel: cubit.homeModel,
        );
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
    if (homeModel != null) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
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
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: 1 / 1.6,
              shrinkWrap: true,
              children: List.generate(
                homeModel!.data.products.length,
                (index) => _BuildGridProduct(
                  productModel: homeModel!.data.products[index],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox();
  }
}

class _BuildGridProduct extends StatelessWidget {
  const _BuildGridProduct({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(productModel.image),
                width: double.maxFinite,
                height: 200,
              ),
              // discount container
              if (productModel.discount > 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 6,
                  ),
                  child: Text(
                    '${productModel.discount}% OFF',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // product name
                Text(
                  productModel.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${productModel.price.floor()} L.E.',
                      style: const TextStyle(
                        fontSize: 14,
                        color: kMainColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    if (productModel.discount > 0)
                      Text(
                        '${productModel.oldPrice.floor()}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: kGreyColor,
                          decorationStyle: TextDecorationStyle.wavy,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        // DioHelper.postData(
                        //   path: FAVORITES,
                        //   data: {
                        //     'product_id': productModel.id,
                        //   },
                        // );
                      },
                      icon: Icon(
                        productModel.inFavorites
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 20,
                        color: productModel.inFavorites
                            ? Colors.pink
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
