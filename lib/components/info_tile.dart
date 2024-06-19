import "package:flutter/material.dart";

class InfoTile extends StatelessWidget {
  String leading;
  String trailing;
  InfoTile({super.key,required this.leading,required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  splashColor: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(4.0),
                    leading: Text(leading,style: Theme.of(context).textTheme.headlineSmall),
                    trailing: Text(trailing,style: Theme.of(context).textTheme.headlineSmall)
                  ),
                ),
              );
  }
}