# merijntjetak/statsd
This docker image runs the statsd data aggregator. There are already dozens of statsd images available, but this one is configurable through environment variables (for easy Ansible integration).

## Usage
Example usage:
```
docker run -e GRAPHITE_HOST=192.0.2.1 \
           -e GRAPHITE_PORT=2003 \
           -e STATSD_PORT=8125 \
           -e DELETECOUNTERS=false \
           -e FLUSHINTERVAL=10000 \
           merijntjetak/statsd
```

Options are set through environment variables, the following variables are available:

| Environment variable  | Description                                                     |
|-----------------------|-----------------------------------------------------------------|
| GRAPHITE_HOST         | Graphite host to connect to (default: localhost)                |
| GRAPHITE_PORT         | Graphite port to connect to (default: 2003)                     |
| STATSD_PORT           | Statsd port (default: 8125)                                     |
| DELETECOUNTERS        | Control caching for counters (default: true)                    |
| FLUSHINTERVAL         | Statsd flush interval (in ms, default: 10000)                   |

## Development
The `make.sh` script is available for building, running and publishing the image. When using the script, make sure to update the variables in the top section.

## Ansible
The image can easily be deployed through Ansible. Use the following code snippet as an example to deploy the image:
```
- name: Start statsd
  docker_container:
    name: statsd
    state: started
    restart_policy: unless-stopped
    image: "merijntjetak/statsd"
    recreate: "{{ statsd_restart_docker|default('no') }}"
    network_mode: host
    env:
      GRAPHITE_HOST: "{{ net_graphite_host }}"
      GRAPHITE_PORT: "{{ net_graphite_port }}"
      STATSD_PORT: "{{ statsd_port }}"
      DELETECOUNTERS: "false"
      FLUSHINTERVAL: "10000"
```

## Acknowledgement
Development of this component was sponsored by Liberty Global B.V. (www.libertyglobal.com).
