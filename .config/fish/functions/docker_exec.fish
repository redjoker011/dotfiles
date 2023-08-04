function docker_exec --description "Access docker container using bash shell in interactive mode using container id as argument"
  docker exec -it $argv bash
end
