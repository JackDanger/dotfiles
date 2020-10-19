
##  TODO:
##  * weeks should start from the cohort start date
##  * end_date is real, or treat it as such
##  * start by pasting Athena results into Google Sheets
##    * then use Athena backend for Sheets itself
##  * milestone: downloadable version. EOW
##  * milestone: get Veronica's eyes on it next week. 


athena-query() {
  set -x
  set -uo pipefail

  local source=$1
  local workgroup=${2:-primary}

  local sql=''
  if [[ -f $source ]]; then
    sql=$(sed 's/--.*$//g'  $source)
  else
    sql=$source
  fi

  local execution_id=$(aws athena start-query-execution --query-string "$sql" --work-group $workgroup | jq -r .QueryExecutionId)
  if [[ $? -ne 0 ]]; then
    >&2 echo $execution_id
    exit 1
  fi
  
  while [[ "RUNNING" == "$(athena-query-status $execution_id)" ]]; do
   echo -n .
   sleep 1
  done
  aws athena get-query-results --query-execution-id $execution_id ${@:2}
}

athena-query-status() {
  set -x
  local execution_id=$1
  aws athena get-query-execution --query-execution-id $execution_id | jq -r .QueryExecution.Status.State
}
