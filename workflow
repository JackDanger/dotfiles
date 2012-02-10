
function task() {
  [[ $1 =~ ^\/ ]] && cd $1
  export task=`basename $1`
}
