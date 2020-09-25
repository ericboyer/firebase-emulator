# firebase-emulator

A quick and dirty container that's intended to be used for testing mobile
applications that use Firebase. It offers an alternative approach to unit and
integration testing and is easily integrated in your CI workflows. This
container currently supports the UI and Firestore emulators.

To build with Docker, run:

  ```
  docker build . -t firestore-emulator -f Containerfile
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
if running on OpenShift.

To deploy to OpenShift:

  ```
  oc new-app --name firebase-emulator \
    --strategy docker \
    --env-file=firebase.env \
    https://github.com/ericboyer/firebase-emulator
  oc expose svc/firebase-emulator
  ```
