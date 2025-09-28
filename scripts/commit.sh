#!/usr/bin/env bash

DIFF="$(git diff --staged)"

if [ -z "$DIFF" ]; then
    echo "No staged changes to commit."
    exit 1
fi

CONVENTION="$(cat .repo/msg.txt)"

PROMPT=$(cat <<EOF
You are an expert programmer who writes concise commit messages.
Your task is to generate a commit message for the following staged changes.

Follow **exactly** the custom commit convention provided below.

== SKELETON ==
<type>: <short description>
<blank line>
<longer description explaining what changed and why,
wrapped at roughly 72 characters per line>
== END SKELETON ==

== PROJECT COMMIT CONVENTION ==
${CONVENTION}
== END PROJECT COMMIT CONVENTION ==

== STAGED CHANGES (git diff) ==
${DIFF}
== END STAGED CHANGES ==

Generate ONLY the commit message text that follows the skeleton and the project convention.
Break into multiple lines of around 50 characters each.
Do not add explanations, markdown, or extra commentary.
EOF
)

echo "$PROMPT" | rave ""
