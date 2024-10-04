clear
# TOKEN SETUP
# jf c add --user=krishnam --interactive=true --url=https://psazuse.jfrog.io --overwrite=true 

# Setting variables
export JF_RT_URL="https://psazuse.jfrog.io" JFROG_NAME="psazuse" JFROG_CLI_LOG_LEVEL="DEBUG" RT_REPO_NPM_VIRTUAL="krishnam-npm-virtual" RT_REPO_DOCKER_VIRTUAL="krishnam-docker-virtual" # JF_ACCESS_TOKEN="<GET_YOUR_OWN_KEY>"
export  BUILD_NAME="example-react-oci" BUILD_ID="cmd.$(date '+%Y-%m-%d-%H-%M')" 
echo " JFROG_NAME: $JFROG_NAME \n JF_RT_URL: $JF_RT_URL \n BUILD_NAME: $BUILD_NAME \n BUILD_ID: $BUILD_ID \n JFROG_CLI_LOG_LEVEL: $JFROG_CLI_LOG_LEVEL  \n"

# clean
PRUNE_FILTER="until=1h"
echo "\n\n**** Cleaning files ****\n\n"
rm -rf package-lock.json
rm -rf .jfrog
rm -rf temp
docker image prune --all --force --filter ${PRUNE_FILTER}
docker system prune --all --force --filter ${PRUNE_FILTER}


# Config - Artifactory info
echo "\n\n**** NPM: Config ****\n\n"
jf npmc --repo-resolve ${RT_REPO_NPM_VIRTUAL} --repo-deploy ${RT_REPO_NPM_VIRTUAL}
npm config set cache temp & chmod -R 755 *

echo "\n\n**** NPM: Package ****\n\n"
# npm: Build
jf npm install --build-name=${BUILD_NAME} --build-number=${BUILD_ID}
# npm:publish
jf npm publish --build-name=${BUILD_NAME} --build-number=${BUILD_ID}

# Docker
### config
# export DOCKER_PWD="<GET_YOUR_OWN_KEY>" 
echo "\n DOCKER_PWD: $DOCKER_PWD \n "
docker login psazuse.jfrog.io -u krishnam -p ${DOCKER_PWD}

### Create image and push
echo "\n\n**** Docker: build image ****"
docker image build -f Dockerfile --platform linux/amd64,linux/arm64 -t psazuse.jfrog.io/${RT_REPO_DOCKER_VIRTUAL}/${BUILD_NAME}:${BUILD_ID} --output=type=image .

docker inspect psazuse.jfrog.io/${RT_REPO_DOCKER_VIRTUAL}/${BUILD_NAME}:${BUILD_ID} --format='{{.Id}}'
#### Tag with latest also
# docker tag psazuse.jfrog.io/krishnam-docker-virtual/${BUILD_NAME}:${BUILD_ID} psazuse.jfrog.io/krishnam-docker-virtual/${BUILD_NAME}:latest 

### Docker Push image
echo "\n\n**** Docker: jf push ****"
jf docker push psazuse.jfrog.io/${RT_REPO_DOCKER_VIRTUAL}/${BUILD_NAME}:${BUILD_ID} --build-name=${BUILD_NAME} --build-number=${BUILD_ID} --detailed-summary=true


## bdc: build-docker-create, Adding Published Docker Images to the Build-Info 
echo "\n\n**** Docker: build create ****"
export DKR_MANIFEST="list-manifest-${BUILD_ID}.json" SPEC_BP_DOCKER="dockerimage-file-details-${BUILD_ID}" 
jf rt curl -XGET "/api/storage/${RT_REPO_DOCKER_VIRTUAL}/${BUILD_NAME}:${BUILD_ID}/list.manifest.json" # -H "Authorization: Bearer ${JF_ACCESS_TOKEN}"

export imageSha256=$(jf rt curl -XGET "/api/storage/${RT_REPO_DOCKER_VIRTUAL}/${BUILD_NAME}:${BUILD_ID}/list.manifest.json" | jq -r '.originalChecksums.sha256')
jf rt curl -XGET "/api/storage/${RT_REPO_DOCKER_VIRTUAL}/${BUILD_NAME}/${BUILD_ID}/list.manifest.json" # -H "Authorization: Bearer ${JF_ACCESS_TOKEN}" -o "${DKR_MANIFEST}"
imageSha256=`cat ${DKR_MANIFEST} | jq -r '.originalChecksums.sha256'`

echo "imageSha256::  ${imageSha256}"
echo ${JF_RT_HOST}/${RT_REPO_DOCKER_VIRTUAL}/${BUILD_NAME}:${BUILD_ID}@sha256:${imageSha256} > ${SPEC_BP_DOCKER}
jf rt bdc ${RT_REPO_DOCKER_VIRTUAL} --image-file ${SPEC_BP_DOCKER} --build-name ${BUILD_NAME} --build-number ${BUILD_ID} 


echo "\n\n**** Build Info ****\n\n"
# build: bce:build-collect-env 
jf rt bce ${BUILD_NAME} ${BUILD_ID}
## build: bag:build-add-git
jf rt bag ${BUILD_NAME} ${BUILD_ID}
# Build:publish
jf rt bp ${BUILD_NAME} ${BUILD_ID} --detailed-summary=true


# clean
echo "\n\n**** CLEAN UP ****\n\n"
rm -rf ${DKR_MANIFEST}
rm -rf ${SPEC_BP_DOCKER}
echo "\n\n**** DONE ****\n\n"