import 'package:flutter/material.dart';
import 'package:mamba/widgets/buttons/large_icon_button.dart';
import 'package:mamba/widgets/text/title_text.dart';

class PlanningSessionCoffeeBreakVotingCard extends StatefulWidget {
  final bool? vote;
  final Function(bool)? onVoteTap;

  const PlanningSessionCoffeeBreakVotingCard({
    super.key,
    this.vote,
    this.onVoteTap,
  });

  @override
  State<PlanningSessionCoffeeBreakVotingCard> createState() =>
      _PlanningSessionCoffeeBreakVotingCardState();
}

class _PlanningSessionCoffeeBreakVotingCardState
    extends State<PlanningSessionCoffeeBreakVotingCard> {
  _didTapUpVote() => widget.onVoteTap?.call(true);

  _didTapDownVote() => widget.onVoteTap?.call(false);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TitleText(text: "Coffee break vote"),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              children: [
                LargeIconButton(
                  highlighted: widget.vote == false,
                  icon: Icons.thumb_down,
                  onTap: _didTapDownVote,
                  toolTip: "Vote no for coffee break",
                ),
                LargeIconButton(
                  highlighted: widget.vote == true,
                  icon: Icons.thumb_up,
                  onTap: _didTapUpVote,
                  toolTip: "Vote yes for coffee break",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
