it: build sync wait open

# chunk vendor css generates a unique name for each build so we need to remove old css before syncing
prune:
	aws s3 rm s3://quivlet/css/ --recursive

# good ole build cmd
build:
	 vue-cli-service build

# This command syncs the local repository (source) with the remote ${STAGE} repository (target).
# The remote repo is an S3 bucket and sets the bucket acl to public-read, as required to host a
# static website on s3. Finally, it excludes files that we don't care to host publicly.
# https://docs.aws.amazon.com/cli/latest/reference/s3/sync.html
sync: prune
	cd ./dist && aws s3 sync . s3://quivlet/ --acl public-read

# We do this to give AWS a second (or two) to propagate the sync command
wait:
	sleep 2

# Open the S3 URL in a private firefox window for best standards. The error message printed to the console following
# the make command isn't actually an error: https://www.gnu.org/software/make/manual/html_node/Error-Messages.html.
open:
	firefox http://quivlet.s3-website-us-east-1.amazonaws.com/