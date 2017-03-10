# continuous-deployment-automation

## Docker cmd
```
docker build -t heavy-api . # to build image
docker run -p 5000:5000 --name heavy heavy-api # to run container
```

## Puppet docs
```
puppet apply --hiera_config=$(pwd) --modulepath=$(pwd)/modules $(pwd)/environments/dev -e 'include users'
```
