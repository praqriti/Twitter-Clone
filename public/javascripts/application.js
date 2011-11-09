(function($){
  var tweet_section = $("#tweet"),
      tweet = tweet_section.find('textarea'),
      tweet_length = $("#tweet_length");
  tweet.keydown(function(){
    tweet_length.html(140 - this.value.length);
  });
  tweet_section.find("form").submit(function(){
    var form = $(this);
    $.post(form.attr('action'), form.serialize(), function(data){
      if(data){
        window.location.reload(true); 
      }else{
        alert("OOPS! Something went wrong!");
      }
    }, 'json');
    return false;
  });
})(jQuery);
