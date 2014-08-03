Use Private Docker Registry
================================

### Start the registry

		vagrant ssh		# ssh to the docker host VM
		sudo dk start registry

### push a image

		dockpush <iamge_name>

### Search

		curl  http://localhost:5000/v1/search?q= | python -m json.tool

### Pull

		dockpull <image_name>


### Stop the registry

	sudo dk stop registry

