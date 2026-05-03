#!/bin/bash

flutter pub run flutter_devtools --profile --trace-rebuilds --rebuild-counts > rebuild_performance.log
