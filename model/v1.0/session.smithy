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
use bpg.autopeer.common#ErrorMessage

@references([{resource: Location}])
structure SessionDetails for Session {
    @required
    @resourceIdentifier("sessionIndentifier")
    $sessionIdentifier

    @required
    $initiatorAsn

    @required
    $initiatorIpAddress

    @required
    $targetAsn

    @required
    $targetIpAddress

    @required
    $locationIdentifier

    $authentication

    @required
    $status
}

@references([{resource: Location}])
structure SessionSummary for Session {
    @required
    @resourceIdentifier("sessionIndentifier")
    $sessionIdentifier

    @required
    $initiatorAsn

    @required
    $initiatorIpAddress

    @required
    $locationIdentifier
}

list SessionSummaryList {
    member: SessionSummary
}

structure SessionAuthentication {
    @required
    type: AuthenticationType
    payload: SecretString
}

structure CreateSessionInputItem {
    @required
    itemToken: Uuid

    @required
    initiatorAsn: Asn

    @required
    initiatorIpAddress: IpAddress

    @required
    targetAsn: Asn

    @required
    targetIpAddress: IpAddress

    @required
    locationIdentifier: LocationId
    authentication: SessionAuthentication
}

list CreateSessionInputList {
    member: CreateSessionInputItem
}

structure CreateSessionOutputItem {
    @required
    itemToken: Uuid

    @required
    sessionIdentifier: SessionId
}

list CreateSessionOutputList {
    member: CreateSessionOutputItem
}

structure CreateSessionErrorItem {
    @required
    itemToken: Uuid

    @required
    error: ErrorMessage
}

list CreateSessionErrorList {
    member: CreateSessionErrorItem
}

@mixin
structure CreateSessionsInputMixin {
    sessions: CreateSessionInputList

    @idempotencyToken
    clientToken: IdempotencyToken
}

@mixin
structure CreateSessionsOutputMixin {
    sessions: CreateSessionOutputList
    errors: CreateSessionErrorList
}

@mixin
structure ListSessionsInputMixin with [PaginatedInputMixin] {
    // Add filtering criteria
}

@mixin
structure ListSessionsOutputMixin with [PaginatedOutputMixin] {
    @required
    sessions: SessionSummaryList
}

@mixin
structure GetSessionInputMixin {
    @required
    @httpLabel
    sessionIdentifier: SessionId
}

@mixin
structure GetSessionOutputMixin {
    @required
    session: SessionDetails
}
