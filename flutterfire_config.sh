#!/bin/sh

flutterfire config --project naggingnelly-dev --out=lib/firebase_options_development.dart --ios-bundle-id=io.freedman.naggingnelly.dev --android-package-name=io.freedman.naggingnelly.dev
flutterfire config --project naggingnelly-staging --out=lib/firebase_options_staging.dart --ios-bundle-id=io.freedman.naggingnelly.staging --android-package-name=io.freedman.naggingnelly.staging
flutterfire config --project naggingnelly-prod --out=lib/firebase_options_production.dart --ios-bundle-id=io.freedman.naggingnelly.prod --android-package-name=io.freedman.naggingnelly.prod
