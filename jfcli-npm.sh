clear
# TOKEN SETUP
# jf c add --user=krishnam --interactive=true --url=https://psazuse.jfrog.io --overwrite=true 

# Setting variables
export JF_RT_URL="https://psazuse.jfrog.io" JFROG_NAME="psazuse" RT_REPO_VIRTUAL="krishnam-npm-virtual"  JFROG_CLI_LOG_LEVEL="DEBUG" # JF_ACCESS_TOKEN="<GET_YOUR_OWN_KEY>"
export  BUILD_NAME="example-react" BUILD_ID="cmd.$(date '+%Y-%m-%d-%H-%M')" 
echo " JFROG_NAME: $JFROG_NAME \n JF_RT_URL: $JF_RT_URL \n BUILD_NAME: $BUILD_NAME \n BUILD_ID: $BUILD_ID \n JFROG_CLI_LOG_LEVEL: $JFROG_CLI_LOG_LEVEL  \n"

# clean
echo "\n\n**** Cleaning files ****\n\n"
rm -rf package-lock.json
rm -rf .jfrog
rm -rf temp

# Config - Artifactory info
echo "\n\n**** NPM: Config ****\n\n"
jf npmc --global --repo-resolve ${RT_REPO_VIRTUAL} --repo-deploy ${RT_REPO_VIRTUAL}


echo "\n\n**** NPM: Package ****\n\n"
# npm: install
jf npm install --build-name=${BUILD_NAME} --build-number=${BUILD_ID} 
# npm:publish
jf npm publish --build-name=${BUILD_NAME} --build-number=${BUILD_ID}


echo "\n\n**** Build Info ****\n\n"
# setting build properties
export e_env="e_demo" e_org="e_ps" e_team="e_arch" # Thest properties were captured in Builds >> example-react >> version >> Environment tab
# build: bce:build-collect-env 
jf rt bce ${BUILD_NAME} ${BUILD_ID}
## build: bag:build-add-git
jf rt bag ${BUILD_NAME} ${BUILD_ID}
# Build:publish
jf rt bp ${BUILD_NAME} ${BUILD_ID} --detailed-summary=true


# set-props
echo "\n\n**** Props: set ****\n\n"  # Thest properties were captured Artifacts >> repo path >> artifact >> 
jf rt sp "env=demo;org=ps;team=arch;pack_cat=webapp;ts=ts-${BUILD_ID}" --build="${BUILD_NAME}/${BUILD_ID}"

sleep 10
# Query props
echo "\n\n**** Quering package properties by team ****\n\n"
jf rt curl "/api/search/prop?repos=${RT_REPO_VIRTUAL}&team=arch&env=demo"

echo "\n\n**** Quering package properties by prop build.name ****\n\n"
jf rt curl "/api/search/prop?repos=${RT_REPO_VIRTUAL}&build.name=${BUILD_NAME}"


echo "\n\n**** DONE ****\n\n"