# CLI Image
## Purpose

This image is to help provide common CLI tools for development workstations or in CI pipelines. It provides CLI tools to various products so that you don't have to have all of them installed, or that one single image in CI pipelines can provide a "one-stop-shop" for getting those tools.

## CLI tools provided

* CloudFoundry CLI
* OpenShift CLI
* AWS CLI
* [aws-amicleaner](https://github.com/bonclay7/aws-amicleaner)
* PostgreSQL client
* MySQL client
* JQ

## Usage
By default, **solidyn/cli** starts up a bash shell as the `cli` user, and in the `/data` directory.
You can then use whatever tools you want interactively. For scripted usage (ie. in a CI pipeline), you can specify the tool you want to call.
For example:
```
docker run --rm -i solidyn/cli aws s3 cp myfile.txt s3://examplebucket/
```

For real usage though, you probably want to pass in environment variables for authentication to the tools. Alternatively you can use volume mounts:
```
docker run --rm -i -v ~/.aws:/home/cli/.aws solidyn/cli aws s3 cp myfile.txt s3://examplebucket/
```
or, to add filesystem content from your working directory:
```
docker run --rm -i -v ~/.aws:/home/cli/.aws -v $(pwd):/data aws solidyn/cli s3 cp myfile.txt s3://examplebucket/
```
