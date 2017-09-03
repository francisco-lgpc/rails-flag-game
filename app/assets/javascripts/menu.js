$(document).ready(function(){
  $('.icons').toggle();

  $(".menu-elem").hover(function(){
    var w = $(this).find('.link-text').width()

    $(':focus').not(this).blur();

    $(this).find('.icons').toggle();
    $(this).find('.link-text').toggle();

    $(this).find('.icons').line(w * .2, 13, w * .3, 13,  { color: 'rgba(255, 111, 89, 1)', stroke: 1.5 } )
    $(this).find('.icons').line(w * .7, 13, w * .8, 13,  { color: 'rgba(255, 111, 89, 1)', stroke: 1.5 } )
  }, function(){
    $(this).find('.icons').toggle();
    $(this).find('.link-text').toggle();
  });

  $(".menu-elem").focus(function(){
    var w = $(this).find('.link-text').width()

    $(this).find('.icons').toggle();
    $(this).find('.link-text').toggle();

    $(this).find('.icons').line(w * .2, 13, w * .3, 13,  { color: 'rgba(255, 111, 89, 1)', stroke: 1.5 } )
    $(this).find('.icons').line(w * .7, 13, w * .8, 13,  { color: 'rgba(255, 111, 89, 1)', stroke: 1.5 } )

    $('.menu').css('box-shadow', '2px 8px 16px 0px rgba(80,80,80,0.3), 2px 6px 20px 0px rgba(80,80,80,0.5)').css('margin', '38px auto;');

  });

  $(".menu-elem").blur(function() {
    $(this).find('.icons').toggle();
    $(this).find('.link-text').toggle();

    //$('.menu').css('box-shadow', '2px 4px 8px 0px rgba(120,120,120,0.3), 2px 2px 14px 0px rgba(120,120,120,0.5)').css('margin', '40px auto;');

  });

  $(document).keydown(
    function(e)
    {
      if (e.keyCode == 40) {
        console.log('down')
        if($(".menu-elem:focus").closest('li').is(':last-child') || $(".menu-elem:focus").size() == 0 ){
          $(".menu-elem").first().focus();
        }else {
          $(".menu-elem:focus").closest('li').next().find('.menu-elem').focus();
        }
      }else if (e.keyCode == 38) {
        console.log('up')
        if($(".menu-elem:focus").closest('li').is(':first-child')){
          $(".menu-elem").last().focus();
        }else {
          $(".menu-elem:focus").closest('li').prev().find('.menu-elem').focus();
        }
      }
    }
  );
});
