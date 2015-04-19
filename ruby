alias bedit='EDITOR=subl bundle open'
alias routes='rake routes | less'
alias clone='rake db:test:clone_structure'
alias restart='touch tmp/restart.txt'
alias migrate='rake db:migrate db:test:prepare db:schema:dump'
alias last_migration="vim \`find db/migrate/ | tail -n 1\`"
function def {
  local phrase=$1
  phrase='(def|class|module) (self.)?'$phrase
  ag $phrase $2
}
# Rails
function sc {
  if [ -x ./script/console ]; then
    bundle exec ./script/console $@
  else
    bundle exec rails console $@
  fi
}
alias console='sc'
function sd {
  if [ -x ./script/dbconsole ]; then
    bundle exec ./script/dbconsole $@
  else
    bundle exec rails dbconsole $@
  fi
}
function ss {
  if [ -x ./script/server ]; then
    bundle exec ./script/server $@
  else
    bundle exec rails server $@
  fi
}

# RSpec
function rspec_last {
  local last_changed=$(find spec -type f -name *_spec.rb -exec ls -1t "{}" + | head -n 1)
  local line=$1
  local args=$(tr -s ' ' ' ' <<< "-c $2 $3 $4 $5")

  if [ -n "$line" ]; then
    line=":$line"
  fi

  if [[ -f bin/rspec ]] && [[ -z $SKIP_SPRING ]]; then
    cmd="bin/rspec $args $last_changed$line"
  else
    cmd="rspec $args $last_changed$line"
  fi

  echo $cmd
  eval $cmd
}
function rspec_time {
  local specs=$*
  bundle exec rspec $specs -f d -p 2>/dev/null
}

function naked_pry {
echo "%w(yard binding_of_caller byebug pry method_source coderay slop).each do |name|"
echo "  Dir[%Q|#{ENV['GEM_HOME']}/gems/#{name}-*|].each do |g|"
echo "    \$LOAD_PATH << %Q|#{g}/lib|"
echo "  end"
echo "end"
echo "require 'pry'"
}
