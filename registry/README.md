Use Private Docker Registry
================================

### Start the registry
```
vagrant ssh		# ssh to the docker host VM

bin/db start registry

```

### Tag a image and push
```
docker tag <image> :5000/<image_name>:[TAG]

docker push :5000/<image_name>

```

### Search
```
curl  http://localhost:5000/v1/search?q= | python -m json.tool
```

### Pull
```
docker pull :5000/<image_name>
```

### Stop the registry
```
bin/db stop registry

```
