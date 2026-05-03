#!/bin/bash

# Script to validate the CI/CD pipeline against documented steps

# Step 1: Log into CI/CD environment (assuming GitHub Actions)
echo "Logging into CI/CD environment..."
# No actual login command as we're simulating the process

# Step 2: Retrieve the documented pipeline steps from documentation
echo "Retrieving documented pipeline steps..."
documented_steps=$(cat .github/docs/pipeline_documentation.md | grep '^## Step' | cut -d' ' -f3-)

# Step 3: Get the actual pipeline steps from the CI/CD configuration
echo "Getting actual pipeline steps..."
actual_steps=$(cat .github/workflows/main.yml | grep '^  - name:' | cut -d':' -f2-)

# Step 4: Compare the documented steps with the actual steps
echo "Comparing documented and actual pipeline steps..."
diff <(echo "$documented_steps") <(echo "$actual_steps")

# Check if there are any differences
if [ $? -eq 0 ]; then
  echo "Pipeline validation successful: Documented and actual steps match."
else
  echo "Pipeline validation failed: Documented and actual steps do not match."
  exit 1
fi
