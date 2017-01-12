#!/bin/bash -e

# source : https://gist.github.com/ashb/c59152abc941bd3658da
# used : chmox +x unused-ami.sh; ./unused-ami.sh > ami-id


set -o pipefail
# File 1 is the list of our AMIs
# File 2 is the list of AMIs used by our instances
# Column 1 is an image of ours that is not in use
# Column 2 is an AMI that is in use that isn't one of ours
# Column 3 is the list of our AMIs that are in use.

comm -23 \
  <(aws ec2 describe-images --owners self | jq -r ' [.Images[].ImageId] | sort | unique | .[]') \
  <(aws ec2 describe-instances | jq -r '[.Reservations[].Instances[].ImageId] | sort | unique |  .[]')

