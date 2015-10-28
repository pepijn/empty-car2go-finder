Car2go empty car finder
=======================

This is a native iOS version of a [website built in 2013](http://plict.nl/car2go/).

The pins on the map represent available Car2go vehicles. The colors indicate whether you will get free minutes when you attach the car to a charging station after driving.

- Green: charge is <30%, you will get the reward
- Yellow: charge is a little more than 30%, you will get the reward if you lose enough battery charge while driving
- Blue: there is a small chance of getting the reward while driving an average distance

More info: https://www.car2go.com/en/amsterdam/how-does-car2go-work/

## Constraints

For this first assignment, we’ll leave things very open-ended. You can make any app you want and submit it to receive credit. We’d prefer to see an app that has the following qualities:

- [x] Your app should be set up as an Android Studio or Xcode project, so it can easily be opened/run/graded by others.
- [x] Your app should use at least 4 widgets/views on the screen. For example: three Buttons and a TextView.

A lot of `MKAnnotationView`s.

- [x] Your app should use at least 2 different kinds of widgets. For example: Button, TextView, EditText, … .

`MKMapView` and `MKAnnotationView`.

- [x] Your app should respond to at least two different events. For example: clicks on two different buttons.

It responds to clicks on all the `MKAnnotationView`s by showing the callout.

- [x] Your app’s design should change at least some aspect of the physical appearance and styling of some widgets. For example, make a text view have a larger or bold font, or make a button appear in a blue color.

Depending on the vehicle charge, the `alpha` and `pinTintColor` of the `MKAnnotationView` change.

- [x] We haven’t talked very much about layout yet, so your app can have essentially any layout you want, so long as the various widgets are visible and can be interacted with.
- [x] Along with your app, please turn in a file named README.md that contains your name and e-mail address along with the name of your app and a very brief description of it, along with any special instructions that the user might need to know in order to use it properly (if there are any).
