
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

{%- if theme.denglong— %}
<!-- 灯笼1 -->
<div class="deng-box">
    <div class="deng">
        <div class="xian"></div>
        <div class="deng-a">
            <div class="deng-b"><div class="deng-t">瓜</div></div>
        </div>
        <div class="shui shui-a"><div class="shui-c"></div><div class="shui-b"></div></div>
    </div>
</div>
 
<!-- 灯笼2 -->
<div class="deng-box1">
    <div class="deng">
        <div class="xian"></div>
        <div class="deng-a">
            <div class="deng-b"><div class="deng-t">木</div></div>
        </div>
        <div class="shui shui-a"><div class="shui-c"></div><div class="shui-b"></div></div>
    </div>
</div>

{%- endif %}