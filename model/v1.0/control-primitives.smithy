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

@length(min: 3 max: 64)
string IdempotencyToken

@length(min: 3 max: 64)
string Uuid

@sensitive
string SecretString

@range(min: 0 max: 100)
integer MaxResults

string PaginationToken

@mixin
structure PaginatedInputMixin {
    @httpQuery("maxResults")
    maxResults: MaxResults = 0

    @httpQuery("nextToken")
    nextToken: PaginationToken
}

@mixin
structure PaginatedOutputMixin {
    nextToken: PaginationToken
}
