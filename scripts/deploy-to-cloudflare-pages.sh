#!/bin/bash
flutter build web
wrangler pages deploy build/web --project-name=passdriver
