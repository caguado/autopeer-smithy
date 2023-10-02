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

string Asn

string IpAddress

@pattern("^.+$")
@length(min: 3 max: 250)
string ResourceDescription

enum ResourceStatus {
    REQUESTED = "requested"
    PROVISIONED = "provisioned"
    DISABLED = "disabled"
}

@pattern("^[a-z0-9-.]+$")
@length(min: 3 max: 32)
string LocationId

@pattern("^[a-z0-9-.]+$")
@length(min:3 max: 32)
string SessionId

enum LocationType {
    PUBLIC = "public",
    PRIVATE = "private",
}

enum AuthenticationType {
    MD5 = "md5"
}
