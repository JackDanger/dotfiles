Group = function() {
  this.additions = []
  this.deletions = []
  this.add = function(line) {
    this.additions.push(line)
  }
  this.del = function(line) {
    this.deletions.push(line)
  }

  this.end = function() {
    console.log(this.additions.size, this.deletions.size)
  }
}

$(function(){
  $(".diff-table").each(function(){
    var table = this,
        currentGroup = new Group()

    $("tr", this).each(function(){
      var row       = this,
          line      = $("pre.line", this),
          match     = line.text().match(/^[-+]/),
          operation = match && match[0]

      console.log(operation)
      if ('-' == operation) {
        currentGroup.add(this)
      } else if ('+' == operation) {
        currentGroup.del(this)
      } else {
        currentGroup.end()
        currentGroup = new Group()
      }
    })
  })
})
