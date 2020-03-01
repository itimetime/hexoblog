{%- if theme.rating.enable %}
  <div class="post-widgets">
    <div class="wp_rating">
      <div id="wpac-rating"></div>
    </div>
  </div>
{%- endif %}

{%- if theme.add_this_id %}
  <div class="addthis_inline_share_toolbox">
    <script src="//s7.addthis.com/js/300/addthis_widget.js#pubid={{ theme.add_this_id }}" async="async"></script>
  </div>
{%- endif %}
