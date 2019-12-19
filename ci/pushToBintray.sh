#!/bin/bash

API=https://api.bintray.com

# BINTRAY_USER=$1
# BINTRAY_API_KEY=$2
# BINTRAY_REPO=$3
# BINTRAY_PACKAGE=$4
# BOTTLE_VERSION
# BINTRAY_SUBJECT -- owner of the repo
BOTTLE="${BOTTLE_LOCAL_FILENAME}"

echostatus() {
  echo "$@" 1>&2;
}

main() {
  CURL="curl -u${BINTRAY_USER}:${BINTRAY_API_KEY} -H Content-Type:application/json -H Accept:application/json"
  if [ ! $(check_package_exists) ]; then
    echostatus "The package ${BINTRAY_PACKAGE} does not exit. It will be created"
    if [ ! $(create_package) ]; then
      echostatus "The package could not be created"
      exit 1
    fi
  fi

  if [ ! $(deploy_bottle) ]; then
    echostatus "Error deploying the bottle"
    exit 2
  fi
}

check_package_exists() {
  echostatus "Checking if package ${BINTRAY_PACKAGE} exists..."
  output=$(${CURL} --write-out %{http_code} --silent --output /dev/null -X GET ${API}/packages/${BINTRAY_SUBJECT}/${BINTRAY_REPO}/${BINTRAY_PACKAGE})
  echostatus "Package check returned status $output"
  if [ $output -eq 200 ]; then
    echo 1
  fi
}

create_package() {
  echostatus "Creating package ${BINTRAY_PACKAGE}..."
  if [ -f "${BINTRAY_DESCRIPTOR_FILENAME}" ]; then
    data="@${BINTRAY_DESCRIPTOR_FILENAME}"
  else
    data="{
    \"name\": \"${BINTRAY_PACKAGE}\",
    \"desc\": \"auto\",
    \"desc_url\": \"auto\",
    \"labels\": [\"bash\", \"example\"]
    }"
  fi
  output=$(${CURL} --write-out %{http_code} --silent --output /dev/null -X POST -d "${data}" ${API}/packages/${BINTRAY_SUBJECT}/${BINTRAY_REPO})
  echostatus "Package upload returned status $output"
  if [ $output -eq 201 ]; then
    echo 1
  fi
}

deploy_bottle() {
  if [ $(upload_content) ]; then
    echostatus "Publishing ${BOTTLE}..."
    output=$(${CURL} --write-out %{http_code} --silent --output /dev/null -X POST ${API}/content/${BINTRAY_SUBJECT}/${BINTRAY_REPO}/${BINTRAY_PACKAGE}/${BOTTLE_VERSION}/publish -d "{ \"discard\": \"false\" }")
    echostatus "Content publish returned status $output"
    if [ $output -eq 200 ]; then
      echo 1
    fi
  else
    echostatus "[SEVERE] First you should upload your bottle ${BOTTLE}"
  fi
}

upload_content() {
  echostatus "Uploading ${BOTTLE}..."
  output=$(${CURL} --write-out %{http_code} --silent --output /dev/null -T ${BOTTLE} -H X-Bintray-Package:${BINTRAY_PACKAGE} -H X-Bintray-Version:${BOTTLE_VERSION} ${API}/content/${BINTRAY_SUBJECT}/${BINTRAY_REPO}/${BOTTLE})
  echostatus "Content upload returned status $output"
  if [ $output -eq 201 ]; then
    echo 1
  fi
}

main "$@"
