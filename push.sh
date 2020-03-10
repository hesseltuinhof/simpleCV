#!/bin/bash

if [[ "$TRAVIS_BRANCH" != "master" ]]
then
    echo "not master branch. skipping update of assets"
    exit 0
fi

convert -density 600 test.pdf -quality 90 test.png

# TODO: change env variabels encrypted_*
openssl aes-256-cbc -K $encrypted_e6cc0fb2b8da_key -iv $encrypted_e6cc0fb2b8da_iv -in .push-token.enc -out push-token -d
chmod 600 push-token
eval $(ssh-agent -s)
ssh-add push-token
rm push-token

git remote add origin-token git@github.com:hesseltuinhof/simpleCV.git

if [[ $(git ls-remote origin assets | wc -l) == "1" ]]
then
    git push origin-token :assets
fi

git checkout --orphan assets
git rm -rf fonts/ && git rm -f *.tex *.sty *.cls .push-token.enc
git add cv.png cv.pdf cover.png cover.pdf
git config user.email "travis@travis-ci.org"
git config user.name "travis ci"
git commit -m "travis auto upload $TRAVIS_BUILD_NUMBER"
git push -u origin-token assets > /dev/null 2>&1
