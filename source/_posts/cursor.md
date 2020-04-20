---
title: Hexo优化，Next7主题添加鼠标点击效果
date: 2020-03-30 20:35:38
tags: Hexo
---

记录一下吧，应该是比较详细，比较完善的教程啦，并且在之前的点击效果基础上做了进阶。

目前有点击的爱心效果，富强文明的文字效果，爆炸效果，烟花效果，以及博客正在使用的canvas效果。

### 修改config.xml

在next主题下的config.xml添加以下内容。这里喜欢什么点击效果就把type：修改为响应的效果。

```
cursor_effect:
  enabled: true
  type: canvas # fireworks：礼花 | explosion：爆炸 | love：浮出爱心 | text：浮出文字 | canvas：唯美爆炸
```

<!--more-->

### 新建相关文件

1.在next主题文件夹下的layout文件下，新建一个`_ck`文件夹，这个名字比较随意，这个文件夹是我姓名首字母缩写，个人觉得比较方便管理，也可以叫`_custom`,都可以。

2.在新建的文件夹下新建`cursor.swig`文件,写入以下内容：

#### cursor.swig

```javascript

{%- if theme.cursor_effect %}
  {%- if theme.cursor_effect.type == "fireworks" %}
    {{- next_js('click-firework.js')}}
  {%- elseif theme.cursor_effect.type == "explosion" %}
    <canvas class="fireworks" style="position: fixed;left: 0;top: 0;z-index: 1; pointer-events: none;" ></canvas>
    <script src="//cdn.bootcss.com/animejs/2.2.0/anime.min.js"></script>
    {{- next_js('click-explosion.js')}}
  {%- elseif theme.cursor_effect.type == "love" %}
    {{- next_js('click-love.js')}}
  {%- elseif theme.cursor_effect.type == "canvas" %}
    <div id="clickCanvas" style=" position:fixed;left:0;top:0;z-index:999999999;pointer-events:none;"></div>
    {{- next_js('click-canvas.js')}}
  {%- elseif theme.cursor_effect.type == "text" %}
    {{- next_js('jquery.min.js')}}
    {{- next_js('click-text.js')}}
  {%- endif %}
{%- endif %}
```

3.在next主题下的source文件下的js文件夹下新建click-canvas.js，click-explosion.js，click-firework.js，click-love.js，click-text.js，jquery.min.js（选择文字效果需要使用，可以去网上搜索，js文件过大，本文不展示）。并写入以下内容

#### click-canvas.js

```javascript
/*
 * 鼠标点击特效，canvas点击效果，第二版
 * 原文地址：https://www.iowen.cn/canvas-click-effect-second-edition
 */
/* Copyright (C) 2013 Justin Windle sketch.min.js, http://soulwire.co.uk */
var Sketch=function(){"use strict";function e(e){return"[object Array]"==Object.prototype.toString.call(e)}function t(e){return"function"==typeof e}function n(e){return"number"==typeof e}function o(e){return"string"==typeof e}function r(e){return E[e]||String.fromCharCode(e)}function i(e,t,n){for(var o in t)(n||!e.hasOwnProperty(o))&&(e[o]=t[o]);return e}function u(e,t){return function(){e.apply(t,arguments)}}function a(e){var n={};for(var o in e)n[o]=t(e[o])?u(e[o],e):e[o];return n}function c(e){function n(n){t(n)&&n.apply(e,[].splice.call(arguments,1))}function u(e){for(_=0;_<J.length;_++)G=J[_],o(G)?O[(e?"add":"remove")+"EventListener"].call(O,G,k,!1):t(G)?k=G:O=G}function c(){L(T),T=I(c),U||(n(e.setup),U=t(e.setup),n(e.resize)),e.running&&!j&&(e.dt=(B=+new Date)-e.now,e.millis+=e.dt,e.now=B,n(e.update),e.autoclear&&K&&e.clear(),n(e.draw)),j=++j%e.interval}function l(){O=Y?e.style:e.canvas,D=Y?"px":"",e.fullscreen&&(e.height=w.innerHeight,e.width=w.innerWidth),O.height=e.height+D,O.width=e.width+D,e.retina&&K&&X&&(O.height=e.height*X,O.width=e.width*X,O.style.height=e.height+"px",O.style.width=e.width+"px",e.scale(X,X)),U&&n(e.resize)}function s(e,t){return N=t.getBoundingClientRect(),e.x=e.pageX-N.left-w.scrollX,e.y=e.pageY-N.top-w.scrollY,e}function f(t,n){return s(t,e.element),n=n||{},n.ox=n.x||t.x,n.oy=n.y||t.y,n.x=t.x,n.y=t.y,n.dx=n.x-n.ox,n.dy=n.y-n.oy,n}function g(e){if(e.preventDefault(),W=a(e),W.originalEvent=e,W.touches)for(M.length=W.touches.length,_=0;_<W.touches.length;_++)M[_]=f(W.touches[_],M[_]);else M.length=0,M[0]=f(W,V);return i(V,M[0],!0),W}function h(t){for(t=g(t),q=(Q=J.indexOf(z=t.type))-1,e.dragging=/down|start/.test(z)?!0:/up|end/.test(z)?!1:e.dragging;q;)o(J[q])?n(e[J[q--]],t):o(J[Q])?n(e[J[Q++]],t):q=0}function p(t){F=t.keyCode,H="keyup"==t.type,Z[F]=Z[r(F)]=!H,n(e[t.type],t)}function v(t){e.autopause&&("blur"==t.type?b:C)(),n(e[t.type],t)}function C(){e.now=+new Date,e.running=!0}function b(){e.running=!1}function P(){(e.running?b:C)()}function A(){K&&e.clearRect(0,0,e.width,e.height)}function S(){R=e.element.parentNode,_=x.indexOf(e),R&&R.removeChild(e.element),~_&&x.splice(_,1),u(!1),b()}var T,k,O,R,N,_,D,B,G,W,z,F,H,q,Q,j=0,M=[],U=!1,X=w.devicePixelRatio,Y=e.type==m,K=e.type==d,V={x:0,y:0,ox:0,oy:0,dx:0,dy:0},J=[e.element,h,"mousedown","touchstart",h,"mousemove","touchmove",h,"mouseup","touchend",h,"click",y,p,"keydown","keyup",w,v,"focus","blur",l,"resize"],Z={};for(F in E)Z[E[F]]=!1;return i(e,{touches:M,mouse:V,keys:Z,dragging:!1,running:!1,millis:0,now:0/0,dt:0/0,destroy:S,toggle:P,clear:A,start:C,stop:b}),x.push(e),e.autostart&&C(),u(!0),l(),c(),e}for(var l,s,f="E LN10 LN2 LOG2E LOG10E PI SQRT1_2 SQRT2 abs acos asin atan ceil cos exp floor log round sin sqrt tan atan2 pow max min".split(" "),g="__hasSketch",h=Math,d="canvas",p="webgl",m="dom",y=document,w=window,x=[],v={fullscreen:!0,autostart:!0,autoclear:!0,autopause:!0,container:y.body,interval:1,globals:!0,retina:!1,type:d},E={8:"BACKSPACE",9:"TAB",13:"ENTER",16:"SHIFT",27:"ESCAPE",32:"SPACE",37:"LEFT",38:"UP",39:"RIGHT",40:"DOWN"},C={CANVAS:d,WEB_GL:p,WEBGL:p,DOM:m,instances:x,install:function(t){if(!t[g]){for(var o=0;o<f.length;o++)t[f[o]]=h[f[o]];i(t,{TWO_PI:2*h.PI,HALF_PI:h.PI/2,QUATER_PI:h.PI/4,random:function(t,o){return e(t)?t[~~(h.random()*t.length)]:(n(o)||(o=t||1,t=0),t+h.random()*(o-t))},lerp:function(e,t,n){return e+n*(t-e)},map:function(e,t,n,o,r){return(e-t)/(n-t)*(r-o)+o}}),t[g]=!0}},create:function(e){return e=i(e||{},v),e.globals&&C.install(self),l=e.element=e.element||y.createElement(e.type===m?"div":"canvas"),s=e.context=e.context||function(){switch(e.type){case d:return l.getContext("2d",e);case p:return l.getContext("webgl",e)||l.getContext("experimental-webgl",e);case m:return l.canvas=l}}(),e.container.appendChild(l),C.augment(s,e)},augment:function(e,t){return t=i(t||{},v),t.element=e.canvas||e,t.element.className+=" sketch",i(e,t,!0),c(e)}},b=["ms","moz","webkit","o"],P=self,A=0,S="AnimationFrame",T="request"+S,k="cancel"+S,I=P[T],L=P[k],O=0;O<b.length&&!I;O++)I=P[b[O]+"Request"+S],L=P[b[O]+"Cancel"+T];return P[T]=I=I||function(e){var t=+new Date,n=h.max(0,16-(t-A)),o=setTimeout(function(){e(t+n)},n);return A=t+n,o},P[k]=L=L||function(e){clearTimeout(e)},C}();
//---
if(document.getElementById("clickCanvas")) {
    function Particle(x, y, radius) {
        this.init(x, y, radius);
    }
    Particle.prototype = {
        init : function(x, y, radius) {
            this.alive = true;
            this.radius = radius || 10;
            this.wander = 0.15;
            this.theta = random(TWO_PI);
            this.drag = 0.92;
            this.color = '#ffeb3b';
            this.x = x || 0.0;
            this.y = y || 0.0;
            this.vx = 0.0;
            this.vy = 0.0;
        },
        move : function() {
            this.x += this.vx;
            this.y += this.vy;
            this.vx *= this.drag;
            this.vy *= this.drag;
            this.theta += random(-0.5, 0.5) * this.wander;
            this.vx += sin(this.theta) * 0.1;
            this.vy += cos(this.theta) * 0.1;
            this.radius *= 0.96;
            this.alive = this.radius > 0.5;
        },
        draw : function(ctx) {
            ctx.beginPath();
            ctx.arc(this.x, this.y, this.radius, 0, TWO_PI);
            ctx.fillStyle = this.color;
            ctx.fill();
        }
    };
    var MAX_PARTICLES = 50;
    //圆点颜色库
    var COLOURS = [ "#5ee4ff", "#f44033", "#ffeb3b", "#F38630", "#FA6900", "#f403e8", "#F9D423" ];
    var particles = [];
    var pool = [];
    var clickparticle = Sketch.create({
        container : document.getElementById('clickCanvas')
    });
    clickparticle.spawn = function(x, y) {
        if (particles.length >= MAX_PARTICLES)
            pool.push(particles.shift());
        particle = pool.length ? pool.pop() : new Particle();
        particle.init(x, y, random(5, 20));//圆点大小范围
        particle.wander = random(0.5, 2.0);
        particle.color = random(COLOURS);
        particle.drag = random(0.9, 0.99);
        theta = random(TWO_PI);
        force = random(1, 5);
        particle.vx = sin(theta) * force;
        particle.vy = cos(theta) * force;
        particles.push(particle);
    };
    clickparticle.update = function() {
        var i, particle;
        for (i = particles.length - 1; i >= 0; i--) {
            particle = particles[i];
            if (particle.alive)
                particle.move();
            else
                pool.push(particles.splice(i, 1)[0]);
        }
    };
    clickparticle.draw = function() {
        clickparticle.globalCompositeOperation = 'lighter';
        for ( var i = particles.length - 1; i >= 0; i--) {
            particles[i].draw(clickparticle);
        }
    };
    //按下时显示效果，mousedown 换成 click 为点击时显示效果（我用的 click）
    document.addEventListener("mousedown", function(e) {
        var max, j;
        //排除一些元素
        "TEXTAREA" !== e.target.nodeName && "INPUT" !== e.target.nodeName && "A" !== e.target.nodeName && "I" !== e.target.nodeName && "IMG" !== e.target.nodeName 
        && function() {
            for (max = random(15, 20), j = 0; j < max; j++) 
            clickparticle.spawn(e.clientX, e.clientY);
        }();
    });
}
```

#### click-explosion

```javascript
"use strict";function updateCoords(e){pointerX=(e.clientX||e.touches[0].clientX)-canvasEl.getBoundingClientRect().left,pointerY=e.clientY||e.touches[0].clientY-canvasEl.getBoundingClientRect().top}function setParticuleDirection(e){var t=anime.random(0,360)*Math.PI/180,a=anime.random(50,180),n=[-1,1][anime.random(0,1)]*a;return{x:e.x+n*Math.cos(t),y:e.y+n*Math.sin(t)}}function createParticule(e,t){var a={};return a.x=e,a.y=t,a.color=colors[anime.random(0,colors.length-1)],a.radius=anime.random(16,32),a.endPos=setParticuleDirection(a),a.draw=function(){ctx.beginPath(),ctx.arc(a.x,a.y,a.radius,0,2*Math.PI,!0),ctx.fillStyle=a.color,ctx.fill()},a}function createCircle(e,t){var a={};return a.x=e,a.y=t,a.color="#F00",a.radius=0.1,a.alpha=0.5,a.lineWidth=6,a.draw=function(){ctx.globalAlpha=a.alpha,ctx.beginPath(),ctx.arc(a.x,a.y,a.radius,0,2*Math.PI,!0),ctx.lineWidth=a.lineWidth,ctx.strokeStyle=a.color,ctx.stroke(),ctx.globalAlpha=1},a}function renderParticule(e){for(var t=0;t<e.animatables.length;t++){e.animatables[t].target.draw()}}function animateParticules(e,t){for(var a=createCircle(e,t),n=[],i=0;i<numberOfParticules;i++){n.push(createParticule(e,t))}anime.timeline().add({targets:n,x:function(e){return e.endPos.x},y:function(e){return e.endPos.y},radius:0.1,duration:anime.random(1200,1800),easing:"easeOutExpo",update:renderParticule}).add({targets:a,radius:anime.random(80,160),lineWidth:0,alpha:{value:0,easing:"linear",duration:anime.random(600,800)},duration:anime.random(1200,1800),easing:"easeOutExpo",update:renderParticule,offset:0})}function debounce(e,t){var a;return function(){var n=this,i=arguments;clearTimeout(a),a=setTimeout(function(){e.apply(n,i)},t)}}var canvasEl=document.querySelector(".fireworks");if(canvasEl){var ctx=canvasEl.getContext("2d"),numberOfParticules=30,pointerX=0,pointerY=0,tap="mousedown",colors=["#FF1461","#18FF92","#5A87FF","#FBF38C"],setCanvasSize=debounce(function(){canvasEl.width=2*window.innerWidth,canvasEl.height=2*window.innerHeight,canvasEl.style.width=window.innerWidth+"px",canvasEl.style.height=window.innerHeight+"px",canvasEl.getContext("2d").scale(2,2)},500),render=anime({duration:1/0,update:function(){ctx.clearRect(0,0,canvasEl.width,canvasEl.height)}});document.addEventListener(tap,function(e){"sidebar"!==e.target.id&&"toggle-sidebar"!==e.target.id&&"A"!==e.target.nodeName&&"IMG"!==e.target.nodeName&&(render.play(),updateCoords(e),animateParticules(pointerX,pointerY))},!1),setCanvasSize(),window.addEventListener("resize",setCanvasSize,!1)}"use strict";function updateCoords(e){pointerX=(e.clientX||e.touches[0].clientX)-canvasEl.getBoundingClientRect().left,pointerY=e.clientY||e.touches[0].clientY-canvasEl.getBoundingClientRect().top}function setParticuleDirection(e){var t=anime.random(0,360)*Math.PI/180,a=anime.random(50,180),n=[-1,1][anime.random(0,1)]*a;return{x:e.x+n*Math.cos(t),y:e.y+n*Math.sin(t)}}function createParticule(e,t){var a={};return a.x=e,a.y=t,a.color=colors[anime.random(0,colors.length-1)],a.radius=anime.random(16,32),a.endPos=setParticuleDirection(a),a.draw=function(){ctx.beginPath(),ctx.arc(a.x,a.y,a.radius,0,2*Math.PI,!0),ctx.fillStyle=a.color,ctx.fill()},a}function createCircle(e,t){var a={};return a.x=e,a.y=t,a.color="#F00",a.radius=0.1,a.alpha=0.5,a.lineWidth=6,a.draw=function(){ctx.globalAlpha=a.alpha,ctx.beginPath(),ctx.arc(a.x,a.y,a.radius,0,2*Math.PI,!0),ctx.lineWidth=a.lineWidth,ctx.strokeStyle=a.color,ctx.stroke(),ctx.globalAlpha=1},a}function renderParticule(e){for(var t=0;t<e.animatables.length;t++){e.animatables[t].target.draw()}}function animateParticules(e,t){for(var a=createCircle(e,t),n=[],i=0;i<numberOfParticules;i++){n.push(createParticule(e,t))}anime.timeline().add({targets:n,x:function(e){return e.endPos.x},y:function(e){return e.endPos.y},radius:0.1,duration:anime.random(1200,1800),easing:"easeOutExpo",update:renderParticule}).add({targets:a,radius:anime.random(80,160),lineWidth:0,alpha:{value:0,easing:"linear",duration:anime.random(600,800)},duration:anime.random(1200,1800),easing:"easeOutExpo",update:renderParticule,offset:0})}function debounce(e,t){var a;return function(){var n=this,i=arguments;clearTimeout(a),a=setTimeout(function(){e.apply(n,i)},t)}}var canvasEl=document.querySelector(".fireworks");if(canvasEl){var ctx=canvasEl.getContext("2d"),numberOfParticules=30,pointerX=0,pointerY=0,tap="mousedown",colors=["#FF1461","#18FF92","#5A87FF","#FBF38C"],setCanvasSize=debounce(function(){canvasEl.width=2*window.innerWidth,canvasEl.height=2*window.innerHeight,canvasEl.style.width=window.innerWidth+"px",canvasEl.style.height=window.innerHeight+"px",canvasEl.getContext("2d").scale(2,2)},500),render=anime({duration:1/0,update:function(){ctx.clearRect(0,0,canvasEl.width,canvasEl.height)}});document.addEventListener(tap,function(e){"sidebar"!==e.target.id&&"toggle-sidebar"!==e.target.id&&"A"!==e.target.nodeName&&"IMG"!==e.target.nodeName&&(render.play(),updateCoords(e),animateParticules(pointerX,pointerY))},!1),setCanvasSize(),window.addEventListener("resize",setCanvasSize,!1)};

```

#### click-firework.js

```js
class Circle {
  constructor({ origin, speed, color, angle, context }) {
    this.origin = origin
    this.position = { ...this.origin }
    this.color = color
    this.speed = speed
    this.angle = angle
    this.context = context
    this.renderCount = 0
  }

  draw() {
    this.context.fillStyle = this.color
    this.context.beginPath()
    this.context.arc(this.position.x, this.position.y, 2, 0, Math.PI * 2)
    this.context.fill()
  }

  move() {
    this.position.x = (Math.sin(this.angle) * this.speed) + this.position.x
    this.position.y = (Math.cos(this.angle) * this.speed) + this.position.y + (this.renderCount * 0.3)
    this.renderCount++
  }
}

class Boom {
  constructor ({ origin, context, circleCount = 16, area }) {
    this.origin = origin
    this.context = context
    this.circleCount = circleCount
    this.area = area
    this.stop = false
    this.circles = []
  }

  randomArray(range) {
    const length = range.length
    const randomIndex = Math.floor(length * Math.random())
    return range[randomIndex]
  }

  randomColor() {
    const range = ['8', '9', 'A', 'B', 'C', 'D', 'E', 'F']
    return '#' + this.randomArray(range) + this.randomArray(range) + this.randomArray(range) + this.randomArray(range) + this.randomArray(range) + this.randomArray(range)
  }

  randomRange(start, end) {
    return (end - start) * Math.random() + start
  }

  init() {
    for(let i = 0; i < this.circleCount; i++) {
      const circle = new Circle({
        context: this.context,
        origin: this.origin,
        color: this.randomColor(),
        angle: this.randomRange(Math.PI - 1, Math.PI + 1),
        speed: this.randomRange(1, 6)
      })
      this.circles.push(circle)
    }
  }

  move() {
    this.circles.forEach((circle, index) => {
      if (circle.position.x > this.area.width || circle.position.y > this.area.height) {
        return this.circles.splice(index, 1)
      }
      circle.move()
    })
    if (this.circles.length == 0) {
      this.stop = true
    }
  }

  draw() {
    this.circles.forEach(circle => circle.draw())
  }
}

class CursorSpecialEffects {
  constructor() {
    this.computerCanvas = document.createElement('canvas')
    this.renderCanvas = document.createElement('canvas')

    this.computerContext = this.computerCanvas.getContext('2d')
    this.renderContext = this.renderCanvas.getContext('2d')

    this.globalWidth = window.innerWidth
    this.globalHeight = window.innerHeight

    this.booms = []
    this.running = false
  }

  handleMouseDown(e) {
    const boom = new Boom({
      origin: { x: e.clientX, y: e.clientY },
      context: this.computerContext,
      area: {
        width: this.globalWidth,
        height: this.globalHeight
      }
    })
    boom.init()
    this.booms.push(boom)
    this.running || this.run()
  }

  handlePageHide() {
    this.booms = []
    this.running = false
  }

  init() {
    const style = this.renderCanvas.style
    style.position = 'fixed'
    style.top = style.left = 0
    style.zIndex = '999999999999999999999999999999999999999999'
    style.pointerEvents = 'none'

    style.width = this.renderCanvas.width = this.computerCanvas.width = this.globalWidth
    style.height = this.renderCanvas.height = this.computerCanvas.height = this.globalHeight

    document.body.append(this.renderCanvas)

    window.addEventListener('mousedown', this.handleMouseDown.bind(this))
    window.addEventListener('pagehide', this.handlePageHide.bind(this))
  }

  run() {
    this.running = true
    if (this.booms.length == 0) {
      return this.running = false
    }

    requestAnimationFrame(this.run.bind(this))

    this.computerContext.clearRect(0, 0, this.globalWidth, this.globalHeight)
    this.renderContext.clearRect(0, 0, this.globalWidth, this.globalHeight)

    this.booms.forEach((boom, index) => {
      if (boom.stop) {
        return this.booms.splice(index, 1)
      }
      boom.move()
      boom.draw()
    })
    this.renderContext.drawImage(this.computerCanvas, 0, 0, this.globalWidth, this.globalHeight)
  }
}

const cursorSpecialEffects = new CursorSpecialEffects()
cursorSpecialEffects.init()
```

#### click-love.js

```javascript
!function(e,t,a){function n(){c(".heart{width: 10px;height: 10px;position: fixed;background: #f00;transform: rotate(45deg);-webkit-transform: rotate(45deg);-moz-transform: rotate(45deg);}.heart:after,.heart:before{content: '';width: inherit;height: inherit;background: inherit;border-radius: 50%;-webkit-border-radius: 50%;-moz-border-radius: 50%;position: fixed;}.heart:after{top: -5px;}.heart:before{left: -5px;}"),o(),r()}function r(){for(var e=0;e<d.length;e++)d[e].alpha<=0?(t.body.removeChild(d[e].el),d.splice(e,1)):(d[e].y--,d[e].scale+=.004,d[e].alpha-=.013,d[e].el.style.cssText="left:"+d[e].x+"px;top:"+d[e].y+"px;opacity:"+d[e].alpha+";transform:scale("+d[e].scale+","+d[e].scale+") rotate(45deg);background:"+d[e].color+";z-index:99999");requestAnimationFrame(r)}function o(){var t="function"==typeof e.onclick&&e.onclick;e.onclick=function(e){t&&t(),i(e)}}function i(e){var a=t.createElement("div");a.className="heart",d.push({el:a,x:e.clientX-5,y:e.clientY-5,scale:1,alpha:1,color:s()}),t.body.appendChild(a)}function c(e){var a=t.createElement("style");a.type="text/css";try{a.appendChild(t.createTextNode(e))}catch(t){a.styleSheet.cssText=e}t.getElementsByTagName("head")[0].appendChild(a)}function s(){return"rgb("+~~(255*Math.random())+","+~~(255*Math.random())+","+~~(255*Math.random())+")"}var d=[];e.requestAnimationFrame=function(){return e.requestAnimationFrame||e.webkitRequestAnimationFrame||e.mozRequestAnimationFrame||e.oRequestAnimationFrame||e.msRequestAnimationFrame||function(e){setTimeout(e,1e3/60)}}(),n()}(window,document);
```

#### click-text.js

```javascript
var a_idx = 0;
jQuery(document).ready(function($) {
  $("body").click(function(e) {
    var a = new Array("富强", "民主", "文明", "和谐", "自由", "平等", "公正" ,"法治", "爱国", "敬业", "诚信", "友善");
    var $i = $("<span/>").text(a[a_idx]);
    var x = e.pageX,
      y = e.pageY;
    $i.css({
      "z-index": 99999,
      "top": y - 28,
      "left": x - a[a_idx].length * 8,
      "position": "absolute",
      "color": "#ff7a45"
    });
    $("body").append($i);
    $i.animate({
      "top": y - 180,
      "opacity": 0
    }, 1500, function() {
      $i.remove();
    });
    a_idx = (a_idx + 1) % a.length;
  });
});

```

### 修改layout.swig

next主题文件下的layout.swig中在`</body>`前面添加

```
{% include '_ck/cursor.swig' %}
```

导入的文件夹的名字要和第一步创建的文件夹一致。