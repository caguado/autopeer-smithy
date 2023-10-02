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

$operationInputSuffix: "Request"
$operationOutputSuffix: "Response"

namespace bgp.autopeer.v10

use aws.api#controlPlane
use aws.protocols#restJson1

use bpg.autopeer.common#BadRequestException
use bpg.autopeer.common#ForbiddenException
use bpg.autopeer.common#ResourceNotFoundException
use bpg.autopeer.common#ConflictException
use bpg.autopeer.common#ThrottlingException

@restJson1
service AutoPeer {
    version: "1.0"

    resources: [
        Location
        Session
    ]
}

resource Location {
    identifiers: {
        locationIdentifier: LocationId
    }

    properties: {
        locationType: LocationType
        description: ResourceDescription
    }

    list: ListLocations
    read: GetLocation
}

resource Session {
    identifiers: {
        sessionIdentifier: SessionId
    }

    properties: {
        initiatorAsn: Asn
        initiatorIpAddress: IpAddress
        targetAsn: Asn
        targetIpAddress: IpAddress
        locationIdentifier: LocationId
        authentication: SessionAuthentication
        status: ResourceStatus
    }

    list: ListSessions
    read: GetSession

    collectionOperations: [
        CreateSessions
    ]
}

@http(method: "GET", uri: "/locations")
@controlPlane
@readonly
@paginated(
    inputToken: "nextToken"
    outputToken: "nextToken"
    pageSize: "maxResults"
    items: "locations"
)
operation ListLocations {
    input := with [ListLocationsInputMixin] {}
    output := with [ListLocationsOutputMixin] {}
    errors: [
        BadRequestException
        ForbiddenException
        ThrottlingException
    ]
}

@http(method: "GET", uri: "/locations/{locationIdentifier}")
@controlPlane
@readonly
operation GetLocation {
    input := with [GetLocationInputMixin] {}
    output := with [GetLocationOutputMixin] {
        @nestedProperties
        $location
    }
    errors: [
        BadRequestException
        ForbiddenException
        ResourceNotFoundException
        ThrottlingException
    ]
}

@http(method: "POST", uri: "/sessions")
@controlPlane
@idempotent
operation CreateSessions {
    input := with [CreateSessionsInputMixin] {}
    output := with [CreateSessionsOutputMixin] {}
    errors: [
        BadRequestException
        ForbiddenException
        ConflictException
        ThrottlingException
    ]
}

@http(method: "GET", uri: "/sessions")
@controlPlane
@readonly
@paginated(
    inputToken: "nextToken"
    outputToken: "nextToken"
    pageSize: "maxResults"
    items: "sessions"
)
operation ListSessions {
    input := with [ListSessionsInputMixin] {}
    output := with [ListSessionsOutputMixin] {}
    errors: [
        BadRequestException
        ForbiddenException
        ThrottlingException
    ]
}

@http(method: "GET", uri: "/sessions/{sessionIdentifier}")
@controlPlane
@readonly
operation GetSession {
    input := with [GetSessionInputMixin] {}
    output := with [GetSessionOutputMixin] {
        @nestedProperties
        $session
    }
    errors: [
        BadRequestException
        ForbiddenException
        ResourceNotFoundException
        ThrottlingException
    ]
}
