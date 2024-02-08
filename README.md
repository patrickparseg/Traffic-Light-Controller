# Traffic-Light-Controller

Implemented a traffic light controller using a state machine design which controls a main street, a side street, and walk lamps.

The traffic light controller is for an intersection between a Main Street and a Side Street. Both streets have a red, yellow, and
green signal light. Pedestrians have the option of pressing a walk button to turn all the traffic lights red and cause a single walk
light to illuminate. Moreover, there is a sensor on the Side Street which tells the controller if there are cars still on the Side
Street. 

There are several ways the controller can deviate from the typical loop:
### 1) 
A walk button allows pedestrians to submit a walk request. The internal Walk Register should be set on a button press
and the controller should service the request after the Main Street yellow light by turning all street lights to red and the
walk light to on. After a walk of 3 seconds, the traffic lights should return to their usual routine by turning the Side Street
green. The Walk Register should be cleared at the end of a walk cycle.
### 2) 
The second deviation is the traffic sensor. If the traffic sensor is high at the end of the first 6 second length of the Main
street green, the light should remain green only for an additional 3 seconds, rather than the full 6 seconds. Additionally, if
the traffic sensor is high during the end of the Side Street green, it should remain green for an additional 3 seconds.
