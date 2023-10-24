function docker_exec_container --description "Access docker container using bash shell in interactive mode"

  # We tell argparse about -h/--help and -s/--second - these are short and long forms of the same option.
  # The "--" here is mandatory, it tells it from where to read the arguments.
  argparse h/help n/name= -- $argv
  # exit if argparse failed because it found an option it didn't recognize - it will print an error
  or return

  # If -h or --help is given, we print a little help text and return
  if set -ql _flag_help
      echo "docker_exec_container [-h|--help] [-n|name] [ARGUMENT ...] [--name=] [ARGUMENT ...]"
      return 0
  end

  # Find container container the name is docker processes
  set -l container_id (command -q docker; and docker ps | grep $_flag_name | awk '{print $1}')

  # Access Container in Interactive Mode using bash shell
  docker exec -it $container_id bash
end
