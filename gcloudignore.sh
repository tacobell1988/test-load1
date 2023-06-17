#!/bin/bash

gcloudignore=".gcloudignore"
regex=""

while IFS= read -r line; do
  # Ignore comments and empty lines
  if [[ "$line" =~ ^[^#]*[^[:space:]]$ ]]; then
    # Escape the dot character and add ^ and $
    line="^$line$"
    line=${line//./\\.}
    regex+="|$line"
  fi
done < "$gcloudignore"

# Remove the leading '|' character
regex=${regex#|}

# Export the generated regular expression as an environment variable
export GSUTIL_IGNORE="$regex"


echo $GSUTIL_IGNORE
