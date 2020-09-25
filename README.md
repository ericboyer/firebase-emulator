# firebase-emulator

A quick and dirty container that's intended to be used for testing mobile
applications that use Firebase. It offers an alternative approach to unit and
integration testing and is easily integrated in your CI workflows. This
container currently supports the UI and Firestore emulators.

**Prereqs**
- Get your Firebase project ID from https://console.firebase.google.com/ and set FIREBASE_PROJECT
- Get an auth token with `firebase login:ci` and set FIREBASE_TOKEN

To build with Docker, run:

  ```
  docker build . -t firestore-emulator -f Dockerfile
  ```

...and to run:

  ```
  docker run -it -e PROJECT=$FIREBASE_PROJECT \
    -e TOKEN=$FIREBASE_TOKEN \
    -p 8080:8080 \
    -p 8088:8088 \
    --rm firestore-emulator:latest
  ```

> Note: Currently this container runs as root, which is definitely frowned upon
if running on OpenShift...actually, it won't run until this issue is resolved.

To deploy to OpenShift:

  ```
  oc create secret generic firebase-emulator \
    --from-literal=PROJECT=$FIREBASE_PROJECT \
    --from-literal=TOKEN=$FIREBASE_TOKEN
  oc new-app --name firebase-emulator \
    --strategy docker \
    --env-file=firebase.env \
    https://github.com/ericboyer/firebase-emulator
  oc expose svc/firebase-emulator --port=8080 --name firestore
  oc expose svc/firebase-emulator --port=8088 --name firebase-ui
  ```
