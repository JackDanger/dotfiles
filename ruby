alias bedit='bundle open'
alias be='bundle exec ' # Leave a trailing space to allow further expansion
alias routes='bundle exec rails routes | less'
alias migrate='bundle exec rails db:migrate db:test:prepare'
alias last_migration="vim \`find db/migrate/ | sort | tail -n 1\`"
alias ru=chruby
function def {
  local phrase=$1
  phrase='(def|class|module) (self.)?'$phrase
  ag $phrase $2
}

# Rails ctags support
alias rtags='ctags -R --languages=ruby --exclude=.git --exclude=log . $(which bundle &>/dev/null && bundle list --paths | grep -v "The dependency")'

# RSpec
function rspec_last {
  local last_changed=$(last_spec)
  local line=$1
  local args=$(tr -s ' ' ' ' <<< "-c $2 $3 $4 $5")

  if [ -n "$line" ]; then
    line=":$line"
  fi

  if [[ -f bin/rspec ]] && [[ -z $SKIP_SPRING ]]; then
    cmd="bin/rspec $args $last_changed$line"
  else
    cmd="rspec $args $last_changed$line"
    if which bundle > /dev/null; then
      cmd="bundle exec $cmd"
    fi
  fi

  echo $cmd
  eval $cmd
}
function last_spec {
  find spec -type f -name *_spec.rb -exec ls -1t "{}" + | head -n 1
}

function rubofix_last {
  dir=${1:-.}
  last=$(find ${dir} -type f -name *.rb -exec ls -1t "{}" + | head -n 1)
  echo rubocop -a ${last}
  rubocop -a ${last}
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
