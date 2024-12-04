import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_ui/components/event_tile.dart';
import 'package:mobile_ui/components/my_drawer.dart';
import 'package:mobile_ui/components/my_heat_map.dart';
import 'package:mobile_ui/databases/event_database.dart';
import 'package:mobile_ui/models/event.dart';
import 'package:mobile_ui/util/event_util.dart';
import 'package:provider/provider.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {

  @override
  void initState() {

    // read existing events on app startup
    Provider.of<EventDatabase>(context, listen: false).readEvents();

    super.initState();
  }

  // text controller
  final TextEditingController textController = TextEditingController();

  // create new event
  void createNewEvent() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: 'Create a new event',
          ),
        ),
        actions: [
          // save button
          MaterialButton(
            onPressed: () {
              // get the new event name
              String newEventName = textController.text;

              // save to db
              context.read<EventDatabase>().addEvent(newEventName);

              // pop box
              Navigator.pop(context);

              // clear controller
              textController.clear();
            },
            child: const Text('Save'),
          ),

          // cancel button
          MaterialButton(
            onPressed: () {
              // pop box
              Navigator.pop(context);

              // clear controller
              textController.clear();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  // check event on & off
  void checkEventOnOff(bool? value, Event event) {
    // update event completion status
    if (value != null) {
      context.read<EventDatabase>().updateEventCompletion(event.id, value);
    }
  }

  // edit event box
  void editEventBox(Event event) {
    // set the controller's text to the event's current name
    textController.text = event.name;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          // save button
          MaterialButton(
            onPressed: () {
              // get the new event name
              String newEventName = textController.text;

              // save to db
              context.read<EventDatabase>().updateEventName(event.id, newEventName);

              // pop box
              Navigator.pop(context);

              // clear controller
              textController.clear();
            },
            child: const Text('Save'),
          ),

          // cancel button
          MaterialButton(
            onPressed: () {
              // pop box
              Navigator.pop(context);

              // clear controller
              textController.clear();
            },
            child: const Text('Cancel'),
          ),
        ],
      )
    );
  }

  // delete event box
  void deleteEventBox(Event event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure you want to delete?'),
        actions: [
          // delete button
          MaterialButton(
            onPressed: () {
              // delete from db
              context.read<EventDatabase>().deleteEvent(event.id);

              // pop box
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),

          // cancel button
          MaterialButton(
            onPressed: () {
              // pop box
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
                  'Set your own events',
                  style: GoogleFonts.dmSerifText(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewEvent,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          // heat map
          _buildHeatMap(),

          // event list
          _buildEventList(),
        ],
      )
    );
  }

  // build heat map
  Widget _buildHeatMap() {
    // event database
    final eventDatabase = context.watch<EventDatabase>();

    // current events
    List<Event> currentEvents = eventDatabase.currentEvents;

    // return heat map UI
    return FutureBuilder(
      future: eventDatabase.getFirstLaunchDate(),
      builder: (context, snapshot) {
        // once the data is available -> build heatmap
        if (snapshot.hasData) {
          return MyHeatMap(
            datasets: prepHeatMapDataset(currentEvents),
            startDate: snapshot.data!,
          );
        }

        // handle case where no data is returned
        else {
          return Container();
        }
      }
    );
  }

  // build event list
  Widget _buildEventList() {
    // event db
    final eventDatabase = context.watch<EventDatabase>();

    // current events
    List<Event> currentEvents = eventDatabase.currentEvents;

    // return list of events UI
    return ListView.builder(
      itemCount: currentEvents.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        // get each individual event
        final event = currentEvents[index];

        // check if the event is completed today
        bool isCompletedToday = isEventCompletedToday(event.completedDays);

        // return event tile UI
        return EventTile(
          text: event.name,
          isCompleted: isCompletedToday,
          onChanged: (value) => checkEventOnOff(value, event),
          editEvent: (context) => editEventBox(event),
          deleteEvent: (context) => deleteEventBox(event),
        );
      }
    );
  }
}