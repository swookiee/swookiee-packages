if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  echo -e "Starting to upload gh-pages\n"

  #copy rpms
  mkdir $HOME/uploads
  cp -R target/*.rpm $HOME/uploads

  #go to home and setup git
  cd $HOME
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis"

  #using token clone gh-pages branch
  git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/swookiee/packages.git  gh-pages > /dev/null

  #go into dir and copy data we're interested in to that directory
  cd gh-pages
  cp -Rf $HOME/uploads/* .
  ln -sf swookiee-1.0.0_SNAPSHOT-$TRAVIS_BUILD_NUMBER.noarch.rpm swookiee-1.0.0_SNAPSHOT-latest.noarch.rpm

  #add, commit and push files
  git add -f .
  git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to gh-pages"
  git push -fq origin gh-pages > /dev/null

  echo -e "Just uploaded latest build rpm artefacts\n"
fi
