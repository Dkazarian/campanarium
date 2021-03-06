window.twttr = (function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0],
    t = window.twttr || {};
  if (d.getElementById(id)) return t;
  js = d.createElement(s);
  js.id = id;
  js.src = "https://platform.twitter.com/widgets.js";
  fjs.parentNode.insertBefore(js, fjs);

  t._e = [];
  t.ready = function(f) {
    t._e.push(f);
  };

  return t;
}(document, "script", "twitter-wjs"));

twttr.ready(function(twttr){
  twttr.events.bind('loaded', function(event){
    $(".twits").masonry({
      itemSelector: ".tweet-container",
      gutter: 5
    })
    $(".twits").on("msnry-element-removed", function(event, element){
      $(".twits").masonry("remove", element).masonry("layout");
    })
  });
});