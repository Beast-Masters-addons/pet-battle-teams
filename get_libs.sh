#!/usr/bin/env bash
curl -s https://raw.githubusercontent.com/BigWigsMods/packager/master/release.sh | bash -s -- -g retail -c -d -z
mv -f .release/PetBattleTeams/libs/* PetBattleTeams
