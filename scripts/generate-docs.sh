#! /bin/sh
#
# Copyright (c) 2021. AppDynamics LLC and its affiliates.
# All rights reserved.
#
#

## Not working on CI/CD, needs newer macOS than Mojave.

set -e
set -x

export PATH="$PATH":"$HOME/.pub-cache/bin"

# expecting flutter executable to be downloaded via flutter-download.sh script
flutter/bin/flutter pub global activate dartdoc
# Running `dartdoc` alone was throwing error and no other solution worked.
# https://stackoverflow.com/questions/61086384/dartdoc-failed-top-level-package-requires-flutter-but-flutter-root-environment
flutter/bin/flutter pub global run dartdoc:dartdoc

# Current TC artifact path is hardcoded to build/app/reports so we move things there.
ARTIFACTS_FOLDER=example/build/app/reports
echo "To view docs, run the \`view-docs.sh\` script. Troubleshooting: https://dart.dev/get-dart" \
> README
zip -j doc.zip scripts/view-docs.sh README
zip -ur doc.zip doc
cp doc.zip $ARTIFACTS_FOLDER
rm doc.zip README