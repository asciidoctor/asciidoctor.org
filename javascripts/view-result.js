function toggle_result_block(result_block) {
  result_block.prev().toggleClass('stacked');
  result_block.toggle();
}

function insert_result_links() {
  $('.result').each(function(idx, node) {
    var result_block = $(node);
    var title_div = result_block.prev().find('.title');
    var view_result_link = $('<a class="view-result" href="#">view result</a>');
    title_div.append(view_result_link);
    view_result_link.on('click', function(event) {
      event.preventDefault();
      toggle_result_block(result_block);
    });
  });
}

$(insert_result_links);
