#!/usr/bin/env bash

DIFF="$(git diff --staged)"

if [ -z "$DIFF" ]; then
    echo "No staged changes to commit."
    exit 1
fi

CONVENTION="$(cat .repo/msg.txt)"

PROMPT=$(cat <<EOF
You are an expert programmer who writes concise and conventional commit messages.
Your task is to generate a commit message for the following staged changes.

-- The commit message MUST follow this skeleton --
<type>: <description>
<blank line>
<longer description explaining what changed and why>
-- end skeleton --

-- convention (Here are the allowed types and their meanings) --
${CONVENTION}
-- end convention --

-- git diff (Here are the staged changes) --
${DIFF}
-- end git diff --
EOF
)

echo "$PROMPT" | rave ""

