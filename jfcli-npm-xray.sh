clear
# TOKEN SETUP
# jf c add --user=krishnam --interactive=true --url=https://psazuse.jfrog.io --overwrite=true 

# clean
rm -rf package-lock.json && rm -rf .jfrog && rm -rf temp

# Setting variables
export JF_RT_URL="https://psazuse.jfrog.io" JFROG_NAME="psazuse" RT_REPO_VIRTUAL="krishnam-npm-virtual"  JFROG_CLI_LOG_LEVEL="DEBUG" # JF_ACCESS_TOKEN="<GET_YOUR_OWN_KEY>"
export  BUILD_NAME="example-react-xray" BUILD_ID="cmd.$(date '+%Y-%m-%d-%H-%M')" 
echo " JFROG_NAME: $JFROG_NAME \n JF_RT_URL: $JF_RT_URL \n BUILD_NAME: $BUILD_NAME \n BUILD_ID: $BUILD_ID \n JFROG_CLI_LOG_LEVEL: $JFROG_CLI_LOG_LEVEL  \n"


# Config - Artifactory info
jf npmc --global --repo-resolve ${RT_REPO_VIRTUAL} --repo-deploy ${RT_REPO_VIRTUAL}

## [Xray] Audit
echo "\n\n**** MVN: Audit ****"
jf audit --npm --extended-table=true

## Create Build
echo "\n\n**** NPM: Package ****\n\n"
# npm: install
jf npm install --build-name=${BUILD_NAME} --build-number=${BUILD_ID} 
# npm:publish
jf npm publish --build-name=${BUILD_NAME} --build-number=${BUILD_ID}

# ## [Xray] scan packages
# echo "\n\n**** JF: scan ****"
# jf scan . --extended-table=true --format=simple-json 


# echo "\n\n**** Build Info ****\n\n"
# # build: bce:build-collect-env 
# jf rt bce ${BUILD_NAME} ${BUILD_ID}
# ## build: bag:build-add-git
# jf rt bag ${BUILD_NAME} ${BUILD_ID}
# # Build:publish
# jf rt bp ${BUILD_NAME} ${BUILD_ID} --detailed-summary=true

# ## [Xray]  bs:build-scan
# echo "\n\n**** Xray: Build Scan ****\n\n"
# jf bs ${BUILD_NAME} ${BUILD_ID} --rescan=true --format=table --extended-table=true --vuln=true --fail=false 


## XRAY sbom enrich    ref# https://docs.jfrog-applications.jfrog.io/jfrog-applications/jfrog-cli/cli-for-jfrog-security/enrich-your-sbom    
echo "\n\n**** [XRAY] sbom enrich ****"
find . -iname "*.cdx.json"  
# jf se "build/resources/main/META-INF/sbom/application.cdx.json"





# clean
rm -rf package-lock.json && rm -rf .jfrog && rm -rf temp


echo "\n\n**** DONE ****\n\n"