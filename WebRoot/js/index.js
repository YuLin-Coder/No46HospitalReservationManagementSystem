/*
 * 自己的JS脚步
 * @Date:   2017-10-31 10:59:26
 * @Last Modified by:   shuangyulin
 */

'use strict';

$(function() {
  // 当文档加载完成才会执行
  /**
   * 根据屏幕宽度的变化决定轮播图片应该展示什么
   * @return {[type]} [description]
   */
  function resize() {
    // 获取屏幕宽度
    var windowWidth = $(window).width();
    // 判断屏幕属于大还是小
    var isSmallScreen = windowWidth < 768;
    // 根据大小为界面上的每一张轮播图设置背景
    // $('#main_ad > .carousel-inner > .item') // 获取到的是一个DOM数组（多个元素）
    $('#main_ad > .carousel-inner > .item').each(function(i, item) {
      // 因为拿到是DOM对象 需要转换
      var $item = $(item);
      // var imgSrc = $item.data(isSmallScreen ? 'image-xs' : 'image-lg');
      var imgSrc =
        isSmallScreen ? $item.data('image-xs') : $item.data('image-lg');

      // 设置背景图片
      $item.css('backgroundImage', 'url("' + imgSrc + '")');
      //
      // 因为我们需要小图时 尺寸等比例变化，所以小图时我们使用img方式
      if (isSmallScreen) {
        $item.html('<img src="' + imgSrc + '" alt="" />');
      } else {
        $item.empty();
      }
    });
  }

  $(window).on('resize', resize).trigger('resize');
   
 
  // 1. 获取手指在轮播图元素上的一个滑动方向（左右）
  // 获取界面上的轮播图容器
  var $carousels = $('.carousel');
  var startX, endX;
  var offset = 50;
  // 注册滑动事件
  $carousels.on('touchstart', function(e) {
    // 手指触摸开始时记录一下手指所在的坐标X
    startX = e.originalEvent.touches[0].clientX;
    // console.log(startX);
  });

  $carousels.on('touchmove', function(e) {
    // 变量重复赋值
    endX = e.originalEvent.touches[0].clientX;
    // console.log(endX);
  });
  $carousels.on('touchend', function(e) {
    console.log(e);
    // 结束触摸一瞬间记录最后的手指所在坐标X
    // 比大小
    // console.log(endX);
    // 控制精度
    // 获取每次运动的距离，当距离大于一定值时认为是有方向变化
    var distance = Math.abs(startX - endX);
    if (distance > offset) {
      // 有方向变化
      // console.log(startX > endX ? '←' : '→');
      // 2. 根据获得到的方向选择上一张或者下一张
      //     - $('a').click();
      //     - 原生的carousel方法实现 http://v3.bootcss.com/javascript/#carousel-methods
      $(this).carousel(startX > endX ? 'next' : 'prev');
    }
  });
  
  
  
  
  /*小屏幕导航点击关闭菜单*/
  $('.navbar-collapse a').click(function(){
  	$(this).css("background","lightgreen");
      $('.navbar-collapse').collapse('hide');
  });
  //new WOW().init();

});
