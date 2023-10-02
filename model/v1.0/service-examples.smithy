// Copyright (c) Meta Platforms, Inc. and affiliates.
// Copyright (c) FullCtl and affiliates.
// Copyright (c) Cloudflare and affiliates.
// Copyright (c) Amazon.com Inc. or its affiliates.
// Copyright (c) Google and affiliates.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

$version: "2"

namespace bgp.autopeer.v10

apply ListLocations @examples([
    {
        title: "Lists locations - happy path first page"
        documentation: "Retrieves the first page of a list of locations"
        input: {
            maxResults: 1
        }
        output: {
            locations: [
                {
                    locationIdentifier: "id-123"
                    locationType: "public"
                }
            ],
            nextToken: "b2f8388d59e54b788f42c9cc20f091c4"
        }
    }
    {
        title: "Lists locations - happy path second and last page"
        documentation: "Retrieves the second and last page of a list of locations"
        input: {
            maxResults: 1
            nextToken: "b2f8388d59e54b788f42c9cc20f091c4"
        }
        output: {
            locations: [
                {
                    locationIdentifier: "id-456"
                    locationType: "public"
                }
            ]
        }
    }
])

apply GetLocation @examples([
    {
        title: "Get a single location - happy path"
        documentation: "Retrieves all the properties of a location by its location ID"
        input: {
            locationIdentifier: "id-123"
        }
        output: {
            location: {
                locationIdentifier: "id-456"
                locationType: "public"
                description: "This is the public location 456"
            }
        }
    }
])

apply CreateSessions @examples([
    {
        title: "Create multiple sessions - happy path"
        documentation: "Creates a request for multiple sessions across different locations"
        input: {
            sessions: [
                {
                    itemToken: "f7995efa-1dd8-4184-b0a9-436cb992f0f1"
                    initiatorAsn: "2345"
                    initiatorIpAddress: "192.168.100.108"
                    targetAsn: "5678"
                    targetIpAddress: "192.168.100.110"
                    locationIdentifier: "id-123"
                }
                {
                    itemToken: "c4a9d24b-12d7-402a-8e25-423d5cfe231a"
                    initiatorAsn: "2345"
                    initiatorIpAddress: "192.168.100.109"
                    targetAsn: "5678"
                    targetIpAddress: "192.168.100.111"
                    locationIdentifier: "id-123"
                }
                {
                    itemToken: "7acf7916-c2c7-4ce3-8129-c00e297e7d10"
                    initiatorAsn: "2345"
                    initiatorIpAddress: "172.16.100.108"
                    targetAsn: "5678"
                    targetIpAddress: "172.16.100.110"
                    locationIdentifier: "id-456"
                    authentication: {
                        type: "md5"
                        payload: "some-secret-string"
                    }
                }
            ]
            clientToken: "31d25906-4e64-4ddb-8110-bfb7e32a3467"
        }
        output: {
            sessions: [
                {
                    itemToken: "f7995efa-1dd8-4184-b0a9-436cb992f0f1"
                    sessionIdentifier: "session-id-123"
                }
                {
                    itemToken: "c4a9d24b-12d7-402a-8e25-423d5cfe231a"
                    sessionIdentifier: "session-id-456"
                }
            ]
            errors: [
                {
                    itemToken: "7acf7916-c2c7-4ce3-8129-c00e297e7d10"
                    error: "Session already exists for the given initiator"
                }
            ]
        }
    }
])

apply ListSessions @examples([
    {
        title: "Lists sessions - happy path"
        documentation: "Retrieves a paginated list of sessions"
        input: {
            maxResults: 10
        }
        output: {
            sessions: [
                {
                    sessionIdentifier: "session-id-123"
                    initiatorAsn: "2345"
                    initiatorIpAddress: "192.168.100.108"
                    locationIdentifier: "id-123"
                }
                {
                    sessionIdentifier: "session-id-456"
                    initiatorAsn: "2345"
                    initiatorIpAddress: "192.168.100.109"
                    locationIdentifier: "id-123"
                }
                {
                    sessionIdentifier: "session-id-789"
                    initiatorAsn: "2345"
                    initiatorIpAddress: "172.16.100.108"
                    locationIdentifier: "id-456"
                }
            ]
        }
    }
])

apply GetSession @examples([
    {
        title: "Get a single session - happy path"
        documentation: "Retrieves all the properties for a given session"
        input: {
            sessionIdentifier: "session-id-123"
        }
        output: {
            session: {
                sessionIdentifier: "session-id-123"
                initiatorAsn: "2345"
                initiatorIpAddress: "192.168.100.108"
                targetAsn: "5678"
                targetIpAddress: "192.168.100.110"
                locationIdentifier: "id-123"
                authentication: {
                    type: "md5"
                    payload: "REDACTED"
                }
                status: "provisioned"
            }
        }
    }
])
