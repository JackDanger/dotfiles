
function task() {
  [[ $1 =~ ^\/ ]] && cd $1
  if [[ $1 == '' ]]; then
    [[ $task == '' ]] && echo "Enter a directory or a task that you're currently working on"
    export task="";
  else
    export task=`basename $1`
  fi
}
