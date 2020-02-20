#
# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package templates.gcp.GCPStorageBucketWorldReadableConstraintV1

deny[{
	"msg": message,
	"details": metadata,
}] {
	constraint := input.constraint
	asset := input.asset
	asset.asset_type == "storage.googleapis.com/Bucket"

	check_for := ["allUsers", "allAuthenticatedUsers"]
    found := {
	  m |
	  asset.iam_policy.bindings[i].members[j] == check_for[k];
	  m = check_for[k]
	}

	count(found) != 0
	message := sprintf("%v is publicly accessable", [asset.name])
	metadata := {"resource": asset.name}
}
