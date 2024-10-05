#!/bin/bash

# TODO@Students: Adjust these parameters to suit your needs
GROUP="group-218"
REPOSITORY="openmp"

echo "Now setting up your repository..."
PRIVATE_KEY_FILE="$(pwd)/.ssh/id_rsa"

# This is your repository access key. Don't share this or your repository will be accessible from the outside.
mkdir -p "$(pwd)/.ssh"
cat <<- EOF > "$PRIVATE_KEY_FILE"
-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----

EOF

chmod 600 "$PRIVATE_KEY_FILE"

export GIT_SSH_COMMAND="ssh -i '$PRIVATE_KEY_FILE' -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

echo "Cloning your repository..."
git clone "git@gitlab.lrz.de:lrr-tum/teaching/parprog/ss2021/project-material/${GROUP}/${REPOSITORY}.git" || exit 255

# Link the data directory. This is only needed for project 1.
if [ -e "${REPOSITORY}/data/" ]
then
  ln -s "$(pwd)/data/COAUTHORCS" "${REPOSITORY}/data/COAUTHORCS" || exit 255
fi

pushd "${REPOSITORY}" || exit 255

git config user.name "ParProg Submission Server"
git config user.email "noreply@parprog.caps.in.tum.de"

echo -e "\nNow running your tasks."
# You now have full access to your repository
# If you create large amounts of data, please remember to remove it to free up storage space from the submission server.

echo "The current directory is $(pwd). Directory listing:"
ls -la

# TODO@Students: Put your run commands here. Adjust these to make them work for your project.
make sequential
perf stat ./sequential

# TODO@Students If you need to, you can commit and push your changes/measurements by uncommenting the following lines:
# git add .
# git commit -m "ParProg Server Test"
# git push

popd || exit 255