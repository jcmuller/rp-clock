require 'lib/easing'

class PolarClock < Processing::App
  include Easing

  attr_accessor :app_size, :fps

  def setup
    @app_size = 200
    reset!
    #setting up a variable, since this is never exact
    @fps = 30
    frame_rate fps
    color_mode HSB, 1.0
    stroke_cap SQUARE
    smooth
    @count = 0
    #text_font load_font("HelveticaNeue-32.vlw")
    text_font create_font("HelveticaNeue-Light", app_size/8.5)
    text_align RIGHT

    @s_w   = text_width("s")
    @m_w   = text_width("m")
    @h_w   = text_width("h")
  end

  def reset!
    size(app_size, app_size)
    frame.set_size(app_size - 10, app_size + 10)
    @radius = width/2.0 * 0.8
  end

  def load_menu_item(m)
  end

  def draw
    background(1, 0)
    draw_marks
    render_sections hour, minute, second

    if @s != second
      @count = 0
      @s = second
    end

    @count += 1
    draw_center
  end

  def render_sections h, m, s
    render_section @radius / 3.0,       h, 24, m, 60
    render_section @radius / 3.0 * 2.0, m, 60, s, 60
    render_section @radius,             s, 60, @count % @fps, @fps

    render_text h, m, s
  end

  def stroke_color r
    stroke *color_for_radius(r)
  end

  def fill_color r
    fill *color_for_radius(r)
  end

  def color_for_radius r
    [r.to_f / @radius.to_f, 1, 0.75]
  end

  def draw_marks
    fill 0.2, 0.2, 0.2
    no_stroke
    draw_marks_for_radius @radius / 3.0 * 1.0, 24
    draw_marks_for_radius @radius / 3.0 * 2.0, 60
    draw_marks_for_radius @radius / 3.0 * 3.0, 60
  end

  def draw_center
    no_stroke
    fill 0.2, 0.2, 0.2
    ellipse width/2.0, height/2.0, 10, 10
  end

  def draw_marks_for_radius r, total
    (0...total).each do |value|
      alpha = 360.0 / total.to_f * value.to_f
      a = (90 - alpha).to_f * Math::PI / 180.0
      x = width / 2.0 + r * Math.cos(a)
      y = height / 2.0 - r * Math.sin(a)
      ellipse x, y, 2.0, 2.0
    end
  end

  def render_section r, t, max, other = 0, other_max = 1
    base_angle = -Math::PI / 2.0
    circ = 2.0 * Math::PI
    angle = 0

    if t == 0
      angle = circ - easeInOutQuad((@count % @fps).to_f, 0.0, circ - circ / max.to_f, @fps.to_f)
      alpha = 1 - easeInOutQuad(other.to_f, 0.0, 0.5, other_max.to_f)
      stroke r.to_f / @radius.to_f, 1, 0.75, alpha
    else
      a = easeInOutQuad(other.to_f, 0.0, other.to_f / other_max.to_f, other_max.to_f)
      angle = (t.to_f / max.to_f) * circ + a * circ / max.to_f
      stroke_color r
    end

    stroke_weight @radius / 4.0
    no_fill
    arc width/2.0, height/2.0, 2.0*r,  2.0*r,  base_angle,  angle  +  base_angle
  end

  def render_text h, m, s
    fill 0.3, 0.3, 0.3

    s_n_w = text_width(sprintf "%02d", s)
    m_n_w = text_width(sprintf "%02d", m)
    text("s", width - 10                              , height - 10)
    text("m", width - 10 - @s_w - s_n_w               , height - 10)
    text("h", width - 10 - @s_w - s_n_w - @m_w - m_n_w, height - 10)

    fill_color @radius
    text((sprintf "%02d", s), width - 10 - @s_w                              , height - 10)
    fill_color @radius / 3.0 * 2.0
    text((sprintf "%02d", m), width - 10 - @s_w - s_n_w - @m_w               , height - 10)
    fill_color @radius / 3.0
    text((sprintf "%02d", h), width - 10 - @s_w - s_n_w - @m_w - m_n_w - @h_w, height - 10)
  end
end
