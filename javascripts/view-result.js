function toggle_result_block(result_block) {
  result_block.prev().toggleClass('stacked');
  result_block.toggle();
}

function insert_result_links() {
  $('.result').each(function(idx, node) {
    var result_block = $(node);
    var sample = result_block.prev();
    if (sample.hasClass('colist')) {
      sample = sample.prev();
    }
    var title_div = sample.find('.title');
    if (title_div.length == 0) {
      return 'continue';
    }
    var view_result_link = $('<a class="view-result" href="#">view result</a>');
    title_div.append(view_result_link);
    view_result_link.on('click', function(event) {
      event.preventDefault();
      toggle_result_block(result_block);
    });
  });
}

$(insert_result_links);
