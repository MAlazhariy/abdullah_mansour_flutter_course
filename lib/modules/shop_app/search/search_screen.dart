
import 'package:firstapp/modules/shop_app/cubit/shop_cubit.dart';
import 'package:firstapp/modules/shop_app/search/cubit/search_cubit.dart';
import 'package:firstapp/modules/shop_app/search/cubit/search_states.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var textController = TextEditingController();

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},

        builder: (context, state) {
          var cubit = SearchCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      whiteTextForm(
                        labelText: 'Search',
                        controller: textController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Can not be empty!';
                          }
                          return null;
                        },
                          suffix: const Icon(
                            Icons.search,
                          ),
                          keyboardType: TextInputType.text,
                          inputAction: TextInputAction.search,
                          onFieldSubmitted: (value) {
                            cubit.search(value);
                          },
                      ),
                      const SizedBox(height: 20),
                      if (state is SearchLoadingState)
                        const LinearProgressIndicator(),

                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {

                            return SizedBox(
                              height: 80,
                              child: Row(
                                children: [
                                  Image(
                                    image: NetworkImage(
                                      cubit.searchModel?.data.data[index].images.first??'https://image.winudf.com/v2/image1/Y29tLmF2aW5kZXIuZGV2ZW4uYmxhbmtfc2NyZWVuXzBfMTU2NzE2ODk5NV8wNDg/screen-0.jpg?fakeurl=1&type=.jpg',
                                    ),
                                    height: 80,
                                    width: 80,
                                    // fit: BoxFit.cover,
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // product name
                                          Expanded(
                                            child: Text(
                                              cubit.searchModel?.data.data[index].name??'',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                height: 1.3,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${cubit.searchModel?.data.data[index].price.floor()} L.E.',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: kMainColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      ShopCubit.get(context).changeFavorites(
                                        cubit.searchModel!.data.data[index].id,
                                      );
                                    },
                                    icon: Icon(
                                      ShopCubit.get(context).favorites[cubit.searchModel!.data.data[index].id]??false
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 20,
                                      color: ShopCubit.get(context).favorites[cubit.searchModel!.data.data[index].id]??false
                                          ? Colors.pink
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: cubit.searchModel?.data.data.length??0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
