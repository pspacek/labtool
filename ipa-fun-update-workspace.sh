#!/bin/bash

##############################################################################
# Author: Tomas Babej <tbabej@redhat.com>
#
# Creates workspace for the IPA developement and all the other
#
# Usage: $0
# Returns: 0 on success, 1 on failure
##############################################################################

# Load the configuration
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/config.sh

# Download the updates for both the FreeIPA and LabTool
pushd $IPA_DIR
git am --abort
git rebase --abort
git reset --hard origin/master
git pull
popd

pushd ~/labtool
git pull
popd

# Install build and package dependencies
$DIR/ipa-fun-install-build-dependencies.sh
$DIR/ipa-fun-install-package-dependencies.sh

sudo $DNF update -y

