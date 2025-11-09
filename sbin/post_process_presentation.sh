#!/bin/bash

# Define the path to the presentation HTML file
PRESENTATION_HTML="/home/kruse/Projects/vibe_coding_mcp_presentation/index.html"

# Perform replacements for Reveal.js CSS files
sed -i 's|https://unpkg.com/reveal.js@^4//dist/reset.css|reveal.js-4.6.1/dist/reset.css|g' "$PRESENTATION_HTML"
sed -i 's|https://unpkg.com/reveal.js@^4//dist/reveal.css|reveal.js-4.6.1/dist/reveal.css|g' "$PRESENTATION_HTML"
sed -i 's|https://unpkg.com/reveal.js@^4//dist/theme/black.css|reveal.js-4.6.1/dist/theme/black.css|g' "$PRESENTATION_HTML"

# Perform replacements for Reveal.js JS files
sed -i 's|https://unpkg.com/reveal.js@^4//dist/reveal.js|reveal.js-4.6.1/dist/reveal.js|g' "$PRESENTATION_HTML"
sed -i 's|https://unpkg.com/reveal.js@\^4//plugin/notes/notes.js|reveal.js-4.6.1/plugin/notes/notes.js|g' "$PRESENTATION_HTML"
sed -i 's|https://unpkg.com/reveal.js@\^4//plugin/search/search.js|reveal.js-4.6.1/plugin/search/search.js|g' "$PRESENTATION_HTML"
sed -i 's|https://unpkg.com/reveal.js@\^4//plugin/zoom/zoom.js|reveal.js-4.6.1/plugin/zoom/zoom.js|g' "$PRESENTATION_HTML"

# --- Start of script block movement logic ---

# Define a temporary file for the script block
SCRIPT_TEMP_FILE="/tmp/reveal_event_listener_script.tmp"

# Extract the script block from the head and save it to a temporary file
sed -n '/Reveal.addEventListener/,/\/script>/p' "$PRESENTATION_HTML" > "$SCRIPT_TEMP_FILE"

# Delete the script block from the head
sed -i '/Reveal.addEventListener/,/\/script>/d' "$PRESENTATION_HTML"

# Insert the script block from the temporary file after the zoom.js plugin script
sed -i "/reveal.js-4.6.1\/plugin\/zoom.js/a\$(cat $SCRIPT_TEMP_FILE)" "$PRESENTATION_HTML"

# Clean up the temporary file
rm "$SCRIPT_TEMP_FILE"

# --- End of script block movement logic ---