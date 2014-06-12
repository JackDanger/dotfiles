alias bedit='EDITOR=subl bundle open'
alias routes='rake routes | less'
alias clone='rake db:test:clone_structure'
alias restart='touch tmp/restart.txt'
alias migrate='rake db:migrate db:test:prepare db:schema:dump'
alias last_migration="vim \`find db/migrate/ | tail -n 1\`"
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
