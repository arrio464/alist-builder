#! /bin/bash
echo "Patching frontend..."

for file in assets/*.js; do
  matches_before=($(grep -o '.\{0,20\}defaults.headers.common.Authorization.\{0,20\}' "$file"))
  sed -i 's/defaults.headers.common.Authorization/defaults.headers.common["X-Token"]/g' "$file"
  matches_after=($(grep -o '.\{0,20\}defaults.headers.common\["X-Token"\].\{0,20\}' "$file"))

  if [ ${#matches_before[@]} -gt 0 ]; then
    echo "Modified: $file"
    for i in "${!matches_before[@]}"; do
      echo "Before: ...${matches_before[i]}..."
      echo "After:  ...${matches_after[i]}..."
    done
  fi
done

echo "Patching complete."
