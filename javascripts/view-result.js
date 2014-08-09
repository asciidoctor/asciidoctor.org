function toggle_result_block(e) {
  this.prev().toggleClass('stacked');
  this.toggle();
  return false;
}

function insert_result_links() {
  $('.result').each(function(idx, node) {
    znode = $(node);
    title_div = znode.prev().find('.title')
    //title_div.append('<a class="view-result" href="#">[ view result ]</a>');
    title_div.append('<a class="view-result" href="#">view result</a>');
    view_result_link = title_div.children().last();
    view_result_link.on('click', $.proxy(toggle_result_block, znode));
  });
}

/*
function insert_result_links_alt() {
  $('.reveal-modal').each(function(idx, el) {
    znode = $(node);
    reveal_id = znode.attr('id'); 
    znode.prev().find('.title').append('<a class="view-result" href="#" data-reveal-id="' + reveal_id + '">[ view result ]</a>');
  }
}
*/

$(insert_result_links);
