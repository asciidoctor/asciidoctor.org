function toggle_result_block(result_block) {
  result_block.prev().toggleClass('stacked');
  result_block.toggle();
}

function insert_result_links() {
  $('.result').each(function(idx, node) {
    var result_block = $(node);
    var title_div = result_block.prev().find('.title');
    //title_div.append('<a class="view-result" href="#">[ view result ]</a>');
    var view_result_link = $('<a class="view-result" href="#">view result</a>');
    title_div.append(view_result_link);
    view_result_link.on('click', function(event){
        event.preventDefault();
        toggle_result_block(result_block);
    });
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
