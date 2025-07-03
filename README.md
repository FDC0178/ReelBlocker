# ReelBlocker

ReelBlocker is a simple Android application that runs a background service to detect when the Instagram Reels section is opened and immediately sends the Instagram app to the background, effectively blocking access to Reels.

## How it works

The app uses an Accessibility Service to monitor the UI of the Instagram app. When it detects that the Reels tab has been opened, it simulates a "Home" button press, which backgrounds the current app (Instagram).

## How to use

1.  Build and install the app on your Android device.
2.  Open the "ReelBlocker" app.
3.  Click the "Open Accessibility Settings" button.
4.  In the Accessibility settings, find "ReelBlocker" in the list of downloaded apps or services.
5.  Tap on it and enable the service. You will be prompted with a warning about the permissions you are granting; this is standard for accessibility services.
6.  That's it! Now, whenever you open the Reels section in Instagram, the app will be sent to the background.
 
--  or just download the app from this link https://github.com/FDC0178/ReelBlocker/actions/runs/16038715223/artifacts/3454193776
## Disclaimer

This app's functionality depends on the UI structure of the Instagram app. If Instagram updates its app and changes the layout or identifiers for the Reels section, this app may stop working until it is updated to match the new structure.
