#!/usr/bin/env bash
# fail if any commands fails
set -e
# debug log
set -x

PAYLOAD='{
    "@type": "MessageCard",
    "@context": "http://schema.org/extensions",
    "themeColor": "359914",
    "title": "New APKs. ready for deployment",
    "summary": "brandnewreactnative '$BITRISE_BUILD_NUMBER'",
    "sections": [
        {
            "activityTitle": "'$BITRISE_ART_VERSIONNAME_UAT'\u003cbr\u003e'$BITRISE_ART_VERSIONNAME_CTE'",
            "activitySubtitle": "",
            "activityImage": "https://concrete-userfiles-production.s3.us-west-2.amazonaws.com/repositories/3928786b7f122c73/avatar/avatar.png",
            "facts": null,
            "markdown": false,
            "text": "Last commit by corganfuzz\n\u003cbr/\u003e\n\u003cbr/\u003e\n\u003cb\u003eInstructions\u003c/b\u003e\u003cbr/\u003e\n1. Click on the buttons only if you are supposed to\u003cbr/\u003e\n2. That is all.\n\n",
            "heroImage": {
                "image": ""
            }
        },
        {
            "facts": [
                {
                    "name": "Build Status",
                    "value": "\u003cspan style=\"color:#359914\"\u003eSuccess\u003c/span\u003e"
                }
            ],
            "markdown": true,
        }
    ],
    "potentialAction": [
        {
            "@type": "OpenUri",
            "name": "See Progress",
            "targets": [
                {
                    "os": "default",
                    "uri": "https://app.bitrise.io/build/e2145f99096087b1"
                }
            ]
        },
        {
            "@type": "HttpPOST",
            "name": "DEPLOY TO UAT",
            "target": "https://app.bitrise.io/app/3928786b7f122c73/build/start.json",
            "headers": [
                {
                    "name": "Authorization",
                    "value": null
                }
            ],
            "body": "{
                \"hook_info\": {
                  \"type\": \"bitrise\",
                  \"build_trigger_token\": \"wNdFTVz4KfHDUalK8BLApQ\"
                },
                \"build_params\": {
                  \"branch\": \"master\",
                  \"workflow_id\": \"unit-test\",
                  \"environments\": [
                    {
                      \"mapped_to\": \"PACKAGE\",
                      \"value\": \"'$BITRISE_ART_VERSIONNAME_UAT'\",
                      \"is_expand\": true
                    }
                  ]
                },
                \"triggered_by\": \"curl\"
            }"
        },
        {
            "@type": "HttpPOST",
            "name": "DEPLOY TO CTE",
            "target": "https://app.bitrise.io/app/3928786b7f122c73/build/start.json",
            "headers": [
                {
                    "name": "Authorization",
                    "value": null.
                },
                {
                    "CARD-ACTION-STATUS": "Successfully completed task.",
                    "CARD-UPDATE-IN-BODY": "true",
                }
            ],
            status: 200,
            isRaw: true,
            "body": "{
                \"hook_info\": {
                  \"type\": \"bitrise\",
                  \"build_trigger_token\": \"wNdFTVz4KfHDUalK8BLApQ\"
                },
                \"build_params\": {
                  \"branch\": \"master\",
                  \"workflow_id\": \"unit-test\",
                  \"environments\": [
                    {
                      \"mapped_to\": \"PACKAGE\",
                      \"value\": \"'$BITRISE_ART_VERSIONNAME_CTE'\",
                      \"is_expand\": true
                    }
                  ]
                },
                \"triggered_by\": \"gerd\"
            }"
        }
    ]
}'

function curl_cmd() {
    curl -H 'Content-Type: application/json' -d "$PAYLOAD" "$hooker"
}

main() {
    curl_cmd
}

main "$@"
