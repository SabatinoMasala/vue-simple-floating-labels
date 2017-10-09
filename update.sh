yarn release
yarn build
yarn publish
git push origin master
git push origin `git subtree split --prefix example master`:gh-pages --force